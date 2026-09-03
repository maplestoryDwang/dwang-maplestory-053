package org.gms.client.chr;

/**
 * 14. CharacterSocial – 好友/聊天/迷你游戏
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/3 15:43
 */

import org.gms.client.Client;
import org.gms.client.character.buddy.BuddyList;
import org.gms.client.character.buddy.BuddylistEntry;
import org.gms.net.packet.Packet;
import org.gms.net.server.world.Messenger;
import org.gms.server.maps.MiniGame;
import org.gms.server.minigame.RockPaperScissor;


import lombok.Getter;
import lombok.Setter;
import org.gms.server.maps.MiniGame.MiniGameResult;

@Getter
@Setter
public class CharacterSocial {
    private final CharacterV2 parent;

    private BuddyList buddylist;
    private Messenger messenger;
    private int messengerPosition = 4;
    private MiniGame miniGame;
    private RockPaperScissor rps;
    private String chalktext;
    private String commandtext;

    // 迷你游戏胜负
    private int omokwins, omokties, omoklosses;
    private int matchcardwins, matchcardties, matchcardlosses;

    public CharacterSocial(CharacterV2 parent) { this.parent = parent; }

    // 好友
    public void deleteBuddy(int otherCid) { /* 原逻辑 */ }
    private void nextPendingRequest(Client c) { /* 原逻辑 */ }
    private void notifyRemoteChannel(Client c, int remoteChannel, int otherCid, BuddyList.BuddyOperation operation) { /* 原逻辑 */ }
    public void setBuddyCapacity(int capacity) { /* 原逻辑 */ }

    // 信使
    public void checkMessenger() { /* 原逻辑 */ }
    public void closePlayerMessenger() { /* 原逻辑 */ }

    // 迷你游戏
    public void closeMiniGame(boolean forceClose) { /* 原逻辑 */ }
    public void closeRPS() { /* 原逻辑 */ }
    public void setMiniGamePoints(CharacterV2 visitor, int winnerslot, boolean omok) { /* 原逻辑 */ }
    public int getMiniGamePoints(MiniGameResult type, boolean omok) { /* 原逻辑 */ return 0; }

    // 黑板/命令
    public String getChalkboard() { return chalktext; }
    public void setChalkboard(String text) { this.chalktext = text; }
    public String getLastCommandMessage() { return commandtext; }
    public void setLastCommandMessage(String text) { this.commandtext = text; }

    // 广播
    public void broadcastAcquaintances(int type, String message) { /* 原逻辑 */ }
    public void broadcastAcquaintances(Packet packet) { /* 原逻辑 */ }
    public void broadcastStance(int newStance) { /* 原逻辑 */ }
    public void broadcastStance() { /* 原逻辑 */ }
}