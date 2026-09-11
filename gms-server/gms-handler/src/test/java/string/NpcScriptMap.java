package string;

import org.gms.ServerApplication;
import org.gms.provider.DataProvider;
import org.gms.server.life.NPCInfomationProvier;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.util.Map;

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
   }
}
