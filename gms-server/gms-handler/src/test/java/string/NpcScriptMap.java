package string;

import org.gms.ServerApplication;
import org.gms.server.MapStrInfo;
import org.gms.server.StringInfoProvider;
import org.gms.server.life.NPCInfomationProvier;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.Map;
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
}
