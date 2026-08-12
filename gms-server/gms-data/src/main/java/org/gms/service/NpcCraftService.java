package org.gms.service;


import org.gms.dto.NpcCraftCategoryDTO;
import org.gms.dto.NpcMenuDTO;

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
     * 获取指定 NPC 绑定的全量 Key-Value 垂直台词 Map (支持模板降级)
     */
    Map<String, String> loadDialogMap(int npcId, String dialogType);

    /**
     * 获取指定 NPC 配置的所有一级分类菜单列表
     */
    List<NpcMenuDTO> getNpcMenuList(int npcId);

    /**
     * 根据 npcId 和 menuIndex 获取具体某个分类下的完整配方与台词数据包
     */
    NpcCraftCategoryDTO getCategoryData(int npcId, int menuIndex);
}