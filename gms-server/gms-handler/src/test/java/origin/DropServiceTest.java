package origin; /**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/24 16:29
 */

import com.mybatisflex.core.query.QueryWrapper;
import org.gms.ServerApplication;
import org.gms.dao.entity.DropDataDO;
import org.gms.dao.mapper.DropDataMapper;
import org.gms.server.ItemInformationProvider;
import org.gms.service.DropService; // 假设 DropService 位于 org.gms.service 包下
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static org.gms.dao.entity.table.DropDataDOTableDef.DROP_DATA_D_O;

// 启动完整的 Spring 上下文，但不启动 Web 服务器（提高测试速度）
@SpringBootTest(classes = ServerApplication.class)// 可选：指定测试用的 profile（例如 application-test.yml）
@ActiveProfiles("test")
public class DropServiceTest {

    @Autowired
    private DropService dropService;

    @Autowired
    private DropDataMapper dropDataMapper;


    @Test
    void testDropServiceInjection() {
        // 仅验证注入是否成功，若 dropService 不为 null 则通过
        assert dropService != null;
    }

    // 在这里添加您的具体业务测试方法
    @Test
    void syncDropDataFromXml() {
        // 1. 解析 XML 获取掉落数据
//        Path cnPath = Path.of("E:\\javaguide\\053\\dwang-maplestory-old\\table");
        Path cnPath = Path.of("E:\\game\\ms\\gms053\\server\\gms53-Server\\table");
        Map<Integer, DropGroup> rewardMap = DropRewardParser.parseReward(cnPath, "Reward_ori.img", DropGroupType.MOB);

        // 2. 从数据库获取所有不同的 dropperid（使用 groupBy）
        QueryWrapper queryWrapper = QueryWrapper.create()
                .select(DROP_DATA_D_O.DROPPERID)      // 只查询这一列
                .groupBy(DROP_DATA_D_O.DROPPERID);    // 去重

        List<DropDataDO> list = dropDataMapper.selectListByQuery(queryWrapper);
        // 提取 dropperid 列表（去重）
        List<Integer> dropIds = list.stream()
                .map(DropDataDO::getDropperid)
                .collect(Collectors.toList());

        System.out.println("共发现 " + dropIds.size() + " 个不同的怪物 ID，开始同步...");

        // 3. 逐个同步
        for (Integer dropId : dropIds) {
            updateDropFromXml(dropId, rewardMap);
        }

        System.out.println("所有怪物掉落同步完成！");
    }

