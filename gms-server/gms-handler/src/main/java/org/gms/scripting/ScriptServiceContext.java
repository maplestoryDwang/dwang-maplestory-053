package org.gms.scripting;

import org.gms.service.GachaponService;
import org.gms.service.NpcCraftService;
import org.springframework.stereotype.Component;

/**
 * 聚合所有提供给 JS 脚本使用的 Spring Service 容器
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/12 16:16
 */

@Component
public class ScriptServiceContext {

    private final NpcCraftService craftService;
    private final GachaponService gachaponService;

    // Spring 会自动将这些 Service 注入进来
    public ScriptServiceContext(NpcCraftService craftService, GachaponService gachaponService) {
        this.craftService = craftService;
        this.gachaponService = gachaponService;
    }

    public NpcCraftService getCraftService() {
        return craftService;
    }

    public GachaponService getGachaponService() {
        return gachaponService;
    }
}