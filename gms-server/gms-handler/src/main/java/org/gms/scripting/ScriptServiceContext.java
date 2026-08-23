package org.gms.scripting;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.gms.net.server.services.task.channel.EventService;
import org.gms.property.ServiceProperty;
import org.gms.service.EventConfigDataService;
import org.gms.service.GachaponService;
import org.gms.service.NpcCraftService;
import org.springframework.stereotype.Component;

/**
 * 聚合所有提供给 JS 脚本及脚本管理器使用的 Spring Service / Property 容器
 * 既支持 Spring 依赖注入，也支持非单例/非 Spring 管理类通过静态方法调用。
 *
 * @author dwang
 * @version 1.1
 * @since 2026/8/12 16:16
 */
@Component
public class ScriptServiceContext {

    // 1. 静态持有自身实例，供非 Spring Bean 直接获取
    private static ScriptServiceContext instance;

    private final NpcCraftService craftService;
    private final GachaponService gachaponService;
    private final ServiceProperty serviceProperty;
    @Getter
    private final EventConfigDataService eventConfigDataService;

    // Spring 自动将依赖注入构造函数
    public ScriptServiceContext(NpcCraftService craftService,
                                GachaponService gachaponService,
                                ServiceProperty serviceProperty,
                                EventConfigDataService eventConfigDataService
    ) {
        this.craftService = craftService;
        this.gachaponService = gachaponService;
        this.serviceProperty = serviceProperty;
        this.eventConfigDataService = eventConfigDataService;

        // 赋值给静态变量
        ScriptServiceContext.instance = this;
    }

    // -------------------------------------------------------------------------
    // 静态 Getter：提供给非 Spring Bean（如父类 AbstractScriptManager、EventScriptManager）
    // -------------------------------------------------------------------------
    public static ScriptServiceContext getInstance() {
        return instance;
    }

    public static ServiceProperty getStaticServiceProperty() {
        return instance != null ? instance.serviceProperty : null;
    }

    // -------------------------------------------------------------------------
    // 实例 Getter：提供给通过 Spring 注入该 Context 的单例组件（如 NPCScriptManager）
    // -------------------------------------------------------------------------
    public NpcCraftService getCraftService() {
        return craftService;
    }

    public GachaponService getGachaponService() {
        return gachaponService;
    }

    public ServiceProperty getServiceProperty() {
        return serviceProperty;
    }
}