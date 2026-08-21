package org.gms.controller;

import com.mybatisflex.core.paginate.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.NotNull;
import org.gms.constants.api.ApiConstant;
import org.gms.model.dto.*;
import org.gms.server.quest.converter.QuestDetailVO;
import org.gms.service.QuestApiService;
import org.gms.service.QuestUserDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 任务管理器
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/21 09:52
 */
@RestController
@RequestMapping("/quest")
public class QuestController {

    private final QuestApiService questApiService;

    @Autowired
    public QuestController(QuestApiService questApiService) {
        this.questApiService = questApiService;
    }

    @Tag(name = "/quest/" + ApiConstant.LATEST)
    @Operation(summary = "分页获取任务列表")
    @PostMapping("/" + ApiConstant.LATEST + "/getQuestList")
    public ResultBody<Page<QuestSearchRtnDTO>> getQuestList(@RequestBody SubmitBody<QuestSearchReqDTO> request) {
        return ResultBody.success(request, questApiService.getQuestList(request.getData()));
    }

    /**
     * 根据任务ID获取完整详情（含4大条件/奖励Map解析）
     */
    @Operation(summary = "获取任务完整详情")
    @GetMapping("/" + ApiConstant.LATEST + "/detail/{id}")
    public ResultBody<QuestDetailVO> getQuestDetail(
            @Parameter(description = "任务ID", required = true, example = "1001")
            @PathVariable("id") @NotNull(message = "任务ID不能为空") Short id) {
        return ResultBody.success(questApiService.getQuestDetail(id));
    }
}
