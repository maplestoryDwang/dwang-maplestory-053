package string;

import org.gms.ServerApplication;
import org.gms.constants.id.NpcId;
import org.gms.scripting.npc.NPCScriptManager;
import org.gms.server.MapStrInfo;
import org.gms.server.StringInfoProvider;
import org.gms.server.life.NPCInfomationProvier;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.File;
import java.io.IOException;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/11 10:09
 */
@SpringBootTest(classes = ServerApplication.class)// 可选：指定测试用的 profile（例如 application-test.yml）
public class NpcScriptMap {

    Logger log = LoggerFactory.getLogger(NpcScriptMap.class);


   @Test
    public void loadNpcScriptMap() {

       Map<Integer, String> scriptMap = NPCInfomationProvier.getScriptMap();
       AtomicInteger canClick = new AtomicInteger();
       scriptMap.keySet().stream().sorted().forEach(npcId -> {
           String mapName = getNpcExistMapName(npcId);
           String npcName = StringInfoProvider.getNPCName(npcId);
           if ("当前版本不存在".equals(mapName)){
               System.out.println("脚本ID:" + npcId + " NPC: " + npcName + " map: " + mapName);
           } else {
               canClick.getAndIncrement();
           }
       });
       System.out.println("可点击数量:  " + canClick.get());

   }

    public static String getNpcExistMapName(Integer npcId) {
        List<MapStrInfo> mapStrInfos = StringInfoProvider.getNPC_EXIST_MAP().get(npcId);
        StringBuilder stringBuilder = new StringBuilder();
        if (mapStrInfos == null || mapStrInfos.size() == 0) {
            return "当前版本不存在";
        }
        for (MapStrInfo mapStrInfo : mapStrInfos) {
            stringBuilder.append(mapStrInfo.mapName).append("(").append(mapStrInfo.mapId).append(")  ");
        }
        return stringBuilder.toString();
    }

    /**
     * 测试当前还有多少NPC没实现脚本，脚本都在NPC目录下
     */
    @Test
    public void checkScriptExit() {
        Map<Integer, String> scriptMap = NPCInfomationProvier.getScriptMap();
        Set<Integer> npcIdList = scriptMap.keySet();
        Collection<String> scriptsNameList = scriptMap.values();

        Path scriptPath = Path.of("scripts-zh-CN/npc");
        File npcDir = scriptPath.toFile();
        List<String> existNpcFileName = new ArrayList<>();
        if (npcDir.isDirectory()) {
            listFiles(scriptPath.toAbsolutePath().toString(), existNpcFileName);
        }

        Iterator<Integer> iterator = npcIdList.iterator();
        while (iterator.hasNext()) {
            Integer npcNumberId = iterator.next();
            if (npcNumberId >= NpcId.GACHAPON_MIN && npcNumberId <= NpcId.GACHAPON_MAX) {
                iterator.remove();

                continue;
            }
            String npcId = npcNumberId.toString();
            if (existNpcFileName.contains(npcId)) {
                iterator.remove();
            } else{
                String npcScriptName = scriptMap.get(npcNumberId);
                if (existNpcFileName.contains(npcScriptName)) {
                    iterator.remove();
                } else {
                    String mapName = getNpcExistMapName(npcNumberId);
                    String npcName = StringInfoProvider.getNPCName(npcNumberId);
                    log.info( "当前NPC未实现：{}({}) scriptName : {}, map:{}", npcName, npcNumberId, npcScriptName, mapName);
                }

            }
        }
    }


    public boolean isNumeric(String str) {
        if (str == null || str.isEmpty()) return false;
        try {
            Integer.parseInt(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    private void listFiles(String directoryName, List<String> files) {
        Path directory = Path.of(directoryName);

        // get all the files from a directory
        try (DirectoryStream<Path> stream = Files.newDirectoryStream(directory)) {
            for (Path path : stream) {
                if (Files.isRegularFile(path)) {
                    String name = path.toFile().getName();
                    String jsName = name.replace(".js", "");
                    files.add(jsName);
                } else if (Files.isDirectory(path)) {
                    listFiles(path.toAbsolutePath().toString(), files);
                }
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

}
