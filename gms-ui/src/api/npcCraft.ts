import axios from 'axios';
import type { HttpResponse } from '@/api/interceptor';

// 对应 Java: CraftSearchRtnDTO
export interface CraftSearchRtnDTO {
  craftId?: number;
  npcId?: number;
  npcName?: string;
}

// 对应请求过滤器参数 (参照 getShopFilter 保持一致)
export interface getCraftFilter {
  pageNo?: number;
  pageSize?: number;
  onlyTotal?: boolean;
  notPage?: boolean;
  craftId?: number;
  npcId?: number;
  npcName?: string;
}

// DTO 定义 (对应 Java: NpcCraftCategoryDTO.RecipeOptionDTO)
export interface NpcCraftOption {
  recipeId?: number;
  id?: number;
  catId?: number;
  itemId: number;
  itemName?: string;
  displayText?: string;
  reqLevel: number;
  jobName?: string;
  yieldQty: number;
  cost: number;
  isEquip: boolean;
  mats: number[];
  matNames?: string[];
  matQty: number[];
}

export interface NpcCraftCat {
  id?: number;
  categoryId?: number;
  npcId: number;
  menuIndex: number;
  categoryName: string;
  templateId?: number;
  craftType?: string;
  promptText?: string;
  warningText?: string;
  options?: NpcCraftOption[];
}

// 材料明细 (对应 Java: NpcCraftMat)
export interface NpcCraftMatForm {
  id?: number;
  recipeId?: number;
  matId?: number;
  matQty?: number;
}

// 配方保存/编辑请求体 (对应 Java: NpcCraftItemDTO)
export interface NpcCraftItemForm {
  id?: number;
  categoryId?: number;
  itemId?: number;
  isEquip?: boolean;
  yieldQty?: number;
  reqLevel?: number;
  jobName?: string;
  cost?: number;
  displayText?: string;
  sortOrder?: number;
  mats?: NpcCraftMatForm[];
}

// NPC 台词 (对应 Java: NpcDialog)
export interface NpcDialogForm {
  id?: number;
  npcId: number;
  templateId?: number;
  dialogType?: string;
  dialogKey: string;
  dialogText?: string;
}

// 参数类型（完全照搬 getShopFilter 的字段）
export interface CraftSearchReq {
  pageNo?: number;
  pageSize?: number;
  onlyTotal: boolean;
  notPage: boolean;
  shopId?: number; // 对应 craftId，后端字段名 shopId
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
export function getNpcDialogsMap(npcId: number) {
  return axios.get<HttpResponse<Record<string, string>>>(
    `/api/npc-craft/v1/dialogsMap/${npcId}`
  );
}

// 3. 获取 NPC 台词 list
export function getNpcDialogs(npcId: number) {
    return axios.get<HttpResponse<NpcDialogForm[]>>(
        `/api/npc-craft/v1/dialogs/${npcId}`
    );
}


// 4. 新增或修改锻造分类
export function saveCategory(data: NpcCraftCat) {
  return axios.post<HttpResponse<any>>('/api/npc-craft/v1/saveCategory', data);
}

// 5. 删除锻造分类
export function deleteCategory(data: NpcCraftCat) {
  return axios.post<HttpResponse<any>>(
    '/api/npc-craft/v1/deleteCategory',
    data
  );
}

// 6. 新增或修改配方 (含材料明细)
export function saveItem(data: NpcCraftItemForm) {
  return axios.post<HttpResponse<any>>('/api/npc-craft/v1/saveItem', data);
}

// 7. 删除配方
export function deleteItem(data: NpcCraftItemForm) {
  return axios.post<HttpResponse<any>>('/api/npc-craft/v1/deleteItem', data);
}

// 8. 新增或修改 NPC 台词
export function saveDialog(data: NpcDialogForm) {
  return axios.post<HttpResponse<any>>('/api/npc-craft/v1/saveDialog', data);
}

// 9. 删除 NPC 台词
export function deleteDialog(data: NpcDialogForm) {
  return axios.post<HttpResponse<any>>('/api/npc-craft/v1/deleteDialog', data);
}
