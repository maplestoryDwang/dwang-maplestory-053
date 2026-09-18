package org.gms.scripting.event;

import org.apache.commons.lang3.StringUtils;
import org.gms.client.Character;
import org.gms.client.Client;
import org.gms.constants.id.item.EqpId;
import org.gms.constants.string.ExtendType;
import org.gms.dao.entity.ExtendValueDO;
import org.gms.net.server.channel.handlers.ItemRewardHandler;
import org.gms.scripting.AbstractScriptManager;
import org.gms.scripting.npc.NPCScriptManager;
import org.gms.server.ItemInformationProvider;
import org.gms.server.TimerManager;
import org.gms.server.maps.MapleMap;
import org.gms.service.ExtendDataService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.script.Invocable;
import javax.script.ScriptEngine;
import java.awt.*;
import java.util.concurrent.ScheduledFuture;

/**
 * 冰狼技术
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/18 17:23
 */
@Component
public class IceWolfService {
    private static final Logger logger = LoggerFactory.getLogger(ItemRewardHandler.class);
    private static ScheduledFuture<?> itemvacTask;
    private static ScheduledFuture<?> mobvacTask;
    private static ScheduledFuture<?> bagTask;
    private static Point position;
    private static MapleMap vacmap;
    private static long timeStart;
    private static long timeEnd;
    private static long mvTime;
    private static int MOBVIC_LIMIT = 30;

    public void specialHandle(int itemId, Client c) {
        switch (itemId) {
            case EqpId.ZENUMIST_S_CAPE_1102139:
                position = position == null ? c.getPlayer().getPosition() : position;
                vacmap = c.getPlayer().getMap();
                mobvacTask = this.runScript(mobvacTask, itemId, "BeiDouSpecial/_mobvac.js", c, 510L, "全屏吸怪");
                break;
            case EqpId.ALCADNO_S_CAPE_1102140:
                itemvacTask = this.runScript(itemvacTask, itemId, "BeiDouSpecial/_itemvac.js", c, 500L, "全屏捡物");
                break;
//            case 2022552:
//                NPCScriptManager.getInstance().start(c, 9900001, (Character)null);
//                break;
//            case 2022615:
//                bagTask = this.runScript(bagTask, itemId, "BeiDouSpecial/_organize.js", c, 30000L, "矿物/卷轴自动整理");
        }

        c.getAbstractPlayerInteraction().enableActions();
    }

    private ScheduledFuture runScript(ScheduledFuture sf, int itemId, String path, Client c, long time, String msg) {
        if (sf != null) {
            this.dispose(itemId, c, c.getPlayer().getId());
            c.getPlayer().dropMessage(0, "[" + msg + "]功能已关闭");
            return null;
        } else {
            Character player = c.getPlayer();
            c.getPlayer().dropMessage(0, "[" + msg + "]功能已开启");
            if (itemId == EqpId.ZENUMIST_S_CAPE_1102139) {
                timeStart = System.currentTimeMillis();
                if (!this.checkTime(c, player.getId())) {
                    c.getPlayer().dropMessage(1, MOBVIC_LIMIT + "分钟吸怪时限已过, 请明天再使用该功能~");
                    return null;
                } else {
                    return TimerManager.getInstance().register(() -> {
                        try {
                            Invocable invocable = this.getScriptEngine(path);
                            if (!c.isLoggedIn() || player.getMap() == null) {
                                throw new RuntimeException("检测到用户已离线或不在地图中, 吸怪停止~");
                            }

                            if (player.getMap().getId() != vacmap.getId() || player.getMap().getChannelServer().getId() != vacmap.getChannelServer().getId()) {
                                vacmap.resetMapObjects();
                                c.getPlayer().dropMessage(0, "检测到用户已更换地图, 吸怪功能已暂停~");
                                throw new RuntimeException("检测到用户已更换地图, 吸怪功能已暂停~");
                            }

                            mvTime = System.currentTimeMillis() - timeStart;
                            invocable.invokeFunction("start", new Object[]{c.getPlayer(), ItemInformationProvider.getInstance(), position});
                        } catch (Exception e) {
                            logger.error("任务异常: " + itemId + (player == null ? ",  用户为空" : e.getMessage()));
                            this.dispose(itemId, c, player.getId());
                        }

                    }, time);
                }
            } else {
                return TimerManager.getInstance().register(() -> {
                    try {
                        Invocable invocable = this.getScriptEngine(path);
                        invocable.invokeFunction("start", new Object[]{c.getPlayer(), ItemInformationProvider.getInstance()});
                    } catch (Exception e) {
                        logger.error("任务异常: " + itemId + e.getMessage());
                        this.dispose(itemId, c, player.getId());
                    }

                }, time);
            }
        }
    }

    private Invocable getScriptEngine(String path) {
        SpecialScriptManager scriptManager = new SpecialScriptManager();
        ScriptEngine scriptEngine = scriptManager.getInvocableScriptEngine(path);
        return (Invocable)scriptEngine;
    }
    private static class SpecialScriptManager extends AbstractScriptManager {
        public ScriptEngine getInvocableScriptEngine(String path) {
            return super.getInvocableScriptEngine(path);
        }
    }

    private void dispose(int itemId, Client c, Integer playerId) {
        switch (itemId) {
            case EqpId.ZENUMIST_S_CAPE_1102139:
                this.checkTime(c, playerId);
                mobvacTask.cancel(true);
                position = null;
                vacmap = null;
                mobvacTask = null;
                break;
            case EqpId.ALCADNO_S_CAPE_1102140:
                itemvacTask.cancel(true);
                itemvacTask = null;
                break;
            case 2022615:
                bagTask.cancel(true);
                bagTask = null;
        }

    }

    private boolean checkTime(Client c, Integer playerId) {
        timeEnd = System.currentTimeMillis();
        ExtendValueDO extendValueDO = ExtendDataService.getExtendValue(String.valueOf(playerId), ExtendType.CHARACTER_EXTEND_DAILY.getType(), "mobvacLimit");
        String time = extendValueDO == null ? null : extendValueDO.getExtendValue();
        long diff = timeEnd - timeStart;
        mvTime = StringUtils.isBlank(time) ? diff : Long.parseLong(time) + diff;
        ExtendDataService.saveOrUpdateExtendValue(String.valueOf(playerId), ExtendType.CHARACTER_EXTEND_DAILY.getType(), "mobvacLimit", String.valueOf(mvTime));
        if (mvTime > (long)(MOBVIC_LIMIT * 60 * 1000)) {
            return false;
        } else {
            if (c.getPlayer() != null) {
                Character var10000 = c.getPlayer();
                long var10002 = mvTime / 1000L / 60L;
                var10000.dropMessage(0, "当前已吸怪" + var10002 + "分钟, 当天剩余可用时间为" + ((long)MOBVIC_LIMIT - mvTime / 1000L / 60L) + "分钟");
            }

            return true;
        }
    }
}
