import axios from 'axios';
import type { HttpResponse } from '@/api/interceptor';

// DTO 定义
export interface NpcCraftOption {
  id: number;
  catId: number;
  itemId: number;
  displayText?: string;
  reqLevel: number;
  jobName?: string;
  yieldQty: number;
  cost: number;
  isEquip: boolean;
  mats: number[];
  matQty: number[];
}

export interface NpcCraftCat {
  id: number;
  npcId: number;
  menuIndex: number;
  categoryName: string;
  promptText?: string;
  warningText?: string;
  options?: NpcCraftOption[];
}

// 参数类型（完全照搬 getShopFilter 的字段）
export interface CraftSearchReq {
    pageNo?: number;
    pageSize?: number;
    onlyTotal: boolean;
    notPage: boolean;
    shopId?: number;      // 对应 craftId，后端字段名 shopId
    npcId?: number;
    npcName?: string;
    itemId?: number;
    itemName?: string;
}

// 新接口：直接 POST，不包一层 data，就和 getShopList 一样
export function getCraftList(data: CraftSearchReq) {
    return axios.post<HttpResponse<any>>('/api/npc-craft/v1/getCraftList', data);
}


// 1. 查询某个 NPC 的菜单分类列表
export function getNpcMenuList(npcId: number) {
  return axios.get<HttpResponse<NpcCraftCat[]>>(
    `/api/npc-craft/v1/menus/${npcId}`
  );
}

// 2. 获取分类数据及包含的配方列表
export function getCraftCategoryData(npcId: number, menuIndex: number) {
  return axios.get<HttpResponse<NpcCraftCat>>(
    `/api/npc-craft/v1/category/${npcId}/${menuIndex}`
  );
}

// 3. 获取 NPC 台词 Map
export function getNpcDialogs(npcId: number) {
  return axios.get<HttpResponse<Record<string, string>>>(
    `/api/npc-craft/v1/dialogs/${npcId}`
  );
}