    private void updateDropFromXml(Integer dropId, Map<Integer, DropGroup> rewardMap) {

        // 2. 从数据库查询该怪物的现有掉落记录
        QueryWrapper queryWrapper = QueryWrapper.create().where(DROP_DATA_D_O.DROPPERID.eq(dropId));
        List<DropDataDO> dbList = dropDataMapper.selectListByQuery(queryWrapper);


        // 假设我们要同步的怪物ID（可以从参数传入或循环所有）
        DropGroup dropGroup = rewardMap.get(dropId);
        if (dropGroup == null) {
            System.out.println("XML中未找到怪物 " + dropId + " 的掉落数据 ，当前决定保留");
//            // xml没有的数据全部删除
//            for (DropDataDO dropDataDO : dbList) {
//                dropDataMapper.deleteById(dropDataDO.getId());
//            }
            return;
        }



        // 3. 将 XML 条目转为 Map（key = itemid，value = DropEntry）
        //    注意：金币条目 itemid = 0，但一个怪物只有一个金币条目，直接覆盖
        Map<Integer, DropEntry> xmlEntryMap = new HashMap<>();
        for (DropEntry entry : dropGroup.getEntries()) {
            if (entry.getMoney() !=null && entry.getMoney() > 0) {
                // 金币条目使用 itemid = 0 作为键
                xmlEntryMap.put(0, entry);
            } else if (entry.getItem() != null && entry.getItem() > 0) {
                xmlEntryMap.put(entry.getItem(), entry);
            }
        }

        // 4. 分别收集需要新增、更新、删除的记录
        List<DropDataDO> toInsert = new ArrayList<>();
        List<DropDataDO> toUpdate = new ArrayList<>();
        List<DropDataDO> toDelete = new ArrayList<>();

        // 4.1 遍历数据库现有记录，判断是更新还是删除
        for (DropDataDO dbRecord : dbList) {
            Integer itemid = dbRecord.getItemid();
            DropEntry xmlEntry = xmlEntryMap.get(itemid);

            // 任务道具就保留，不是任务道具就丢
            if (xmlEntry == null && dbRecord.getQuestid() != 0) {
                // 直接加回去得了
                toUpdate.add(dbRecord);
            } else if (xmlEntry == null ){
                // XML 中没有该物品，标记删除
                toDelete.add(dbRecord);
            }
            else {
                // XML 中有对应物品，更新字段
                dbRecord.setChance(xmlEntry.getProb());
                // 金币的特殊处理
                if (itemid == 0) {
                    dbRecord.setMinimumQuantity(xmlEntry.getMoney());
                    dbRecord.setMaximumQuantity(xmlEntry.getMoney());
                    // 更新概率
                    dbRecord.setChance(xmlEntry.getProb());
                } else {
                    // 普通物品，更新等级限制（如果 XML 有提供）
                    if (xmlEntry.getMin() != null) {
                        dbRecord.setMinimumQuantity(xmlEntry.getMin());
                    }
                    if (xmlEntry.getMax() != null) {
                        dbRecord.setMaximumQuantity(xmlEntry.getMax());
                    }
                    // 主要修改概率
                    dbRecord.setChance(xmlEntry.getProb());

                    // 可能还有其它字段，如过期时间等，可自行扩展

                }
                toUpdate.add(dbRecord);
                // 从 XML Map 中移除已处理的条目，剩下的就是需要新增的
                xmlEntryMap.remove(itemid);
            }
        }

        // 4.2 遍历 XML 中剩余的条目（即数据库中不存在的），新增
        for (Map.Entry<Integer, DropEntry> entry : xmlEntryMap.entrySet()) {
            Integer itemid = entry.getKey();
            DropEntry xmlEntry = entry.getValue();

            DropDataDO newRecord = new DropDataDO();
            newRecord.setDropperid(dropId);
            newRecord.setItemid(itemid);
            newRecord.setChance(xmlEntry.getProb());

            if (itemid == 0) {
                // 金币
                newRecord.setMinimumQuantity(xmlEntry.getMoney());
                newRecord.setMaximumQuantity(xmlEntry.getMoney());
                newRecord.setQuestid(0);

            } else {
                // 普通物品
                if (xmlEntry.getMin() != null) {
                    newRecord.setMinimumQuantity(xmlEntry.getMin());
                } else {
                    newRecord.setMinimumQuantity(1);
                }
                if (xmlEntry.getMax() != null) {
                    newRecord.setMaximumQuantity(xmlEntry.getMax());
                } else {
                    newRecord.setMaximumQuantity(1);
                }
                // 其他字段（如过期时间、地区限制等）可以设置默认值或从 XML 获取
                newRecord.setQuestid(0);

            }
            toInsert.add(newRecord);
        }

        // 5. 执行数据库操作，并打印日志
        System.out.println("XML中开始更新怪物 " + dropId + " 的掉落数据");

        if (!toDelete.isEmpty()) {
            System.out.println("=== 需要删除的记录（共 " + toDelete.size() + " 条）===");
            toDelete.forEach(rec -> System.out.println("  itemid=" + rec.getItemid()));
            for (DropDataDO dropDataDO : toDelete) {
                Long id = dropDataDO.getId();
                dropDataMapper.deleteById(id);
            }
        }

        // 5.2 更新（循环单条更新）
        if (!toUpdate.isEmpty()) {
            System.out.println("=== 需要更新的记录（共 " + toUpdate.size() + " 条）===");
            toUpdate.forEach(rec -> System.out.println("  itemid=" + rec.getItemid() + ", chance=" + rec.getChance()));
            for (DropDataDO record : toUpdate) {
                // MyBatis-Flex 的 update 方法根据主键更新非 null 字段
                dropDataMapper.update(record);
            }
        }


        if (!toInsert.isEmpty()) {
            System.out.println("=== 需要新增的记录（共 " + toInsert.size() + " 条）===");
            toInsert.forEach(rec -> {
                System.out.println("  itemid=" + rec.getItemid() + ", chance=" + rec.getChance());
                String name = ItemInformationProvider.getInstance().getName(rec.getItemid());
                if (name == null) {
                    System.out.println("WZ没找到这个item, 不插入=" + rec.getItemid() );
                } else {
                    System.out.println("WZ到这个item, 即将插入=" + rec.getItemid() + " name = " + name);
                    dropDataMapper.insert(rec);
                }
            });
        }

    }
}
