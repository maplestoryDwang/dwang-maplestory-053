package org.gms.controller;

import com.mybatisflex.core.paginate.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.gms.constants.api.ApiConstant;
import org.gms.model.dto.*;
import org.gms.service.NpcCraftService;
import org.gms.util.BasePageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;


import io.swagger.v3.oas.annotations.Parameter;
import org.gms.dto.NpcCraftCategoryDTO;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import org.gms.dto.NpcMenuDTO;


/**
 * NPC 锻造/制作功能 控制器
 *
 * @author dwang
 * @version 1.0
 */
@Tag(name = "NPC锻造管理 - " + ApiConstant.LATEST)
@RestController
@RequestMapping("/api/npc-craft")
public class NpcCraftController {

    private final NpcCraftService npcCraftService;

    @Autowired
    public NpcCraftController(NpcCraftService npcCraftService) {
        this.npcCraftService = npcCraftService;
    }


    @Operation(summary = "分页获取建造列表")
    @PostMapping("/" + ApiConstant.LATEST + "/getCraftList")
    public ResultBody<Page<CraftSearchRtnDTO>> getCraftList(@RequestBody SubmitBody<CraftSearchReqDTO> request) {
        List<CraftSearchRtnDTO> craftList = npcCraftService.getCraftList();
        Page<CraftSearchRtnDTO> page = BasePageUtil.create(craftList.stream().distinct().toList(), request.getData()).page();
        return ResultBody.success(request, page);
    }

    @Operation(summary = "分页获取列表")
    @PostMapping("/" + ApiConstant.LATEST + "/getCraftList")
    public ResultBody<Page<CraftSearchRtnDTO>> getCraftList() {
        List<CraftSearchRtnDTO> craftList = npcCraftService.getCraftList();
        Page<CraftSearchRtnDTO> page = BasePageUtil.create(craftList.stream().distinct().toList()).page();
        return ResultBody.success(page);
    }

    /**
     * 获取指定 NPC 配置的所有一级分类菜单列表
     */
    @Operation(summary = "获取 NPC 一级分类菜单列表")
    @GetMapping("/" + ApiConstant.LATEST + "/menus/{npcId}")
    public ResultBody<List<NpcMenuDTO>> getNpcMenuList(
            @Parameter(description = "NPC ID", required = true) @PathVariable("npcId") int npcId) {
        List<NpcMenuDTO> menuList = npcCraftService.getNpcMenuList(npcId);
        return ResultBody.success(menuList);
    }

    /**
     * 根据 npcId 和 menuIndex 获取具体某个分类下的完整配方与台词数据包
     */
    @Operation(summary = "获取指定分类下的完整配方数据")
    @GetMapping("/" + ApiConstant.LATEST + "/category/{npcId}/{menuIndex}")
    public ResultBody<NpcCraftCategoryDTO> getCategoryData(
            @Parameter(description = "NPC ID", required = true) @PathVariable("npcId") int npcId,
            @Parameter(description = "菜单分类索引", required = true) @PathVariable("menuIndex") int menuIndex) {
        NpcCraftCategoryDTO categoryData = npcCraftService.getCategoryData(npcId, menuIndex);
        return ResultBody.success(categoryData);
    }

    /**
     * 获取指定 NPC 绑定的全量 Key-Value 垂直台词 Map
     *
     * @param npcId      NPC ID
     * @param dialogType 台词类型 (例如: craft, default 等，可通过 QueryParam 传入，非必填时默认传 "craft")
     */
    @Operation(summary = "获取 NPC 垂直台词 Map")
    @GetMapping("/" + ApiConstant.LATEST + "/dialogs/{npcId}")
    public ResultBody<Map<String, String>> loadDialogMap(
            @Parameter(description = "NPC ID", required = true) @PathVariable("npcId") int npcId,
            @Parameter(description = "台词类型") @RequestParam(value = "dialogType", defaultValue = "craft") String dialogType) {
        Map<String, String> dialogMap = npcCraftService.loadDialogMap(npcId, dialogType);
        return ResultBody.success(dialogMap);
    }
}