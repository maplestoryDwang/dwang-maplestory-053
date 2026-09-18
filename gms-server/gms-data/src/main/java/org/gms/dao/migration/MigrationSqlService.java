package org.gms.dao.migration;

import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.core.row.Db;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.gms.dao.entity.*;
import org.gms.dao.entity.table.AccountsDOTableDef;
import org.gms.dao.entity.table.CharacterAchievementDOTableDef;
import org.gms.dao.entity.table.PetignoresDOTableDef;
import org.gms.dao.mapper.*;
import org.gms.dao.migration.FlexSqlGenerator;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;

import static org.gms.dao.entity.table.CharacterAchievementDOTableDef.CHARACTER_ACHIEVEMENT_D_O;
import static org.gms.dao.entity.table.StoragesDOTableDef.STORAGES_D_O;
import static org.gms.dao.entity.table.AreaInfoDOTableDef.AREA_INFO_D_O;
import static org.gms.dao.entity.table.CharactersDOTableDef.CHARACTERS_D_O;
import static org.gms.dao.entity.table.CooldownsDOTableDef.COOLDOWNS_D_O;
import static org.gms.dao.entity.table.EventstatsDOTableDef.EVENTSTATS_D_O;
import static org.gms.dao.entity.table.FredstorageDOTableDef.FREDSTORAGE_D_O;
import static org.gms.dao.entity.table.InventoryequipmentDOTableDef.INVENTORYEQUIPMENT_D_O;
import static org.gms.dao.entity.table.InventoryitemsDOTableDef.INVENTORYITEMS_D_O;
import static org.gms.dao.entity.table.KeymapDOTableDef.KEYMAP_D_O;
import static org.gms.dao.entity.table.MedalmapsDOTableDef.MEDALMAPS_D_O;
import static org.gms.dao.entity.table.MonsterbookDOTableDef.MONSTERBOOK_D_O;
import static org.gms.dao.entity.table.PetsDOTableDef.PETS_D_O;
import static org.gms.dao.entity.table.PlayerdiseasesDOTableDef.PLAYERDISEASES_D_O;
import static org.gms.dao.entity.table.QuestprogressDOTableDef.QUESTPROGRESS_D_O;
import static org.gms.dao.entity.table.QueststatusDOTableDef.QUESTSTATUS_D_O;
import static org.gms.dao.entity.table.SavedlocationsDOTableDef.SAVEDLOCATIONS_D_O;
import static org.gms.dao.entity.table.ServerQueueDOTableDef.SERVER_QUEUE_D_O;
import static org.gms.dao.entity.table.SkillmacrosDOTableDef.SKILLMACROS_D_O;
import static org.gms.dao.entity.table.SkillsDOTableDef.SKILLS_D_O;
import static org.gms.dao.entity.table.TrocklocationsDOTableDef.TROCKLOCATIONS_D_O;
import static org.gms.dao.entity.table.WishlistsDOTableDef.WISHLISTS_D_O;


public class MigrationSqlService {

    private final AccountsMapper accountsMapper;
    private final StoragesMapper storagesMapper;

    // character
    private final ExtendValueMapper extendValueMapper;
    private final CharactersMapper charactersMapper;
    private final SkillsMapper skillsMapper;
    private final SkillmacrosMapper skillmacrosMapper;
    private final GuildsMapper guildsMapper;
    private final BuddiesMapper buddiesMapper;
    private final BbsThreadsMapper bbsThreadsMapper;
    private final BbsRepliesMapper bbsRepliesMapper;
    private final WishlistsMapper wishlistsMapper;
    private final CharacterAchievementMapper characterAchievementMapper;
    private final CooldownsMapper cooldownsMapper;
    private final PlayerdiseasesMapper playerdiseasesMapper;
    private final AreaInfoMapper areaInfoMapper;
    private final MonsterbookMapper monsterbookMapper;
    private final FamilyCharacterMapper familyCharacterMapper;
    private final FamelogMapper famelogMapper;
    private final FredstorageMapper fredstorageMapper;
    private final KeymapMapper keymapMapper;
    private final SavedlocationsMapper savedlocationsMapper;
    private final TrocklocationsMapper trocklocationsMapper;
    private final EventstatsMapper eventstatsMapper;
    private final ServerQueueMapper serverQueueMapper;

