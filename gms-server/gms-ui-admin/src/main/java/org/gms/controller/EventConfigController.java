package org.gms.controller;

import com.mybatisflex.core.paginate.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.gms.constants.api.ApiConstant;
import org.gms.dao.entity.EventConfigDO;
import org.gms.model.dto.QuestSearchReqDTO;
import org.gms.model.dto.QuestSearchRtnDTO;
import org.gms.model.dto.ResultBody;
import org.gms.model.dto.SubmitBody;
import org.gms.service.EventConfigDataService;
import org.gms.util.BasePageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 控制事件
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/22 22:22
 */
@RestController
@AllArgsConstructor
@RequestMapping("/event")
public class EventConfigController {

    @Autowired
    EventConfigDataService eventConfigDataService;

//    @Tag(name = "/event/" + ApiConstant.LATEST)
//    @Operation(summary = "分页获取事件列表")
//    @PostMapping("/" + ApiConstant.LATEST + "/getQuestList")
//    public ResultBody<Page<EventConfigDO>> getQuestList(@RequestBody SubmitBody<EventConfigDO> request) {
//        eventConfigDataService.
//        return BasePageUtil.create(questSearchRtnDTOS.stream().distinct().toList(), data).page();
//
//    }

}
