package org.gms.service;

import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.core.row.Row;
import lombok.AllArgsConstructor;
import org.gms.client.inventory.*;
import org.gms.dao.entity.CharactersDO;
import org.gms.dao.entity.InventoryequipmentDO;
import org.gms.dao.entity.InventoryitemsDO;
import org.gms.dao.entity.PetignoresDO;
import org.gms.dao.mapper.*;
import org.gms.exception.BizException;
import org.gms.model.dto.*;
import org.gms.server.ItemInformationProvider;
import org.gms.util.CashIdGenerator;
import org.gms.util.I18nUtil;
import org.gms.util.RequireUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

import static com.mybatisflex.core.query.QueryMethods.distinct;
import static org.gms.dao.entity.table.CharactersDOTableDef.CHARACTERS_D_O;
import static org.gms.dao.entity.table.InventoryequipmentDOTableDef.INVENTORYEQUIPMENT_D_O;
import static org.gms.dao.entity.table.InventoryitemsDOTableDef.INVENTORYITEMS_D_O;
import static org.gms.dao.entity.table.PetignoresDOTableDef.PETIGNORES_D_O;

@Transactional
@Service
@AllArgsConstructor
public class InventoryService {
    private final InventoryitemsMapper inventoryitemsMapper;
    private final InventoryequipmentMapper inventoryequipmentMapper;
    private final RingsMapper ringsMapper;
    private final PetsMapper petsMapper;
    private final PetignoresMapper petignoresMapper;
    private final CharactersMapper charactersMapper;

    public List<InventoryTypeRtnDTO> getInventoryTypeList() {
        List<InventoryTypeRtnDTO> list = new ArrayList<>();
        for (InventoryType value : InventoryType.values()) {
            list.add(InventoryTypeRtnDTO.builder().inventoryType(value.getType()).name(value.getName()).build());
        }
        return list;
    }

    public Page<InventorySearchReqDTO> getCharacterList(InventorySearchReqDTO data) {
        QueryWrapper queryWrapper = QueryWrapper.create()
                .select(distinct(CHARACTERS_D_O.ID, CHARACTERS_D_O.NAME, CHARACTERS_D_O.ACCOUNTID))
                .from(INVENTORYITEMS_D_O.as("i"))
                .leftJoin(CHARACTERS_D_O.as("c")).on(INVENTORYITEMS_D_O.CHARACTERID.eq(CHARACTERS_D_O.ID))
                .where(INVENTORYITEMS_D_O.TYPE.eq(ItemFactory.INVENTORY.getValue()));
        if (data.getCharacterId() != null) queryWrapper.and(CHARACTERS_D_O.ID.eq(data.getCharacterId()));
        if (!RequireUtil.isEmpty(data.getCharacterName()))
            queryWrapper.and(CHARACTERS_D_O.NAME.like(data.getCharacterName()));
        Page<CharactersDO> paginate = inventoryitemsMapper.paginateAs(data.getPageNo(), data.getPageSize(), queryWrapper, CharactersDO.class);
        return new Page<>(
                paginate.getRecords().stream()
                        // 删除角色，但是没有删除背包这里查会出现空指针
                        .filter(Objects::nonNull)
                        .map(record -> {
                            InventorySearchReqDTO dto = new InventorySearchReqDTO();
                            dto.setCharacterId(record.getId());
                            dto.setCharacterName(record.getName());
                            dto.setOnlineStatus(getCharacterOnlineState(record.getId()));
                            return dto;
                        })
                        .toList(),
                paginate.getPageNumber(),
                paginate.getPageSize(),
                paginate.getTotalRow()
        );
    }