    // quest
    private final MedalmapsMapper medalmapsMapper;
    private final QuestprogressMapper questprogressMapper;
    private final QueststatusMapper queststatusMapper;

    // item
    private final InventoryitemsMapper inventoryitemsMapper;
    private final InventoryequipmentMapper inventoryequipmentMapper;
    private final RingsMapper ringsMapper;
    private final PetsMapper petsMapper;
    private final PetignoresMapper petignoresMapper;


    /**
     * 无 Spring 环境下的无参构造函数
     * 自动从全局的 FlexDbContext 中获取并初始化所有 Mapper 实例
     */
    public MigrationSqlService() {
        // 确保数据库和包扫描已提前初始化
        FlexDbContext.init();

        this.accountsMapper = FlexDbContext.getMapper(AccountsMapper.class);
        this.storagesMapper = FlexDbContext.getMapper(StoragesMapper.class);

        // character
        this.extendValueMapper = FlexDbContext.getMapper(ExtendValueMapper.class);
        this.charactersMapper = FlexDbContext.getMapper(CharactersMapper.class);
        this.skillsMapper = FlexDbContext.getMapper(SkillsMapper.class);
        this.skillmacrosMapper = FlexDbContext.getMapper(SkillmacrosMapper.class);
        this.guildsMapper = FlexDbContext.getMapper(GuildsMapper.class);
        this.buddiesMapper = FlexDbContext.getMapper(BuddiesMapper.class);
        this.bbsThreadsMapper = FlexDbContext.getMapper(BbsThreadsMapper.class);
        this.bbsRepliesMapper = FlexDbContext.getMapper(BbsRepliesMapper.class);
        this.wishlistsMapper = FlexDbContext.getMapper(WishlistsMapper.class);
        this.cooldownsMapper = FlexDbContext.getMapper(CooldownsMapper.class);
        this.playerdiseasesMapper = FlexDbContext.getMapper(PlayerdiseasesMapper.class);
        this.areaInfoMapper = FlexDbContext.getMapper(AreaInfoMapper.class);
        this.monsterbookMapper = FlexDbContext.getMapper(MonsterbookMapper.class);
        this.familyCharacterMapper = FlexDbContext.getMapper(FamilyCharacterMapper.class);
        this.famelogMapper = FlexDbContext.getMapper(FamelogMapper.class);
        this.fredstorageMapper = FlexDbContext.getMapper(FredstorageMapper.class);
        this.keymapMapper = FlexDbContext.getMapper(KeymapMapper.class);
        this.savedlocationsMapper = FlexDbContext.getMapper(SavedlocationsMapper.class);
        this.trocklocationsMapper = FlexDbContext.getMapper(TrocklocationsMapper.class);
        this.eventstatsMapper = FlexDbContext.getMapper(EventstatsMapper.class);
        this.serverQueueMapper = FlexDbContext.getMapper(ServerQueueMapper.class);
        this.characterAchievementMapper = FlexDbContext.getMapper(CharacterAchievementMapper.class);

        // quest
        this.medalmapsMapper = FlexDbContext.getMapper(MedalmapsMapper.class);
        this.questprogressMapper = FlexDbContext.getMapper(QuestprogressMapper.class);
        this.queststatusMapper = FlexDbContext.getMapper(QueststatusMapper.class);

        // item
        this.inventoryitemsMapper = FlexDbContext.getMapper(InventoryitemsMapper.class);
        this.inventoryequipmentMapper = FlexDbContext.getMapper(InventoryequipmentMapper.class);
        this.ringsMapper = FlexDbContext.getMapper(RingsMapper.class);
        this.petsMapper = FlexDbContext.getMapper(PetsMapper.class);
        this.petignoresMapper = FlexDbContext.getMapper(PetignoresMapper.class);
    }

    public List<AccountsDO> getAllAccounts() {

        return accountsMapper.selectAll();
    }


