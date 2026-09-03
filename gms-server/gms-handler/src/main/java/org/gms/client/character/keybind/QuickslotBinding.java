package org.gms.client.character.keybind;

import org.gms.net.packet.OutPacket;

import java.util.Arrays;

/**
 * @author Shavit
 */
public class QuickslotBinding {
    // Expanded quickslot bar: 30 slots (two rows of 15). Must match the client mod
    // (kaentake quickslots.cpp) and the quickslotkeymapped DB column width.
    public static final int QUICKSLOT_SIZE = 30;

    // Mirrors the client's Array_aDefaultQKM default key layout.
    public static final byte[] DEFAULT_QUICKSLOTS = {
            0x2A, 0x52, 0x47, 0x49, 0x02, 0x03, 0x04, 0x05, 0x06, 0x1E,
            0x1F, 0x20, 0x21, 0x1D, 0x53, 0x4F, 0x51, 0x10, 0x11, 0x12,
            0x13, 0x14, 0x2C, 0x2D, 0x2E, 0x2F, 0x34, 0x07, 0x08, 0x09
    };

    private final byte[] m_aQuickslotKeyMapped;

    // Initializes quickslot object for the user.
    // aKeys' length has to be QUICKSLOT_SIZE.
    public QuickslotBinding(byte[] aKeys) {
        if (aKeys.length != QUICKSLOT_SIZE) {
            throw new IllegalArgumentException(String.format("aKeys' size should be %d", QUICKSLOT_SIZE));
        }

        this.m_aQuickslotKeyMapped = aKeys.clone();
    }

    // Coerces stored/legacy data to exactly QUICKSLOT_SIZE bytes. Shorter rows
    // (e.g. the old 8-byte BIGINT layout) keep their existing keys and fill the
    // remaining slots from the defaults; longer rows are truncated.
    public static byte[] normalize(byte[] raw) {
        byte[] out = DEFAULT_QUICKSLOTS.clone();
        if (raw != null && raw.length > 0) {
            System.arraycopy(raw, 0, out, 0, Math.min(raw.length, QUICKSLOT_SIZE));
        }
        return out;
    }

    public void encode(OutPacket p) {
        // Quickslots are default.
        // The client will skip them and call CQuickslotKeyMappedMan::DefaultQuickslotKeyMap.
        if (Arrays.equals(this.m_aQuickslotKeyMapped, DEFAULT_QUICKSLOTS)) {
            p.writeBool(false);
            return;
        }

        p.writeBool(true);

        for (byte nKey : this.m_aQuickslotKeyMapped) {
            // For some reason Nexon sends these as integers, similar to CFuncKeyMappedMan.
            // However there's no evidence any key can be above 0xFF anyhow.
            // Regardless, we need to encode an integer to avoid an error 38 crash; as CFuncKeyMapped::m_aQuickslotKeyMapped is int[QUICKSLOT_SIZE].
            p.writeInt(nKey);
        }
    }

    public byte[] GetKeybindings() {
        return m_aQuickslotKeyMapped;
    }

}