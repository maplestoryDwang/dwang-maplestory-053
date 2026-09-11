package org.gms.server.life;

import lombok.Getter;
import org.gms.provider.*;
import org.gms.provider.wz.WzFiles;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * 加载INFO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/11 9:58
 */
@Service
public class NPCInfomationProvier {

    @Getter
    private final static DataProvider npcDataWZ = DataProviderFactory.getDataProvider(WzFiles.NPC);
    @Getter
    private final static Map<Integer, String> scriptMap = new HashMap<>();

    static {
        DataDirectoryEntry root = npcDataWZ.getRoot();

        for (DataFileEntry file : root.getFiles()) {
            String fileName = file.getName();
            int dotIndex = fileName.indexOf('.');
            if (dotIndex == -1) {
                continue;
            }

            int npcId;
            try {
                npcId = Integer.parseInt(fileName.substring(0, dotIndex));
            } catch (NumberFormatException e) {
                continue;
            }

            Data npcData = npcDataWZ.getData(fileName);
            if (npcData == null) {
                continue;
            }

            Data infoNode = npcData.getChildByPath("info");
            if (infoNode == null) {
                continue;
            }

            Data scriptRoot = infoNode.getChildByPath("script");
            if (scriptRoot == null) {
                continue;
            }

            // info/script 下面可能有 0、1、2 ...
            for (Data scriptEntry : scriptRoot.getChildren()) {
                Data scriptValueNode = scriptEntry.getChildByPath("script");
                if (scriptValueNode == null) {
                    continue;
                }

                Object value = scriptValueNode.getData();
                if (value == null) {
                    continue;
                }

                String scriptName = value.toString();
                if (!scriptName.isEmpty()) {
                    scriptMap.put(npcId, scriptName);
                    // 如果同一个 NPC 可能有多个脚本，建议不要直接 put，
                    // 而是用 Map<Integer, List<String>>
                }
            }
        }

    }

    public static String getScriptName(int npcId) {
        return scriptMap.get(npcId);
    }

}