    // 外部调用入口：传入要迁移的账号ID，和最终导出的.sql路径
    public void exportAccountToSqlFile(String accountName, String outputPath) {

        StringBuilder sql = new StringBuilder();
        sql.append("SET NAMES utf8mb4;\n");
        sql.append("SET FOREIGN_KEY_CHECKS = 0;\n\n");
        if (!"-1".equals(accountName)) {
            AccountsDO accountsDO = accountsMapper.selectOneByName(accountName);
            if (accountsDO == null) {
                System.out.println("未找到用户");
                return;
            }
            recordAccFromDB(accountsDO, sql);
        } else {
            // 导入全部
            List<AccountsDO> accountsDOS = accountsMapper.selectAll();
//            accountsDOS.removeIf(accountsDO -> accountsDO.getName().equals("admin"));
            for (AccountsDO accountsDO : accountsDOS) {
                recordAccFromDB(accountsDO, sql);
            }
        }


        try (PrintWriter out = new PrintWriter(new FileWriter(outputPath))) {
            out.println(sql.toString());
            System.out.println("【成功】SQL 脚本成功生成：" + outputPath);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private void recordAccFromDB(AccountsDO accountsDO, StringBuilder sql) {
        Integer accountid = accountsDO.getId();

        sql.append("-- ========================================================\n");
        sql.append("-- 1. 迁移账号: ").append(accountsDO.getName()).append("\n");
        sql.append("-- ========================================================\n");

        // 【全自动】自动生成账号插入语句，因为没有关联，外键字段和变量填 null
        sql.append(FlexSqlGenerator.convertToSql(accountsDO, null, null));

        // 【关键】用 MySQL 变量记住 B 系统刚刚生成的账号自增 ID
        sql.append("SET @current_account_id = LAST_INSERT_ID();\n\n");

        // storages
        List<StoragesDO> storagesDOS = storagesMapper.selectListByQuery(QueryWrapper.create().where(STORAGES_D_O.ACCOUNTID.eq(accountid)));
        sql.append(FlexSqlGenerator.convertToSql(storagesDOS, "accountid", "@current_account_id"));


        // type = 2的inventoryitems


        // 查出该账号下的所有角色
        List<CharactersDO> charactersDOS = charactersMapper.selectBeidouSource(
                accountid // 修正为你表里的外键字段
        );

        for (CharactersDO charactersDO : charactersDOS) {
            sql.append("-- --------------------------------------------------------\n");
            sql.append("-- 2. 迁移角色: ").append(charactersDO.getName()).append("\n");
            sql.append("-- --------------------------------------------------------\n");

            // 【全自动】生成角色插入语句，自动把 Java 属性中的 accountId 替换为 MySQL 变量
            sql.append(FlexSqlGenerator.convertToSql(charactersDO, "accountid", "@current_account_id"));

            // 【关键】用变量重复覆盖刷新，记住当前这个角色刚刚生成的自增 ID
            sql.append("SET @current_char_id = LAST_INSERT_ID();\n\n");

            // 进入角色附属子表数据的全自动拼接
            recordCharFromDB(accountid, charactersDO.getId(), sql);
        }
    }

    private void recordCharFromDB(int accountid, int cid, StringBuilder sql) {

        // 获取成就
        boolean tableExistsInMySQL = isTableExistsInMySQL("character_achievements");
        if (tableExistsInMySQL) {

            List<CharacterAchievementDO> characterAchievementDOS = characterAchievementMapper.selectListByQuery(QueryWrapper.create().where(CHARACTER_ACHIEVEMENT_D_O.CHARACTER_ID.eq(cid)));
            sql.append(FlexSqlGenerator.convertToSql(characterAchievementDOS, "characterId", "@current_char_id"));
        }


        // 获取wishlists ── 自动转换
        List<WishlistsDO> wishlistsDOS = wishlistsMapper.selectListByQuery(QueryWrapper.create().where(WISHLISTS_D_O.CHARID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(wishlistsDOS, "charid", "@current_char_id"));

        // 获取cooldowns ── 自动转换
        List<CooldownsDO> cooldownsDOS = cooldownsMapper.selectListByQuery(QueryWrapper.create().where(COOLDOWNS_D_O.CHARID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(cooldownsDOS, "charid", "@current_char_id"));

        // 获取playerdiseases ── 自动转换
        List<PlayerdiseasesDO> playerdiseasesDOS = playerdiseasesMapper.selectListByQuery(QueryWrapper.create().where(PLAYERDISEASES_D_O.CHARID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(playerdiseasesDOS, "charid", "@current_char_id"));

        // 获取area_info ── 自动转换
        List<AreaInfoDO> areaInfoDOS = areaInfoMapper.selectListByQuery(QueryWrapper.create().where(AREA_INFO_D_O.CHARID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(areaInfoDOS, "charid", "@current_char_id"));

        // 获取monsterbook ── 自动转换
        List<MonsterbookDO> monsterbookDOS = monsterbookMapper.selectListByQuery(QueryWrapper.create().where(MONSTERBOOK_D_O.CHARID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(monsterbookDOS, "charid", "@current_char_id"));

        // 获取任务进度 ── 自动转换
        List<MedalmapsDO> medalmapsDOS = medalmapsMapper.selectListByQuery(QueryWrapper.create().where(MEDALMAPS_D_O.CHARACTERID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(medalmapsDOS, "characterid", "@current_char_id"));

        List<QuestprogressDO> questprogressDOS = questprogressMapper.selectListByQuery(QueryWrapper.create().where(QUESTPROGRESS_D_O.CHARACTERID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(questprogressDOS, "characterid", "@current_char_id"));

        List<QueststatusDO> queststatusDOS = queststatusMapper.selectListByQuery(QueryWrapper.create().where(QUESTSTATUS_D_O.CHARACTERID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(queststatusDOS, "characterid", "@current_char_id"));

        // 获取fredstorage ── 自动转换
        List<FredstorageDO> fredstorageDOS = fredstorageMapper.selectListByQuery(QueryWrapper.create().where(FREDSTORAGE_D_O.CID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(fredstorageDOS, "cid", "@current_char_id"));

        // 获取keymap ── 自动转换
        List<KeymapDO> keymapDOS = keymapMapper.selectListByQuery(QueryWrapper.create().where(KEYMAP_D_O.CHARACTERID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(keymapDOS, "characterid", "@current_char_id"));

        // 获取savedlocations ── 自动转换
        List<SavedlocationsDO> savedlocationsDOS = savedlocationsMapper.selectListByQuery(QueryWrapper.create().where(SAVEDLOCATIONS_D_O.CHARACTERID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(savedlocationsDOS, "characterid", "@current_char_id"));

        // 获取trocklocations ── 自动转换
        List<TrocklocationsDO> trocklocationsDOS = trocklocationsMapper.selectListByQuery(QueryWrapper.create().where(TROCKLOCATIONS_D_O.CHARACTERID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(trocklocationsDOS, "characterid", "@current_char_id"));

        // 技能 ── 自动转换
        List<SkillsDO> skillsDOS = skillsMapper.selectListByQuery(QueryWrapper.create().where(SKILLS_D_O.CHARACTERID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(skillsDOS, "characterid", "@current_char_id"));

        List<SkillmacrosDO> skillmacrosDOS = skillmacrosMapper.selectListByQuery(QueryWrapper.create().where(SKILLMACROS_D_O.CHARACTERID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(skillmacrosDOS, "characterid", "@current_char_id"));

        // 获取eventstats ── 自动转换
        List<EventstatsDO> eventstatsDOS = eventstatsMapper.selectListByQuery(QueryWrapper.create().where(EVENTSTATS_D_O.CHARACTERID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(eventstatsDOS, "characterid", "@current_char_id"));

        // 获取server_queue ── 自动转换
        List<ServerQueueDO> serverQueueDOS = serverQueueMapper.selectListByQuery(QueryWrapper.create().where(SERVER_QUEUE_D_O.CHARACTERID.eq(cid)));
        sql.append(FlexSqlGenerator.convertToSql(serverQueueDOS, "characterid", "@current_char_id"));


        // ========================================================
        // 1. 准备阶段：一次性查出该角色所有的物品和装备，转为内存缓存
        // ========================================================
        // 查出该角色背包里所有的物品
        QueryWrapper itemQueryWrapper = QueryWrapper.create().where(INVENTORYITEMS_D_O.CHARACTERID.eq(cid));
        List<InventoryitemsDO> inventoryItemsDOS = inventoryitemsMapper.selectListByQuery(itemQueryWrapper);

        // 一次性查出该角色名下所有装备属性（不带戒指的）
        List<Long> inventoryItemIds = inventoryItemsDOS.stream().map(InventoryitemsDO::getInventoryitemid).toList();
        List<InventoryequipmentDO> allEquipmentDOS = java.util.Collections.emptyList();

        if (!inventoryItemIds.isEmpty()) {
            allEquipmentDOS = inventoryequipmentMapper.selectListByQuery(
                    QueryWrapper.create()
                            .where(INVENTORYEQUIPMENT_D_O.INVENTORYITEMID.in(inventoryItemIds))
                            .and(INVENTORYEQUIPMENT_D_O.RINGID.isNull().or(INVENTORYEQUIPMENT_D_O.RINGID.eq(-1))) // 过滤戒指(支持null或-1)
            );
        }

        // 【核心优化】：将装备列表转为 Map<inventoryitemid, InventoryequipmentDO> 方便一对一极速匹配
        java.util.Map<Long, InventoryequipmentDO> equipmentMap = allEquipmentDOS.stream()
                .collect(java.util.stream.Collectors.toMap(InventoryequipmentDO::getInventoryitemid, eq -> eq, (k1, k2) -> k1));


        // type != 1的数据，包含仓库、商城仓库
        QueryWrapper itemQueryByAcc = QueryWrapper.create().where(INVENTORYITEMS_D_O.ACCOUNTID.eq(accountid));
        List<InventoryitemsDO> itemQueryByAccDOS = inventoryitemsMapper.selectListByQuery(itemQueryByAcc);
        sql.append(FlexSqlGenerator.convertToSql(itemQueryByAccDOS, "accountid", "@current_account_id"));


        // ========================================================
        // 2. 循环阶段：互斥判断（宠物 vs 装备 vs 其他普通道具）
        // ========================================================
        for (InventoryitemsDO item : inventoryItemsDOS) {
            sql.append("\n-- ----------------------------------------\n");

            // 【情况 A】：它是一个宠物
            if (item.getPetid() > 0) {
                sql.append("-- [宠物类型] 分流处理\n");

                // 去 A 系统查出这个宠物的详细信息 DO
                PetsDO petsDO = petsMapper.selectOneById(item.getPetid());
                // 宠物无视拣去

                if (petsDO != null) {
                    List<PetignoresDO> petignoresDOS = petignoresMapper.selectListByQuery(QueryWrapper.create().where(PetignoresDOTableDef.PETIGNORES_D_O.PETID.eq(item.getPetid())));

                    // ① 先插宠物表，生成新的宠物自增主键
                    sql.append(FlexSqlGenerator.convertToSql(petsDO, null, null));
                    sql.append("SET @current_pet_id = LAST_INSERT_ID();\n");

                    sql.append(FlexSqlGenerator.convertToSql(petignoresDOS, "petid", "@current_pet_id"));


                } else {
                    sql.append("SET @current_pet_id = NULL;\n");
                }

                // ② 插入物品主体（带上外键 @current_char_id）
                sql.append(FlexSqlGenerator.convertToSql(item, "characterid", "@current_char_id"));
                sql.append("SET @current_item_id = LAST_INSERT_ID();\n");

                // ③ 修正把 B 系统刚生成的宠物 ID 绑定回物品上
                sql.append("UPDATE `inventoryitems` SET `petid` = @current_pet_id WHERE `inventoryitemid` = @current_item_id;\n");
            }

            // 【情况 B】：它是一件装备（通过一对一 Map 进行匹配判断）
            else if (equipmentMap.containsKey(item.getInventoryitemid())) {
                sql.append("-- [装备道具] 分流处理\n");

                // ① 先插入物品主体，获取最新的物品自增主键
                sql.append(FlexSqlGenerator.convertToSql(item, "characterid", "@current_char_id"));
                sql.append("SET @current_item_id = LAST_INSERT_ID();\n");

                // ② 从内存 Map 拿到跟它一对一对应的装备属性
                InventoryequipmentDO eq = equipmentMap.get(item.getInventoryitemid());

                // ③ 插入装备表，由于 inventoryequipment 表本身有自增主键 inventoryequipmentid（我们会过滤掉），
                // 它的外键 inventoryitemid 必须通过参数完美替换为刚刚生成的物品变量 @current_item_id
                sql.append(FlexSqlGenerator.convertToSql(eq, "inventoryitemid", "@current_item_id"));
            }

            // 【情况 C】：其他普通道具（消耗品/材料/etc.）
            else {
                sql.append("-- [普通道具] 分流处理\n");

                // 没有任何附属关联表，无脑插完物品主体即可，干净利落
                sql.append(FlexSqlGenerator.convertToSql(item, "characterid", "@current_char_id"));
            }
        }
    }

    private boolean isTableExistsInMySQL(String tableName) {
        String checkSql = "SELECT COUNT(1) FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = ?";
        Long count = (Long) Db.selectObject(checkSql, tableName);
        return count != null && count > 0;
    }

}
