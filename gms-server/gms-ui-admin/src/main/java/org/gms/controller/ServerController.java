package org.gms.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.gms.constants.api.ApiConstant;
import org.gms.constants.net.ServerConstants;
import org.gms.event.ServerEvent;
import org.gms.event.ServerEventType;
import org.gms.model.dto.ResultBody;
import org.gms.model.dto.ServerShutdownDTO;
import org.gms.model.dto.SubmitBody;
import org.gms.model.pojo.ServerStat;
import org.springframework.boot.SpringApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.web.bind.annotation.*;


@RestController
@AllArgsConstructor
@RequestMapping("/server")
public class ServerController {

    private final ApplicationContext applicationContext;
    private ApplicationEventPublisher applicationEventPublisher;

    @Tag(name = "/server/" + ApiConstant.LATEST)
    @Operation(summary = "停止所有")
    @GetMapping("/" + ApiConstant.LATEST + "/shutdown")
    public void shutdown() {
        // 这里只能触发destroy，但服务不能正常停止
        SpringApplication.exit(applicationContext);
        // 这里才能正常的停止
        System.exit(0);
    }

    @Tag(name = "/server/" + ApiConstant.LATEST)
    @Operation(summary = "停止服务")
    @GetMapping("/" + ApiConstant.LATEST + "/stopServer")
    public ResultBody<Object> stopServer() {
        applicationEventPublisher.publishEvent(new ServerEvent(this, ServerEventType.STOP_SERVER, null));
        return ResultBody.success();
    }

    @Tag(name = "/server/" + ApiConstant.LATEST)
    @Operation(summary = "自定义停止服务")
    @PostMapping("/" + ApiConstant.LATEST + "/stopServerWithMsgAndInternal")
    public ResultBody<Object> stopServerWithMsgAndInternal(
            @Parameter(
                    name = "stopConfigData", in = ParameterIn.DEFAULT, required = true,
                    description = "停服请求参数：包含停服自定义消息，停服倒计时(单位：分钟)"
            )
            @RequestBody SubmitBody<ServerShutdownDTO> request) {
        applicationEventPublisher.publishEvent(new ServerEvent(this, ServerEventType.STOP_SERVER_WITH_MSG, request.getData()));

        return ResultBody.success();
    }

    @Tag(name = "/server/" + ApiConstant.LATEST)
    @Operation(summary = "启动服务")
    @GetMapping("/" + ApiConstant.LATEST + "/startServer")
    public ResultBody<Object> startServer() {
        applicationEventPublisher.publishEvent(new ServerEvent(this, ServerEventType.START_SERVER, null));

        return ResultBody.success();
    }

    @Tag(name = "/server/" + ApiConstant.LATEST)
    @Operation(summary = "重启服务")
    @GetMapping("/" + ApiConstant.LATEST + "/restartServer")
    public ResultBody<Object> restartServer() {
        applicationEventPublisher.publishEvent(new ServerEvent(this, ServerEventType.RESTART_SERVER, null));
        return ResultBody.success();
    }

    @Tag(name = "/server/" + ApiConstant.LATEST)
    @Operation(summary = "查询服务状态")
    @GetMapping("/" + ApiConstant.LATEST + "/online")
    public ResultBody<Boolean> online() {
        return ResultBody.success(ServerStat.isOnline());
    }


    @Tag(name = "/server/" + ApiConstant.LATEST)
    @Operation(summary = "查询版本号")
    @GetMapping("/" + ApiConstant.LATEST + "/version")
    public ResultBody<String> version() {
        return ResultBody.success(ServerConstants.BEI_DOU_VERSION);
    }
}
