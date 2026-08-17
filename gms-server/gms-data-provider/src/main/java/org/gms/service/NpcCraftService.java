package org.gms.service;


import org.gms.dao.entity.NpcCraftCat;
import org.gms.dao.entity.NpcDialog;
import org.gms.dto.NpcCraftCategoryDTO;
import org.gms.dto.NpcCraftItemDTO;
import org.gms.dto.NpcMenuDTO;
import org.gms.model.dto.CraftSearchRtnDTO;

import java.util.List;
import java.util.Map;

/**
 * 提供制作接口
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/12 15:41
 */
public interface NpcCraftService {

    /**
     * 获取所有有制作的NPC
     * @return
     */
    public List<CraftSearchRtnDTO> getCraftList();

    /**
     * 获取指定 NPC 绑定的全量 Key-Value 垂直台词 Map (支持模板降级)
     */
    Map<String, String> loadDialogMap(int npcId, String dialogType);
    List<NpcDialog> loadDialogList(int npcId, String dialogType);

    /**
     * 获取指定 NPC 配置的所有一级分类菜单列表
     */
    List<NpcMenuDTO> getNpcMenuList(int npcId);

    /**
     * 根据 npcId 和 menuIndex 获取具体某个分类下的完整配方与台词数据包
     */
    NpcCraftCategoryDTO getCategoryData(int npcId, int menuIndex);

    /**
     * 新增或修改锻造分类 (id 为空时新增)
     */
    void saveCategory(NpcCraftCat cat);

    /**
     * 删除锻造分类 (级联删除该分类下所有配方与材料)
     */
    void deleteCategory(Integer categoryId);

    /**
     * 新增或修改配方 (id 为空时新增；保存时重建该配方的材料明细)
     */
    void saveItem(NpcCraftItemDTO dto);

    /**
     * 删除配方 (级联删除其材料明细)
     */
    void deleteItem(Integer itemId);

    /**
     * 新增或修改 NPC 台词 (id 为空时新增)
     */
    void saveDialog(NpcDialog dialog);

    /**
     * 删除 NPC 台词
     */
    void deleteDialog(Integer dialogId);
}