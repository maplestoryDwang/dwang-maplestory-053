package org.gms.controller;


import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.gms.constants.api.ApiConstant;
import org.gms.event.GiveCharEvent;
import org.gms.model.dto.GiveResourceReqDTO;
import org.gms.model.dto.ResultBody;
import org.gms.model.dto.SubmitBody;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/give")
public class GiveController {


    @Autowired
    private ApplicationEventPublisher eventPublisher;


    @Tag(name = "/give/" + ApiConstant.LATEST)
    @Operation(summary = "给玩家分发资源")
    @PostMapping("/" + ApiConstant.LATEST + "/resource")
    public ResultBody<Object> giveResource(@RequestBody SubmitBody<GiveResourceReqDTO> submitBody) {

        eventPublisher.publishEvent(new GiveCharEvent(this, submitBody.getData()));
        return ResultBody.success();
    }
}
