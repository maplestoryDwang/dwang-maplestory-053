package org.gms.client.chr;

/**
 * 2.15 CharacterEvent – 活动/事件/小游戏积分等
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/3 15:44
 */

import org.gms.scripting.event.EventInstanceManager;
import org.gms.server.events.Events;
import org.gms.server.partyquest.AriantColiseum;
import org.gms.server.partyquest.MonsterCarnival;
import org.gms.server.partyquest.MonsterCarnivalParty;

import java.util.LinkedHashMap;
import java.util.Map;


import lombok.Getter;
import lombok.Setter;
import org.gms.model.pojo.NewYearCardRecord;
import org.gms.server.events.gm.Fitness;
import org.gms.server.events.gm.Ola;
import java.util.*;
import java.util.concurrent.ScheduledFuture;

@Getter
@Setter
public class CharacterEvent {
    private final CharacterV2 parent;

    private EventInstanceManager eventInstance;
    private Map<String, Events> events = new LinkedHashMap<>();
    private AriantColiseum ariantColiseum;
    private MonsterCarnival monsterCarnival;
    private MonsterCarnivalParty monsterCarnivalParty;
    private Fitness fitness;
    private Ola ola;

    // 积分/等级
    private int dojoPoints;
    private int dojoStage;
    private int dojoEnergy;
    private int ariantPoints;
    private int vanquisherStage;
    private int vanquisherKills;
    private boolean finishedDojoTutorial;

    // CPQ
    private byte team = 0;
    private int cp = 0;
    private int totCP = 0;
    private int FestivalPoints;
    private boolean challenged = false;
    private long snowballattack;
    private ScheduledFuture<?> cpqSchedule;

    // 新年卡
    private final Set<NewYearCardRecord> newyears = new LinkedHashSet<>();

    public CharacterEvent(CharacterV2 parent) { this.parent = parent; }

    // 实例
    public void setEventInstance(EventInstanceManager eventInstance) { /* 原逻辑 */ }
    private void eventChangedMap(int map) { /* 原逻辑 */ }
    private void eventAfterChangedMap(int map) { /* 原逻辑 */ }

    // CPQ
    public int getCP() { return cp; }
    public void setCP(int a) { /* 原逻辑 */ }
    public int getTotalCP() { return totCP; }
    public void setTotalCP(int a) { /* 原逻辑 */ }
    public void gainCP(int gain) { /* 原逻辑 */ }
    public void resetCP() { /* 原逻辑 */ }
    public void setCpqTimer(ScheduledFuture<?> timer) { /* 原逻辑 */ }
    public void clearCpqTimer() { /* 原逻辑 */ }

    // 道场
    public int addDojoPointsByMap(int mapId) { /* 原逻辑 */ return 0; }
    private long getDojoTimeLeft() { /* 原逻辑 */ return 0; }
    public void showDojoClock() { /* 原逻辑 */ }

    // 阿里安特
    public void updateAriantScore() { /* 原逻辑 */ }
    public void updateAriantScore(int dropQty) { /* 原逻辑 */ }
    public void gainAriantPoints(int points) { /* 原逻辑 */ }

    // 节日积分
    public void gainFestivalPoints(int gain) { /* 原逻辑 */ }

    // 雪球
    public long getLastSnowballAttack() { return snowballattack; }
    public void setLastSnowballAttack(long time) { this.snowballattack = time; }

    // 新年卡
    public Set<NewYearCardRecord> getNewYearRecords() { return newyears; }
    public Set<NewYearCardRecord> getReceivedNewYearRecords() { /* 原逻辑 */ return null; }
    public NewYearCardRecord getNewYearRecord(int cardid) { /* 原逻辑 */ return null; }
    public void addNewYearRecord(NewYearCardRecord newyear) { /* 原逻辑 */ }
    public void removeNewYearRecord(NewYearCardRecord newyear) { /* 原逻辑 */ }

    // 事件脚本入口
    public void enteredScript(String script, int mapid) { /* 原逻辑 */ }
    public boolean hasEntered(String script) { /* 原逻辑 */ return false; }
    public boolean hasEntered(String script, int mapId) { /* 原逻辑 */ return false; }
    public void resetEnteredScript() { /* 原逻辑 */ }
    public void resetEnteredScript(int mapId) { /* 原逻辑 */ }
    public void resetEnteredScript(String script) { /* 原逻辑 */ }

    // CPQ 队伍
    public void setTeam(int team) { this.team = (byte) team; }
}