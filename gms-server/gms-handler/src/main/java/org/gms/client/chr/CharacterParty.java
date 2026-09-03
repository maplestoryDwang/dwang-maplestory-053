package org.gms.client.chr;

/**
 * 8. CharacterParty – 队伍
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/3 15:41
 */

import org.gms.client.Character;
import org.gms.net.server.world.Party;
import org.gms.net.server.world.PartyCharacter;
import org.gms.server.maps.Door;
import org.gms.server.partyquest.PartyQuest;

import java.util.Collection;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CharacterParty {
    private final CharacterV2 parent;

    private Party party;
    private PartyCharacter mpc;
    private PartyQuest partyQuest;

    public CharacterParty(CharacterV2 parent) { this.parent = parent; }

    public int getPartyId() { /* 原逻辑 */ return -1; }
    public List<CharacterV2> getPartyMembersOnline() { /* 原逻辑 */ return null; }
    public List<CharacterV2> getPartyMembersOnSameMap() { /* 原逻辑 */ return null; }
    public boolean isPartyMember(CharacterV2 chr) { /* 原逻辑 */ return false; }
    public boolean isPartyMember(int cid) { /* 原逻辑 */ return false; }
    public boolean isPartyLeader() { /* 原逻辑 */ return false; }
    public boolean leaveParty() { /* 原逻辑 */ return false; }
    public void silentPartyUpdate() { /* 原逻辑 */ }
    private void silentPartyUpdateInternal(Party chrParty) { /* 原逻辑 */ }
    public void partyOperationUpdate(Party party, List<CharacterV2> exPartyMembers) { /* 原逻辑 */ }
    public void updatePartyMemberHP() { /* 原逻辑 */ }
    private void updatePartyMemberHPInternal() { /* 原逻辑 */ }
    public void receivePartyMemberHP() { /* 原逻辑 */ }

    // 门
    public void applyPartyDoor(Door door, boolean partyUpdate) { /* 原逻辑 */ }
    public Door removePartyDoor(boolean partyUpdate) { /* 原逻辑 */ return null; }
    private void removePartyDoor(Party formerParty) { /* 原逻辑 */ }
    public int getDoorSlot() { /* 原逻辑 */ return 0; }
    public int fetchDoorSlot() { /* 原逻辑 */ return 0; }
    public Door getPlayerDoor() { /* 原逻辑 */ return null; }
    public Door getMainTownDoor() { /* 原逻辑 */ return null; }
    public Collection<Door> getDoors() { /* 原逻辑 */ return null; }

    // 队伍物品掉落
    private static void addPartyPlayerDoor(Character target) { /* 原逻辑 */ }
    private static void removePartyPlayerDoor(Party party, Character target) { /* 原逻辑 */ }
    private static void updatePartyTownDoors(Party party, Character target, Character partyLeaver, List<Character> partyMembers) { /* 原逻辑 */ }
}