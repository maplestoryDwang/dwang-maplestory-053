package org.gms.net.opcodes;

import java.util.List;

import static org.gms.net.opcodes.RecvOpcode.*;
import static org.gms.net.opcodes.RecvOpcode.MOVE_PLAYER;
import static org.gms.net.opcodes.RecvOpcode.NPC_ACTION;
import static org.gms.net.opcodes.SendPacketOpcode.*;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/7/11 10:23
 */
public class OpcodeUtil {

    /**
     * 收到的包
     */
    private static final List<Integer> recignoreLists = List.of(
           RecvOpcode.PONG.getValue(),
           RecvOpcode.STRANGE_DATA.getValue(),
           RecvOpcode.FACE_EXPRESSION.getValue(),
           RecvOpcode.MOVE_PLAYER.getValue(),
           RecvOpcode.NPC_ACTION.getValue(),
           RecvOpcode.MOVE_LIFE.getValue()

    );
    /*
        發出的包
     */
    private static final List<Integer> ignoreLists = List.of(
            SendPacketOpcode.PING.getValue(),
//            SendPacketOpcode.MOVE_PET.getValue(),
            SendPacketOpcode.UPDATE_PARTYMEMBER_HP.getValue(),
            SendPacketOpcode.NPC_ACTION.getValue(),
            SendPacketOpcode.MOVE_MONSTER_RESPONSE.getValue()

    );


    public static boolean recvIgnore(int opcode) {
        return recignoreLists.contains(opcode);
    }



    public static boolean sendIgnore(int opcode){
        return ignoreLists.contains(opcode);
    }
}