    public List<InventorySearchRtnDTO> getInventoryListFromDB(InventorySearchReqDTO data) {
        RequireUtil.requireNotNull(data.getInventoryType(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_EMPTY", "inventoryType"));
        RequireUtil.requireNotNull(data.getCharacterId(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_EMPTY", "characterId"));
        InventoryType inventoryType = InventoryType.getByType(data.getInventoryType());
        RequireUtil.requireNotNull(inventoryType, I18nUtil.getExceptionMessage("UNKNOWN_PARAMETER_VALUE", "inventoryType", data.getInventoryType()));
        List<Row> results = inventoryitemsMapper.selectListByQueryAs(QueryWrapper.create()
                .select(INVENTORYITEMS_D_O.ALL_COLUMNS, INVENTORYEQUIPMENT_D_O.ALL_COLUMNS)
                .from(INVENTORYITEMS_D_O.as("i"))
                .leftJoin(INVENTORYEQUIPMENT_D_O.as("e")).on(INVENTORYITEMS_D_O.INVENTORYITEMID.eq(INVENTORYEQUIPMENT_D_O.INVENTORYITEMID))
                // 只查询指定栏目
                .where(INVENTORYITEMS_D_O.INVENTORYTYPE.eq(data.getInventoryType()))
                // 只查询背包
                .and(INVENTORYITEMS_D_O.TYPE.eq(ItemFactory.INVENTORY.getValue()))
                .and(INVENTORYITEMS_D_O.CHARACTERID.eq(data.getCharacterId())), Row.class);

        List<InventorySearchRtnDTO> rtnDTOList = new ArrayList<>();
        for (Row obj : results) {

            // 直接整合，在线玩家就只是展示落库的数据，不能操作。
            rtnDTOList.add(buildByDb(obj));

        }
        return rtnDTOList;
    }

    @Transactional(rollbackFor = Exception.class)
    public void deleteInventoryByCharacterId(int cid) {
        QueryWrapper itemQueryWrapper = QueryWrapper.create().where(INVENTORYITEMS_D_O.CHARACTERID.eq(cid));
        List<InventoryitemsDO> inventoryItemsDOS = inventoryitemsMapper.selectListByQuery(itemQueryWrapper);
        List<Long> inventoryItemIds = inventoryItemsDOS.stream().map(InventoryitemsDO::getInventoryitemid).toList();
        if (inventoryItemIds.isEmpty()) {
            return;
        }
        List<Integer> petIds = inventoryItemsDOS.stream()
                .map(InventoryitemsDO::getPetid)
                .filter(Objects::nonNull)
                .distinct()
                .toList();
        if (!petIds.isEmpty()) {
            petsMapper.deleteBatchByIds(petIds);
            petIds.forEach(CashIdGenerator::freeCashId);
        }

        QueryWrapper equipmentQueryWrapper = QueryWrapper.create().where(INVENTORYEQUIPMENT_D_O.INVENTORYITEMID.in(inventoryItemIds));
        List<InventoryequipmentDO> inventoryEquipmentDOS = inventoryequipmentMapper.selectListByQuery(equipmentQueryWrapper);
        List<Integer> ringIds = inventoryEquipmentDOS.stream()
                .map(InventoryequipmentDO::getRingid)
                .filter(Objects::nonNull)
                .distinct()
                .toList();
        if (!ringIds.isEmpty()) {
            ringsMapper.deleteBatchByIds(ringIds);
            ringIds.forEach(CashIdGenerator::freeCashId);
        }
        inventoryequipmentMapper.deleteByQuery(equipmentQueryWrapper);
        inventoryitemsMapper.deleteByQuery(itemQueryWrapper);
    }


    private boolean getCharacterOnlineState(int characterId) {
        // 只查询loggedin 判断是否存在
        CharactersDO charactersDO = charactersMapper.selectOneByQuery(
                QueryWrapper.create()
                        .select(CHARACTERS_D_O.LOGGEDIN)
                        .where(CHARACTERS_D_O.ID.eq(characterId)));
        return charactersDO != null ? charactersDO.getLoggedin() : false;
    }


    private InventorySearchRtnDTO buildByDb(Row obj) {
        ItemInformationProvider ii = ItemInformationProvider.getInstance();
        InventorySearchRtnDTO rtnDTO = InventorySearchRtnDTO.builder()
                .id(obj.getLong("inventoryitemid"))
                .itemType(obj.getInt("type"))
                .characterId(obj.getInt("characterid"))
                .itemId(obj.getInt("itemid"))
                .inventoryType(obj.getByte("inventorytype"))
                .position(obj.getShort("position"))
                .quantity(obj.getShort("quantity"))
                .owner(obj.getString("owner"))
                .petId(obj.getInt("petid"))
                .flag(obj.getShort("flag"))
                .expiration(obj.getLong("expiration"))
                .giftFrom(obj.getString("giftFrom"))
                .online(false)
                .itemName(ii.getName(obj.getInt("itemid")))
                .build();
        Long inventoryEquipmentId = obj.getLong("inventoryequipmentid");
        if (inventoryEquipmentId != null) {
            rtnDTO.setEquipment(true);
            rtnDTO.setInventoryEquipment(InventoryEquipRtnDTO.builder()
                    .id(inventoryEquipmentId)
                    .inventoryItemId(obj.getLong("inventoryitemid"))
                    .upgradeSlots(obj.getByte("upgradeslots"))
                    .level(obj.getByte("level"))
                    .attStr(obj.getShort("str"))
                    .attDex(obj.getShort("dex"))
                    .attInt(obj.getShort("int"))
                    .attLuk(obj.getShort("luk"))
                    .hp(obj.getShort("hp"))
                    .mp(obj.getShort("mp"))
                    .pAtk(obj.getShort("watk"))
                    .mAtk(obj.getShort("matk"))
                    .pDef(obj.getShort("wdef"))
                    .mDef(obj.getShort("mdef"))
                    .acc(obj.getShort("acc"))
                    .avoid(obj.getShort("avoid"))
                    .hands(obj.getShort("hands"))
                    .speed(obj.getShort("speed"))
                    .jump(obj.getShort("jump"))
                    .locked(obj.getInt("locked"))
                    .vicious(obj.getShort("vicious"))
                    .itemLevel(obj.getByte("itemlevel"))
                    .itemExp(obj.getInt("itemexp"))
                    .ringId(obj.getInt("ringid"))
                    .build());
        }
        return rtnDTO;
    }

/*
    private List<InventorySearchRtnDTO> buildByOnline(Character character, InventoryType type) {
        Inventory inventory = character.getInventory(type);
        ItemInformationProvider ii = ItemInformationProvider.getInstance();
        return inventory.list().stream().map(item -> {
            InventorySearchRtnDTO rtnDTO = InventorySearchRtnDTO.builder()
                    .id(-1L)
                    .itemType(ItemFactory.INVENTORY.getValue())
                    .characterId(character.getId())
                    .itemId(item.getItemId())
                    .inventoryType(type.getType())
                    .position(item.getPosition())
                    .quantity(item.getQuantity())
                    .owner(item.getOwner())
                    .petId(item.getPetId())
                    .flag(item.getFlag())
                    .expiration(item.getExpiration())
                    .giftFrom(item.getGiftFrom())
                    .online(true)
                    .itemName(ii.getName(item.getItemId()))
                    .build();
            if (type.isEquip()) {
                Equip equip = (Equip) item;
                rtnDTO.setEquipment(true);
                rtnDTO.setInventoryEquipment(InventoryEquipRtnDTO.builder()
                        .id(-1L)
                        .inventoryItemId(-1L)
                        .upgradeSlots(equip.getUpgradeSlots())
                        .level(equip.getLevel())
                        .attStr(equip.getStr())
                        .attDex(equip.getDex())
                        .attInt(equip.getInt())
                        .attLuk(equip.getLuk())
                        .hp(equip.getHp())
                        .mp(equip.getMp())
                        .pAtk(equip.getWatk())
                        .mAtk(equip.getMatk())
                        .pDef(equip.getWdef())
                        .mDef(equip.getMdef())
                        .acc(equip.getAcc())
                        .avoid(equip.getAvoid())
                        .hands(equip.getHands())
                        .speed(equip.getSpeed())
                        .jump(equip.getJump())
                        .locked(0)
                        .vicious(equip.getVicious())
                        .itemLevel(equip.getItemLevel())
                        .itemExp(equip.getItemExp())
                        .ringId(equip.getRingId())
                        .build());
            }
            return rtnDTO;
        }).toList();
    }
*/

    @Transactional(rollbackFor = Exception.class)
    public void updateInventory(InventorySearchRtnDTO data) {
        modifyInventoryCheck(data);

        // 如果当前的玩家在线状态已经发生改变
        boolean isOnlineNow = getCharacterOnlineState(data.getCharacterId());
        if (isOnlineNow != data.isOnline()) {
            throw new BizException(I18nUtil.getExceptionMessage("InventoryService.updateInventory.exception1"));
        }
        if (isOnlineNow) {
            throw new BizException("不操作在线玩家装备！");
        } else {
            updateDb(data);
        }
    }



    private void updateDb(InventorySearchRtnDTO data) {
        InventoryitemsDO inventoryitemsDO = getModifyItemOffline(data);
        // 仅以下值可修改
        InventoryType type = InventoryType.getByType(data.getInventoryType());
        if (type.isEquip()) {
            // 修正数量
            if (data.getQuantity() != null && data.getQuantity() != 1) {
                data.setQuantity((short) 1);
            }
            InventoryEquipRtnDTO equipment = data.getInventoryEquipment();
            inventoryequipmentMapper.updateByQuery(InventoryequipmentDO.builder()
                            .upgradeslots(Optional.ofNullable(equipment.getUpgradeSlots()).map(Byte::intValue).orElse(null))
                            .level(Optional.ofNullable(equipment.getLevel()).map(Byte::intValue).orElse(null))
                            .str(Optional.ofNullable(equipment.getAttStr()).map(Short::intValue).orElse(null))
                            .dex(Optional.ofNullable(equipment.getAttDex()).map(Short::intValue).orElse(null))
                            .inte(Optional.ofNullable(equipment.getAttInt()).map(Short::intValue).orElse(null))
                            .luk(Optional.ofNullable(equipment.getAttLuk()).map(Short::intValue).orElse(null))
                            .hp(Optional.ofNullable(equipment.getHp()).map(Short::intValue).orElse(null))
                            .mp(Optional.ofNullable(equipment.getMp()).map(Short::intValue).orElse(null))
                            .watk(Optional.ofNullable(equipment.getPAtk()).map(Short::intValue).orElse(null))
                            .matk(Optional.ofNullable(equipment.getMAtk()).map(Short::intValue).orElse(null))
                            .wdef(Optional.ofNullable(equipment.getPDef()).map(Short::intValue).orElse(null))
                            .mdef(Optional.ofNullable(equipment.getMDef()).map(Short::intValue).orElse(null))
                            .acc(Optional.ofNullable(equipment.getAcc()).map(Short::intValue).orElse(null))
                            .avoid(Optional.ofNullable(equipment.getAvoid()).map(Short::intValue).orElse(null))
                            .hands(Optional.ofNullable(equipment.getHands()).map(Short::intValue).orElse(null))
                            .speed(Optional.ofNullable(equipment.getSpeed()).map(Short::intValue).orElse(null))
                            .jump(Optional.ofNullable(equipment.getJump()).map(Short::intValue).orElse(null))
                            .vicious(Optional.ofNullable(equipment.getVicious()).map(Short::intValue).orElse(null))
                            .build(),
                    QueryWrapper.create().where(INVENTORYEQUIPMENT_D_O.INVENTORYITEMID.eq(inventoryitemsDO.getInventoryitemid())));
        }
        inventoryitemsMapper.update(InventoryitemsDO.builder()
                .inventoryitemid(inventoryitemsDO.getInventoryitemid())
                .quantity(Optional.ofNullable(data.getQuantity()).map(Short::intValue).orElse(null))
                .expiration(data.getExpiration())
                .build());
    }

    @Transactional(rollbackFor = Exception.class)
    public void deleteInventory(InventorySearchRtnDTO data) {
        modifyInventoryCheck(data);

        boolean isOnlineNow = getCharacterOnlineState(data.getCharacterId());
        // 如果当前的玩家在线状态已经发生改变
        if (isOnlineNow != data.isOnline()) {
            throw new BizException(I18nUtil.getExceptionMessage("InventoryService.deleteInventory.exception1"));
        }
        if (isOnlineNow) {
            throw new BizException("不操作在线玩家装备！");
        } else {
            InventoryitemsDO inventoryitemsDO = getModifyItemOffline(data);
            inventoryequipmentMapper.deleteByQuery(QueryWrapper.create().where(INVENTORYEQUIPMENT_D_O.INVENTORYITEMID.eq(inventoryitemsDO.getInventoryitemid())));
            inventoryitemsMapper.deleteById(inventoryitemsDO.getInventoryitemid());
        }
    }

    public List<PetignoresDO> getPetIgnoreByPetId(Integer petId) {
        return petignoresMapper.selectListByQuery(QueryWrapper.create().where(PETIGNORES_D_O.PETID.eq(petId)));
    }

        /**
     * 添加宠物忽略物品列表
     *
     * @param petId 宠物 ID
     * @param itemIds 物品 ID 集合，将添加到宠物的忽略列表中
     */
    public void addPetIgnoreItems(Integer petId, Collection<Integer> itemIds) {
        if (petId == null || itemIds == null || itemIds.isEmpty()) {
            return;
        }
        petignoresMapper.insertBatch(itemIds.stream()
                .map(itemId -> PetignoresDO.builder()
                    .petid(petId)
                    .itemid(itemId)
                    .build())
                .collect(Collectors.toList()));
    }

        /**
         * 移除宠物忽略物品列表中的物品
         *
         * @param petId 宠物 ID
         * @param itemIds 物品 ID 集合，将从宠物的忽略列表中移除
         */
        public void removePetIgnoreItems(Integer petId, Collection<Integer> itemIds) {
            if (petId == null || itemIds == null || itemIds.isEmpty()) {
                return;
            }
            petignoresMapper.deleteByQuery(QueryWrapper.create()
                    .where(PETIGNORES_D_O.PETID.eq(petId))
                    .and(PETIGNORES_D_O.ITEMID.in(itemIds)));
        }

        /**
         * 删除宠物相关数据
         * 包括宠物的忽略物品列表和宠物本身的信息
         *
         * @param petId 宠物 ID
         */
        public void deletePetData(Integer petId) {
            if (petId == null) {
                return;
            }
            petignoresMapper.deleteByQuery(QueryWrapper.create().where(PETIGNORES_D_O.PETID.eq(petId)));
            petsMapper.deleteById(Long.valueOf(petId));
        }


    private void modifyInventoryCheck(InventorySearchRtnDTO data) {
        RequireUtil.requireNotNull(data.getItemId(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_EMPTY", "itemId"));
        RequireUtil.requireNotNull(data.getInventoryType(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_EMPTY", "inventoryType"));
        RequireUtil.requireNotNull(data.getCharacterId(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_EMPTY", "characterId"));
        RequireUtil.requireNotNull(data.getPosition(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_EMPTY", "position"));
        InventoryType inventoryType = InventoryType.getByType(data.getInventoryType());
        RequireUtil.requireNotNull(inventoryType, I18nUtil.getExceptionMessage("UNKNOWN_PARAMETER_VALUE", "inventoryType", data.getInventoryType()));
    }


    private InventoryitemsDO getModifyItemOffline(InventorySearchRtnDTO data) {
        QueryWrapper itemQueryWrapper = QueryWrapper.create()
                .where(INVENTORYITEMS_D_O.CHARACTERID.eq(data.getCharacterId()))
                .and(INVENTORYITEMS_D_O.ITEMID.eq(data.getItemId()))
                .and(INVENTORYITEMS_D_O.POSITION.eq(data.getPosition()))
                .and(INVENTORYITEMS_D_O.INVENTORYTYPE.eq(data.getInventoryType()));
        InventoryitemsDO inventoryItemsDO = inventoryitemsMapper.selectOneByQuery(itemQueryWrapper);
        RequireUtil.requireNotNull(inventoryItemsDO, I18nUtil.getExceptionMessage("InventoryService.updateInventory.exception2"));
        if (!Objects.equals(data.getItemId(), inventoryItemsDO.getItemid())) {
            throw new BizException(I18nUtil.getExceptionMessage("InventoryService.updateInventory.exception2"));
        }
        return inventoryItemsDO;
    }
}

