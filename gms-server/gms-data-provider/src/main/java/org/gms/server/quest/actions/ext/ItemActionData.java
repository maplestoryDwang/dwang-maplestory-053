/*
 This file is part of the OdinMS Maple Story Server
 Copyright (C) 2008 Patrick Huy <patrick.huy@frz.cc>
 Matthias Butz <matze@odinms.de>
 Jan Christian Meyer <vimes@odinms.de>

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU Affero General Public License as
 published by the Free Software Foundation version 3 as published by
 the Free Software Foundation. You may not use, modify or distribute
 this program under any other version of the GNU Affero General Public
 License.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Affero General Public License for more details.

 You should have received a copy of the GNU Affero General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.gms.server.quest.actions.ext;

import lombok.Getter;
import lombok.Setter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.ItemInformationProvider;
import org.gms.server.StringInfoProvider;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.actions.AbstractQuestActionData;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Tyler (Twdtwd)
 * @author Ronan
 */
@Getter
public class ItemActionData extends AbstractQuestActionData {

    private static final Logger log = LoggerFactory.getLogger(ItemActionData.class);
    List<ItemData> items = new ArrayList<>();

    public ItemActionData(Data data) {
        super(QuestActionType.ITEM);
        Map<Integer, Integer> propMap = new HashMap<>();
        int propAll = 0;
        for (Data iEntry : data.getChildren()) {
            int id = DataTool.getInt(iEntry.getChildByPath("id"));
            int count = DataTool.getInt(iEntry.getChildByPath("count"), 1);
            int period = DataTool.getInt(iEntry.getChildByPath("period"), 0);   // 限时时间

            Integer prop = null;
            Data propData = iEntry.getChildByPath("prop");  // 获取奖励概率，一共100，获取奖励不同概率
            if (propData != null) {
                prop = DataTool.getInt(propData);
                propAll += prop;
            }

            int gender = 2;
            if (iEntry.getChildByPath("gender") != null) {
                gender = DataTool.getInt(iEntry.getChildByPath("gender"));
            }

            int job = -1;
            if (iEntry.getChildByPath("job") != null) {
                job = DataTool.getInt(iEntry.getChildByPath("job"));
            }
            String name = ItemInformationProvider.getInstance().getName(id);

            items.add(new ItemData(Integer.parseInt(iEntry.getName()), id, name, count, prop, job, gender, period));
        }

        // 计算百分比
        if (propAll > 0) {
            for (ItemData item : items) {
                if (item.prop != null && item.prop != 0) {
                    // 1. 转为 double 进行浮点运算
                    double percentage = ((double) item.prop / propAll) * 100;

                    // 2. 格式化输出为字符串（例如保留2位小数：12.34%，或保留整数：12%）
                    String percentStr = String.format("%.2f%%", percentage); // 保留两位小数
                    // String percentStr = String.format("%.0f%%", percentage); // 取整，无小数

                    // 3. 将格式化后的 percentStr 赋值或存入 item 对象中
                     item.setPropPercent(percentStr);
                }
            }
        }


        items.sort((o1, o2) -> o1.map - o2.map);
    }


    public static class ItemData {
        public final int map, id, count, job, gender, period;
        public final Integer prop;
        public final String name;

        @Setter
        @Getter
        // 动态计算概率百分比
        public String propPercent;

        public ItemData(int map, int id, String name, int count, Integer prop, int job, int gender, int period) {
            this.map = map;
            this.id = id;
            this.name = name;
            this.count = count;
            this.prop = prop;
            this.job = job;
            this.gender = gender;
            this.period = period;
        }

        public int getId() {
            return id;
        }

        public int getCount() {
            return count;
        }

        public Integer getProp() {
            return prop;
        }

        public int getJob() {
            return job;
        }

        public int getGender() {
            return gender;
        }

        public int getPeriod() {
            return period;
        }
    }
} 
