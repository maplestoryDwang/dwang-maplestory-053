package org.gms.service;

import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.core.row.Row;
import org.gms.dao.entity.*;
import org.gms.dao.mapper.*;
import org.gms.dto.NpcCraftCategoryDTO;
import org.gms.dto.NpcMenuDTO;
import org.gms.model.dto.CraftSearchRtnDTO;
import org.gms.model.dto.ShopSearchReqDTO;
import org.gms.model.dto.ShopSearchRtnDTO;
import org.gms.server.ItemInformationProvider;
import org.gms.server.StringInfoProvider;
import org.gms.util.RequireUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

import static org.gms.dao.entity.table.NpcCraftCatTableDef.NPC_CRAFT_CAT;
import static org.gms.dao.entity.table.NpcCraftItemTableDef.NPC_CRAFT_ITEM;
import static org.gms.dao.entity.table.NpcCraftMatTableDef.NPC_CRAFT_MAT;
import static org.gms.dao.entity.table.NpcDialogTableDef.NPC_DIALOG;
import static org.gms.dao.entity.table.ShopitemsDOTableDef.SHOPITEMS_D_O;
import static org.gms.dao.entity.table.ShopsDOTableDef.SHOPS_D_O;

/**
 * NPC 锻造/合成服务实现类 (基于 MyBatis-Flex)
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/12 14:34
 */
@Service
public class NpcCraftServiceImpl implements NpcCraftService {

    @Autowired
    private NpcCraftCatMapper catMapper;
    @Autowired
    private NpcDialogMapper dialogMapper;
    @Autowired
    private NpcCraftItemMapper itemMapper;
    @Autowired
    private NpcCraftMatMapper matMapper;

    @Autowired
    private NpcCraftListMapper craftListMapper;


    public List<CraftSearchRtnDTO> getCraftList() {

        List<NpcCraftListDO> queryAsList = craftListMapper.selectAll();
        List<CraftSearchRtnDTO> matchedShopsDOList = new ArrayList<>();
        for (NpcCraftListDO row : queryAsList) {
            Integer npcId = row.getNpcId();
            String npcName = StringInfoProvider.getNPCName(npcId);
            if (RequireUtil.isEmpty(npcName)) {
                continue;
            }

            matchedShopsDOList.add(CraftSearchRtnDTO.builder()
                    .craftId(row.getId())
                    .npcId(npcId)
                    .npcName(npcName)
                    .build());
        }
        return matchedShopsDOList;
    }
    /**
     * 1. 获取指定 NPC 配置的所有一级分类菜单列表 (用于 status == 0 阶段)
     */
    @Override
    public List<NpcMenuDTO> getNpcMenuList(int npcId) {
        List<NpcCraftCat> catList = catMapper.selectListByQuery(
                QueryWrapper.create()
                        .from(NPC_CRAFT_CAT)
                        .where(NPC_CRAFT_CAT.NPC_ID.eq(npcId))
                        .orderBy(NPC_CRAFT_CAT.MENU_INDEX.asc())
        );

        if (catList.isEmpty()) {
            return Collections.emptyList();
        }

        return catList.stream()
                .map(cat -> new NpcMenuDTO(cat.getId(), cat.getMenuIndex(), cat.getCategoryName()))
                .collect(Collectors.toList());
    }

