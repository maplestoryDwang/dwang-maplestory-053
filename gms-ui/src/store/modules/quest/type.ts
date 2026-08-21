export interface QuestState {
  questId?: number;
  parentName?: string;
  questName?: string;
  areaName?: string;
  repeatable?: boolean;
}

export interface NpcShopItemState {
  id?: number;
  shopId?: number;
  itemId?: number;
  price?: number;
  pitch?: number;
  position?: number;
  itemName?: string;
  itemDesc?: string;
}
