package org.gms.service;

import com.mybatisflex.core.query.QueryWrapper;
import org.gms.dao.entity.*;
import org.gms.dao.mapper.*;
import org.gms.model.dto.BeautyCategoryDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

import static org.gms.dao.entity.table.NpcBeautyCatDOTableDef.NPC_BEAUTY_CAT_D_O;
import static org.gms.dao.entity.table.NpcBeautyMappingDOTableDef.NPC_BEAUTY_MAPPING_D_O;
import static org.gms.dao.entity.table.NpcBeautyPoolDOTableDef.NPC_BEAUTY_POOL_D_O;
import static org.gms.dao.entity.table.NpcBeautyPoolItemDOTableDef.NPC_BEAUTY_POOL_ITEM_D_O;
import static org.gms.dao.entity.table.NpcDialogTableDef.NPC_DIALOG;

@Service
public class NpcBeautyService {

    @Autowired
    private NpcBeautyMappingMapper mappingMapper;
    @Autowired
    private NpcBeautyPoolMapper poolMapper;
    @Autowired
    private NpcBeautyPoolItemMapper itemMapper;
    @Autowired
    private NpcBeautyCatMapper catMapper;
    @Autowired
    private NpcDialogMapper npcDialogMapper;

    /**
     * 获取指定 NPC 且符合当前玩家性别的所有可用美容菜单
     */
    public List<BeautyCategoryDTO> getNpcBeautyMenuList(int npcId, int playerGender) {
        // 使用 MyBatis-Flex 连表查询：从 mapping 开始，JOIN pool 和 cat
        // 同时查出 mapping 里的 coupon_item_id
        QueryWrapper queryWrapper = QueryWrapper.create()
                .select(
                        NPC_BEAUTY_CAT_D_O.ALL_COLUMNS,
                        NPC_BEAUTY_MAPPING_D_O.ALL_COLUMNS
                )
                .from(NPC_BEAUTY_MAPPING_D_O)
                .leftJoin(NPC_BEAUTY_POOL_D_O).on(NPC_BEAUTY_POOL_D_O.ID.eq(NPC_BEAUTY_MAPPING_D_O.POOL_ID))
                .leftJoin(NPC_BEAUTY_CAT_D_O).on(NPC_BEAUTY_CAT_D_O.ID.eq(NPC_BEAUTY_POOL_D_O.CATEGORY_ID))
                .where(NPC_BEAUTY_MAPPING_D_O.NPC_ID.eq(npcId))
                .and(NPC_BEAUTY_MAPPING_D_O.IS_ACTIVE.eq(true))
                .and(NPC_BEAUTY_POOL_D_O.IS_ACTIVE.eq(true))
                .and(NPC_BEAUTY_CAT_D_O.IS_ACTIVE.eq(true))
                .and(NPC_BEAUTY_POOL_D_O.GENDER.in(-1, playerGender))
                .orderBy(NPC_BEAUTY_CAT_D_O.MENU_INDEX.asc());

        // 连表查询，映射为复合实体或通过 Mapping 去重构建 DTO
        List<NpcBeautyMappingDO> mappings = mappingMapper.selectListByQuery(queryWrapper);

        Map<Integer, BeautyCategoryDTO> uniqueMenuMap = new LinkedHashMap<>();
        for (NpcBeautyMappingDO mapping : mappings) {
            NpcBeautyPoolDO pool = poolMapper.selectOneById(mapping.getPoolId());
            if (pool == null || !pool.getIsActive()) continue;

            NpcBeautyCatDO cat = catMapper.selectOneById(pool.getCategoryId());
            if (cat == null || !cat.getIsActive()) continue;

            if (!uniqueMenuMap.containsKey(cat.getMenuIndex())) {
                BeautyCategoryDTO dto = new BeautyCategoryDTO();
                dto.setMenuIndex(cat.getMenuIndex());
                dto.setCategoryName(cat.getCategoryName());
                dto.setBeautyType(cat.getBeautyType());
                dto.setServiceMode(cat.getServiceMode());
                dto.setRandom(cat.getIsRandom() != null && cat.getIsRandom());

                // ★ 关键改动：优惠券 ID 来源于 NpcBeautyMappingDO
                dto.setCouponItemId(mapping.getCouponItemId());

                dto.setPromptText(cat.getPromptText());
                dto.setWarningText(cat.getWarningText());
                dto.setPoolId(mapping.getPoolId());

                uniqueMenuMap.put(cat.getMenuIndex(), dto);
            }
        }
        return new ArrayList<>(uniqueMenuMap.values());
    }