    /**
     * 2. 加载分类数据并组装台词 Map (用于 status == 1 阶段)
     */
    @Override
    public NpcCraftCategoryDTO getCategoryData(int npcId, int menuIndex) {
        // 1. 查询分类主数据
        NpcCraftCat cat = catMapper.selectOneByQuery(
                QueryWrapper.create()
                        .from(NPC_CRAFT_CAT)
                        .where(NPC_CRAFT_CAT.NPC_ID.eq(npcId))
                        .and(NPC_CRAFT_CAT.MENU_INDEX.eq(menuIndex))
        );
        if (cat == null) return null;

        NpcCraftCategoryDTO dto = new NpcCraftCategoryDTO();
        dto.setCategoryId(cat.getId());
        dto.setCategoryName(cat.getCategoryName());
        dto.setCraftType(cat.getCraftType());
        dto.setPromptText(cat.getPromptText());
        dto.setWarningText(cat.getWarningText());

        // 2. 垂直查询台词（降级策略：先找 npc_id 专属台词 -> 找 template_id 模板台词）
        Map<String, String> dialogMap = loadDialogMap(npcId, cat.getTemplateId(), "craft");
        dto.setDialogs(dialogMap);

        // 3. 查询配方与材料
        List<NpcCraftItem> items = itemMapper.selectListByQuery(
                QueryWrapper.create()
                        .from(NPC_CRAFT_ITEM)
                        .where(NPC_CRAFT_ITEM.CATEGORY_ID.eq(cat.getId()))
                        .orderBy(NPC_CRAFT_ITEM.SORT_ORDER.asc(), NPC_CRAFT_ITEM.ID.asc())
        );

        if (items.isEmpty()) {
            dto.setOptions(Collections.emptyList());
            return dto;
        }

        List<Integer> recipeIds = items.stream().map(NpcCraftItem::getId).collect(Collectors.toList());
        List<NpcCraftMat> allMats = matMapper.selectListByQuery(
                QueryWrapper.create().from(NPC_CRAFT_MAT).where(NPC_CRAFT_MAT.RECIPE_ID.in(recipeIds))
        );
        Map<Integer, List<NpcCraftMat>> matGroup = allMats.stream().collect(Collectors.groupingBy(NpcCraftMat::getRecipeId));

        // 获取item的名字
        ItemInformationProvider instance = ItemInformationProvider.getInstance();

        List<NpcCraftCategoryDTO.RecipeOptionDTO> optionDTOs = new ArrayList<>();
        for (NpcCraftItem item : items) {
            NpcCraftCategoryDTO.RecipeOptionDTO opt = new NpcCraftCategoryDTO.RecipeOptionDTO();
            opt.setRecipeId(item.getId());
            opt.setItemId(item.getItemId());
            String name = instance.getName(item.getItemId());
            opt.setItemName(name);
            opt.setIsEquip(item.getIsEquip());
            opt.setYieldQty(item.getYieldQty());
            opt.setReqLevel(item.getReqLevel());
            opt.setJobName(item.getJobName());
            opt.setCost(item.getCost());
            opt.setDisplayText(item.getDisplayText());

            List<Integer> matsList = new ArrayList<>();
            List<String> matsNameLists = new ArrayList<>();
            List<Integer> matQtyList = new ArrayList<>();
            for (NpcCraftMat m : matGroup.getOrDefault(item.getId(), Collections.emptyList())) {
                matsList.add(m.getMatId());
                matsNameLists.add(instance.getName(m.getMatId()));
                matQtyList.add(m.getMatQty());
            }
            opt.setMats(matsList);
            opt.setMatNames(matsNameLists);
            opt.setMatQty(matQtyList);
            optionDTOs.add(opt);
        }

        dto.setOptions(optionDTOs);
        return dto;
    }

    /**
     * 3. 供外部 (如 start 阶段) 直接调用的台词加载方法
     */
    @Override
    public Map<String, String> loadDialogMap(int npcId, String dialogType) {
        // 先查该 NPC 配置的 templateId，默认退回 1 (通用魔法师)
        QueryWrapper limit = QueryWrapper.create()
                .select(NPC_CRAFT_CAT.TEMPLATE_ID)
                .from(NPC_CRAFT_CAT)
                .where(NPC_CRAFT_CAT.NPC_ID.eq(npcId))
                .limit(1);

        Integer templateId = (Integer) catMapper.selectObjectByQuery(limit);
        if (templateId == null) {
            templateId = 1;
        }

        return loadDialogMap(npcId, templateId, dialogType);
    }

    /**
     * 内部辅助：垂直台词转换为 Map 结构，优先获取 NPC 专属台词，无则回退模板
     */
    private Map<String, String> loadDialogMap(int npcId, int templateId, String dialogType) {
        QueryWrapper qw = QueryWrapper.create()
                .from(NPC_DIALOG)
                .where(NPC_DIALOG.DIALOG_TYPE.eq(dialogType))
                .and(
                        NPC_DIALOG.NPC_ID.eq(npcId)
                                .or(NPC_DIALOG.TEMPLATE_ID.eq(templateId))
                );

        List<NpcDialog> list = dialogMapper.selectListByQuery(qw);

        // 按 key 归集，优先保留 npc_id > 0 的记录
        Map<String, String> resultMap = new HashMap<>();
        for (NpcDialog d : list) {
            // 如果已存在且当前是通用模板，则不覆盖专属台词；如果是专属台词，则覆盖模板
            if (!resultMap.containsKey(d.getDialogKey()) || d.getNpcId() > 0) {
                resultMap.put(d.getDialogKey(), d.getDialogText());
            }
        }
        return resultMap;
    }
}