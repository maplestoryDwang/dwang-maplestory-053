package org.gms.service;

import com.mybatisflex.core.query.QueryWrapper;
import lombok.AllArgsConstructor;
import org.gms.server.quest.QuestStatus;
import org.gms.dao.entity.MedalmapsDO;
import org.gms.dao.entity.QuestprogressDO;
import org.gms.dao.entity.QueststatusDO;
import org.gms.dao.mapper.MedalmapsMapper;
import org.gms.dao.mapper.QuestprogressMapper;
import org.gms.dao.mapper.QueststatusMapper;
import org.gms.server.quest.QuestV2;
import org.gms.server.quest.QuestRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.concurrent.TimeUnit;

import static org.gms.dao.entity.table.MedalmapsDOTableDef.MEDALMAPS_D_O;
import static org.gms.dao.entity.table.QuestprogressDOTableDef.QUESTPROGRESS_D_O;
import static org.gms.dao.entity.table.QueststatusDOTableDef.QUESTSTATUS_D_O;

/**
 * 用户的任务数据记录
 */
@Service
@AllArgsConstructor
public class QuestUserDataService {
    private final MedalmapsMapper medalmapsMapper;
    private final QuestprogressMapper questprogressMapper;
    private final QueststatusMapper queststatusMapper;

    @Transactional(rollbackFor = Exception.class)
    public void deleteQuestProgressWhereCharacterId(int cid) {
        medalmapsMapper.deleteByQuery(QueryWrapper.create().where(MEDALMAPS_D_O.CHARACTERID.eq(cid)));
        questprogressMapper.deleteByQuery(QueryWrapper.create().where(QUESTPROGRESS_D_O.CHARACTERID.eq(cid)));
        queststatusMapper.deleteByQuery(QueryWrapper.create().where(QUESTSTATUS_D_O.CHARACTERID.eq(cid)));
    }

    /**
     * 获取所有用户的任务状态
     * @param cid
     * @return
     */
    public List<QuestStatus> getQuestStatusByCharacter(int cid) {
        List<QueststatusDO> queststatusDOList = queststatusMapper.selectListByQuery(QueryWrapper.create().where(QUESTSTATUS_D_O.CHARACTERID.eq(cid)));
        List<QuestprogressDO> questprogressDOList = questprogressMapper.selectListByQuery(QueryWrapper.create().where(QUESTPROGRESS_D_O.CHARACTERID.eq(cid)));
        List<MedalmapsDO> medalmapsDOList = medalmapsMapper.selectListByQuery(QueryWrapper.create().where(MEDALMAPS_D_O.CHARACTERID.eq(cid)));

        return queststatusDOList.stream().map(queststatusDO -> {
            QuestV2 quest = QuestRepository.getInstance(queststatusDO.getQuest());
            QuestStatus questStatus = new QuestStatus(quest.getId(), QuestStatus.Status.getById(queststatusDO.getStatus()));
            if (queststatusDO.getTime() > -1) {
                questStatus.setCompletionTime(TimeUnit.SECONDS.toMillis(queststatusDO.getTime()));
            }
            if (queststatusDO.getExpires() > 0) {
                questStatus.setExpirationTime(queststatusDO.getExpires());
            }
            questStatus.setForfeited(queststatusDO.getForfeited());
            questStatus.setCompleted(queststatusDO.getCompleted());
            questprogressDOList.stream()
                    .filter(questprogressDO -> Objects.equals(queststatusDO.getQueststatusid(), questprogressDO.getQueststatusid()))
                    .forEach(questprogressDO -> questStatus.setProgress(questprogressDO.getProgressid(),  questprogressDO.getProgress()));
            medalmapsDOList.stream()
                    .filter(medalmapsDO -> Objects.equals(queststatusDO.getQueststatusid(), medalmapsDO.getQueststatusid()))
                    .forEach(medalmapsDO -> questStatus.addMedalMap(medalmapsDO.getMapid()));

            questStatus.setCustomData(queststatusDO.getCustomData());

            return questStatus;
        }).toList();
    }

    @Transactional(rollbackFor = Exception.class)
    public void saveQuestStatus(int cid, Collection<QuestStatus> questStatuses) {
        if (questStatuses == null || questStatuses.isEmpty()) {
            return;
        }

        for (QuestStatus qs : questStatuses) {
            // 1. 构建并保存 QueststatusDO 主表数据
            QueststatusDO queststatusDO = new QueststatusDO();
            queststatusDO.setCharacterid(cid);
            queststatusDO.setQuest((int) qs.getQuestID());
            queststatusDO.setStatus(qs.getStatus().getId());
            queststatusDO.setTime((int) (qs.getCompletionTime() / 1000));
            queststatusDO.setExpires(qs.getExpirationTime());
            queststatusDO.setForfeited(qs.getForfeited());
            queststatusDO.setCompleted(qs.getCompleted());
            queststatusDO.setCustomData(qs.getCustomData());

            // 插入主表（自增主键会自动回填到 queststatusDO.getQueststatusid()）
            queststatusMapper.insert(queststatusDO);
            long queststatusid = queststatusDO.getQueststatusid();

            // 2. 保存 Questprogress 明细数据
            if (qs.getProgress() != null && !qs.getProgress().isEmpty()) {
                List progressList = new ArrayList<>();
                for (Map.Entry<Integer, String> entry : qs.getProgress().entrySet()) {
                    QuestprogressDO progressDO = new QuestprogressDO();
                    progressDO.setCharacterid(cid);
                    progressDO.setQueststatusid(queststatusid);
                    progressDO.setProgressid(entry.getKey());
                    progressDO.setProgress(entry.getValue());
                    progressList.add(progressDO);
                }
                questprogressMapper.insertBatch(progressList);
            }

            // 3. 保存 Medalmaps 明细数据
            if (qs.getMedalMaps() != null && !qs.getMedalMaps().isEmpty()) {
                List medalList = new ArrayList<>();
                for (Integer mapId : qs.getMedalMaps()) {
                    MedalmapsDO medalmapsDO = new MedalmapsDO();
                    medalmapsDO.setCharacterid(cid);
                    medalmapsDO.setQueststatusid(queststatusid);
                    medalmapsDO.setMapid(mapId);
                    medalList.add(medalmapsDO);
                }
                medalmapsMapper.insertBatch(medalList);
            }
        }
    }
}