    /**
     * 获取某个分类的详细数据，并根据玩家性别及数学规律动态计算外观列表，同时挂载台词
     */
    public BeautyCategoryDTO getBeautyCategoryData(int npcId, int menuIndex, int playerGender, int currentHair, int currentFace) {
        List<BeautyCategoryDTO> menus = getNpcBeautyMenuList(npcId, playerGender);
        BeautyCategoryDTO targetCat = menus.stream()
                .filter(m -> m.getMenuIndex() == menuIndex)
                .findFirst()
                .orElse(null);

        if (targetCat == null) return null;

        // 查出对应分类和性别下的资源池明细
        QueryWrapper and = QueryWrapper.create().where(NPC_BEAUTY_CAT_D_O.MENU_INDEX.eq(menuIndex)).and(NPC_BEAUTY_CAT_D_O.CATEGORY_NAME.eq(targetCat.getCategoryName()));
        NpcBeautyCatDO catEntity = catMapper.selectListByQuery(
                and
        ).get(0);

        List<NpcBeautyPoolDO> pools = poolMapper.selectListByQuery(
                QueryWrapper.create().where(NPC_BEAUTY_POOL_D_O.CATEGORY_ID.eq(catEntity.getId()))
                        .and(NPC_BEAUTY_POOL_D_O.IS_ACTIVE.eq(true))
        );

        List<Integer> rawStyleIds = new ArrayList<>();
        for (NpcBeautyPoolDO pool : pools) {
            if (targetCat.getPoolId() == pool.getId()) {
//            if (pool.getGender() == -1 || pool.getGender() == playerGender) {
                List<NpcBeautyPoolItemDO> items = itemMapper.selectListByQuery(
                        QueryWrapper.create().where(NPC_BEAUTY_POOL_ITEM_D_O.POOL_ID.eq(pool.getId()))
                );
                rawStyleIds.addAll(items.stream().map(NpcBeautyPoolItemDO::getStyleId).collect(Collectors.toList()));
            }
        }

        // 应用数学规律转换
        List<Integer> resolvedOptions = resolveStyleList(targetCat.getServiceMode(), rawStyleIds, currentHair, currentFace);
        targetCat.setOptions(resolvedOptions);

        // 挂载专属台词 Map
        targetCat.setDialogs(getBeautyDialogs(npcId));

        return targetCat;
    }

    /**
     * 获取美容专属台词（限定 template_id = 2，支持 npc_id = 0 兜底）
     */
    public Map<String, String> getBeautyDialogs(int npcId) {
        List<NpcDialog> specificDialogs = npcDialogMapper.selectListByQuery(
                QueryWrapper.create()
                        .where(NPC_DIALOG.NPC_ID.eq(npcId))
                        .and(NPC_DIALOG.TEMPLATE_ID.eq(2))
                        .and(NPC_DIALOG.DIALOG_TYPE.eq("beauty"))
        );

        Map<String, String> dialogMap = specificDialogs.stream()
                .collect(Collectors.toMap(NpcDialog::getDialogKey, NpcDialog::getDialogText, (k1, k2) -> k1));

        List<NpcDialog> defaultDialogs = npcDialogMapper.selectListByQuery(
                QueryWrapper.create()
                        .where(NPC_DIALOG.NPC_ID.eq(0))
                        .and(NPC_DIALOG.TEMPLATE_ID.eq(2))
                        .and(NPC_DIALOG.DIALOG_TYPE.eq("beauty"))
        );

        for (NpcDialog def : defaultDialogs) {
            dialogMap.putIfAbsent(def.getDialogKey(), def.getDialogText());
        }

        return dialogMap;
    }

    /**
     * 数学规律解析核心算法
     */
    private List<Integer> resolveStyleList(String serviceMode, List<Integer> rawIds, int currentHair, int currentFace) {
        List<Integer> result = new ArrayList<>();
        switch (serviceMode) {
            case "HAIR_CHANGE": {
                int colorOffset = currentHair % 10;
                for (int base : rawIds) {
                    result.add((base - (base % 10)) + colorOffset);
                }
                break;
            }
            case "HAIR_COLOR": {
                int hairBase = currentHair - (currentHair % 10);
                for (int color = 0; color < 8; color++) {
                    result.add(hairBase + color);
                }
                break;
            }
            case "FACE_CHANGE": {
                int eyeColorOffset = ((currentFace / 100) % 10) * 100;
                for (int base : rawIds) {
                    int faceBase = base - (((base / 100) % 10) * 100);
                    result.add(faceBase + eyeColorOffset);
                }
                break;
            }
            case "FACE_COLOR": {
                int faceBase = currentFace - (((currentFace / 100) % 10) * 100);
                for (int color = 0; color < 8; color++) {
                    result.add(faceBase + (color * 100));
                }
                break;
            }
            case "SKIN_CHANGE":
            default: {
                result.addAll(rawIds);
                break;
            }
        }
        return result;
    }
}