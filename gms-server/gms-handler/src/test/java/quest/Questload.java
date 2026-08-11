package quest;

import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.provider.wz.XMLWZFile;

import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/11 10:27
 */
public class Questload {

    public static void main(String[] args) {
        Path enPath = Path.of("E:\\game\\ms\\gms053\\server\\gms53-Server\\gms-server\\gms-handler\\wz\\Quest.wz");
        XMLWZFile xmlwzFile = new XMLWZFile(enPath);
        Data questInfoData = xmlwzFile.getData("QuestInfo.img");
        Map<Integer, String> questNames = new HashMap<>();

        for (Data quest : questInfoData.getChildren()) {
            int questID = Integer.parseInt(quest.getName());
            Data reqInfo = questInfoData.getChildByPath(quest.getName());
            if (reqInfo != null) {
                String name = DataTool.getString("name", reqInfo, "");
                questNames.put(questID, name);

            }
        }
        System.out.println(questNames);

    }
}
