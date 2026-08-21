import axios from 'axios';
import { NpcShopItemState } from '@/store/modules/npcShop/type';

export interface getQuestFilter {
  pageNo?: number;
  pageSize?: number;
  onlyTotal: boolean;
  notPage: boolean;
  questId?: number;
  questName?: string;
}

export interface QuestDetailVO {
    id: number;
    name: string;
    parent: string;
    area: string;
    timeLimit: number;
    timeLimit2: number;
    autoStart: boolean;
    autoComplete: boolean;
    repeatable: boolean;
    relevantMobs: number[];

    // 对应后端的 4 个 Map<String, Object>
    startRequirements?: Record<string, any>;
    completeRequirements?: Record<string, any>;
    startActions?: Record<string, any>;
    completeActions?: Record<string, any>;
}


export function getQuestList(data: getQuestFilter) {
  return axios.post('/quest/v1/getQuestList', data);
}

// 获取详情 API
export function getQuestDetail(id: number) {
    return axios.get<QuestDetailVO>(`/quest/v1/detail/${id}`);
}
