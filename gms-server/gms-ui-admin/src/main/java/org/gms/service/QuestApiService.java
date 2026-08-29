package org.gms.service;

import com.mybatisflex.core.paginate.Page;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import org.gms.model.dto.*;
import org.gms.server.quest.QuestRepository;
import org.gms.server.quest.QuestV2;
import org.gms.server.quest.converter.QuestDetailVO;
import org.gms.server.quest.converter.QuestVOConverter;
import org.gms.util.BasePageUtil;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@Service
@AllArgsConstructor
public class QuestApiService {

    private final QuestUserDataService  questUserDataService;

//    public Page<ShopSearchRtnDTO> getShopList(ShopSearchReqDTO data) {
//        List<ShopSearchRtnDTO> matchedShopsDOList = shopService.getShopList(data);
//        return BasePageUtil.create(matchedShopsDOList.stream().distinct().toList(), data).page();
//    }

    public Page<QuestSearchRtnDTO> getQuestList(QuestSearchReqDTO data) {
        List<QuestV2> questList = QuestRepository.getQuestList(data);
        questList.sort(new Comparator<QuestV2>() {
            @Override
            public int compare(QuestV2 o1, QuestV2 o2) {
                return Short.compare(o1.getId(), o2.getId());
            }
        });
        List<QuestSearchRtnDTO> questSearchRtnDTOS = new ArrayList<>();
        questList.forEach(quest -> {
            questSearchRtnDTOS.add(new QuestSearchRtnDTO((int) quest.getId(), quest.getParentName(), quest.getName(), quest.getArea(), quest.isRepeatable(), quest.isAutoStart()));
        });
        return BasePageUtil.create(questSearchRtnDTOS.stream().distinct().toList(), data).page();
    }


    public QuestDetailVO getQuestDetail(@NotNull(message = "任务ID不能为空") Short id) {
        QuestV2 instance = QuestRepository.getInstance(id);
        if (instance == null) {
            return null;
        }
        return QuestVOConverter.toDetailVO(instance);
    }
}
