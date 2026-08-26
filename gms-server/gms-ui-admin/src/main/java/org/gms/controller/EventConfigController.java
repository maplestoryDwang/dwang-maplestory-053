package org.gms.controller;

import com.mybatisflex.core.paginate.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.gms.constants.api.ApiConstant;
import org.gms.dao.entity.EventConfigDO;
import org.gms.model.dto.*;
import org.gms.service.EventConfigDataService;
import org.gms.util.BasePageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

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

    @Tag(name = "/event/" + ApiConstant.LATEST)
    @Operation(summary = "分页获取事件列表")
    @PostMapping("/" + ApiConstant.LATEST + "/getEventList")
    public ResultBody<Page<EventConfigDTO>> getEventList(@RequestBody SubmitBody<EventConfigDTO> request) {
        List<EventConfigDO> allEvents = eventConfigDataService.getAllEvents();
        List<EventConfigDTO> eventConfigDTOS = new ArrayList<>();
        for (EventConfigDO event : allEvents) {
            eventConfigDTOS.add(new EventConfigDTO(event.getId(), event.getEventName(), event.getEnabled(), event.getRemark()));
        }

        EventConfigDTO query = request.getData();
        Page<EventConfigDTO> page = BasePageUtil.create(eventConfigDTOS.stream().distinct().toList(), query)
                .filter(item -> matchEvent(query, item))
                .page();
        return ResultBody.success(request, page);
    }

    private boolean matchEvent(EventConfigDTO query, EventConfigDTO item) {
        if (query == null) {
            return true;
        }
        if (query.getId() != null && !query.getId().equals(item.getId())) {
            return false;
        }
        if (query.getEventName() != null && !query.getEventName().isBlank()) {
            String name = item.getEventName() == null ? "" : item.getEventName();
            if (!name.toLowerCase().contains(query.getEventName().toLowerCase())) {
                return false;
            }
        }
        if (query.getEnabled() != null && !query.getEnabled().equals(item.getEnabled())) {
            return false;
        }
        return true;
    }


    /**
     * 新增或修改配方
     */
    @Operation(summary = "新增或修改事件")
    @PostMapping("/" + ApiConstant.LATEST + "/saveEvent")
    public ResultBody<Object> saveEvent(@RequestBody SubmitBody<EventConfigDTO> request) {
        eventConfigDataService.saveEvent(request.getData());
        return ResultBody.success(request, null);
    }

    /**
     * 删除配方
     */
    @Operation(summary = "删除事件")
    @PostMapping("/" + ApiConstant.LATEST + "/deleteEvent")
    public ResultBody<Object> deleteEvent(@RequestBody SubmitBody<EventConfigDTO> request) {
        eventConfigDataService.deleteEvent(request.getData().getId());
        return ResultBody.success(request, null);
    }


}
