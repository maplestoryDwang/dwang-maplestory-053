package org.gms.client.chr;

import lombok.Getter;
import lombok.Setter;
import org.gms.client.status.SkinColor;

/**
 * 2. CharacterIdentity – 身份/权限
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/3 15:33
 */

@Getter
@Setter
public class CharacterIdentity {
    private final CharacterV2 parent;

    private int id;
    private int accountId;
    private String name;
    private int world;
    private int gender;
    private SkinColor skinColor;
    private int hair;
    private int face;
    private int gmLevel;
    private boolean whiteChat;
    private boolean hidden;
    private boolean banned;

    public CharacterIdentity(CharacterV2 parent) { this.parent = parent; }

    // 身份判断
    public boolean isMale() { /* 原逻辑 */ return false; }
    public String getMedalText() { /* 原逻辑 */ return ""; }
    public boolean isGM() { /* 原逻辑 */ return false; }
    public int gmLevel() { /* 原逻辑 */ return 0; }
    public boolean isGmJob() { /* 原逻辑 */ return false; }
    public boolean isCygnus() { /* 原逻辑 */ return false; }
    public boolean isAran() { /* 原逻辑 */ return false; }
    public boolean isBeginnerJob() { /* 原逻辑 */ return false; }
    public boolean getWhiteChat() { /* 原逻辑 */ return false; }
    public void toggleWhiteChat() { /* 原逻辑 */ }
    public void hide(boolean hide) { /* 原逻辑 */ }
    public void hide(boolean hide, boolean login) { /* 原逻辑 */ }
    public void toggleHide(boolean login) { /* 原逻辑 */ }

    // 静态工具
    public static int getAccountIdByName(String name) { /* 原逻辑 */ return -1; }
    public static int getIdByName(String name) { /* 原逻辑 */ return -1; }
    public static String getNameById(int id) { /* 原逻辑 */ return null; }
    public static boolean canCreateChar(String name) { /* 原逻辑 */ return false; }
    public static boolean existName(String name) { /* 原逻辑 */ return false; }
    public static String makeMapleReadable(String in) { /* 原逻辑 */ return ""; }
}