<template>
  <div class="container">
    <Breadcrumb />
    <a-card class="general-card" :title="$t('menu.game.npcCraft')">
      <!-- 头部搜索过滤栏 -->
      <a-row>
        <a-col>
          <a-input-number
            v-model="craftFilter.craftId"
            placeholder="制作 ID"
            @keydown.enter="loadClick"
          />
          <a-input-number
            v-model="craftFilter.npcId"
            placeholder="NPC ID"
            @keydown.enter="loadClick"
          />
          <a-input
            v-model="craftFilter.npcName"
            placeholder="NPC 名称"
            @keydown.enter="loadClick"
          />
          <a-space style="margin-left: 8px">
            <a-button type="primary" status="success" @click="loadClick">
              搜索
            </a-button>
            <a-button @click="resetClick">重置</a-button>
          </a-space>
        </a-col>
      </a-row>

      <!-- 1. 主列表：NPC 制作配置列表 (craftId <= 0 时显示) -->
      <a-table
        v-show="craftId <= 0"
        row-key="craftId"
        :loading="loading"
        :data="craftList"
        column-resizable
        :pagination="false"
        :bordered="{ cell: true }"
        style="margin-top: 16px"
      >
        <template #columns>
          <a-table-column
            title="制作 ID"
            data-index="craftId"
            :width="100"
            align="center"
          />
          <a-table-column
            title="NPC ID"
            data-index="npcId"
            :width="120"
            align="center"
          />
          <a-table-column
            title="NPC 名称"
            data-index="npcName"
            :width="200"
            align="center"
          />
          <a-table-column
            title="NPC 图片"
            data-index="npcId"
            :width="100"
            align="center"
          >
            <template #cell="{ record }">
              <img :src="getIconUrl('npc', record.npcId)" alt="NPC Icon" />
            </template>
          </a-table-column>
          <a-table-column
            title="操作"
            data-index="edit"
            :width="100"
            fixed="right"
            align="center"
          >
            <template #cell="{ record }">
              <a-button
                type="text"
                size="mini"
                @click="showCraftDetailClick(record.craftId, record.npcId)"
              >
                查看制作
              </a-button>
            </template>
          </a-table-column>
        </template>
      </a-table>

      <!-- 2. 详情展示：NPC 台词与配方 Tab 详情 (craftId > 0 时显示) -->
      <div v-if="craftId > 0" style="margin-top: 16px">
        <a-spin :loading="detailLoading" style="width: 100%">
          <!-- 对应 NPC 对话台词 -->
          <a-card
            title="NPC 对话台词 (Dialog Map)"
            size="small"
            style="margin-bottom: 16px"
          >
            <a-descriptions :column="2" bordered>
              <a-descriptions-item
                v-for="(val, key) in dialogs"
                :key="key"
                :label="String(key)"
              >
                <a-tag color="arcoblue">{{ val }}</a-tag>
              </a-descriptions-item>
            </a-descriptions>
          </a-card>

          <!-- 分类与配方 Tab 选项卡 -->
          <a-card title="锻造分类与配方列表" size="small">
            <a-empty
              v-if="categories.length === 0"
              description="该 NPC 暂未配置任何锻造分类"
            />

            <a-tabs v-else type="card-gutter">
              <a-tab-pane
                v-for="cat in categories"
                :key="cat.categoryId"
                :title="`[Menu ${cat.menuIndex}] ${cat.categoryName}`"
              >
                <a-space direction="vertical" fill style="margin-bottom: 12px">
                  <a-alert
                    v-if="cat.warningText"
                    type="warning"
                    title="风险/警告提示"
                  >
                    {{ cat.warningText }}
                  </a-alert>
                  <div>
                    <b>类型：</b> {{ cat.craftType }}
                  </div>
                  <div v-if="cat.promptText">
                    <b>引导提示词：</b> {{ cat.promptText }}
                  </div>

                </a-space>

                <!-- 配方数据表格 -->
                <a-table
                  :data="cat.options || []"
                  :pagination="false"
                  row-key="id"
                  bordered
                >
                  <template #columns>
                    <a-table-column title="图标" :width="70" align="center">
                      <template #cell="{ record }">
                        <img
                          :src="getIconUrl('item', record.itemId)"
                          alt="item icon"
                        />
                      </template>
                    </a-table-column>
                    <a-table-column
                      title="产物 ID"
                      data-index="itemId"
                      :width="120"
                    />
                    <a-table-column title="显示名称" data-index="displayText" :width="150">
                      <template #cell="{ record }">
                        {{ record.itemName || `道具 ${record.itemId}` }}
                      </template>
                    </a-table-column>
                    <a-table-column title="类型" :width="100">
                      <template #cell="{ record }">
                        <a-tag :color="record.isEquip ? 'green' : 'blue'">
                          {{ record.isEquip ? '装备' : '道具/消耗品' }}
                        </a-tag>
                      </template>
                    </a-table-column>
                    <a-table-column
                      title="产出数量"
                      data-index="yieldQty"
                      :width="100"
                    />
                    <a-table-column
                      title="限制等级"
                      data-index="reqLevel"
                      :width="100"
                    />
                    <a-table-column
                      title="职业要求"
                      data-index="jobName"
                      :width="120"
                    />
                    <a-table-column title="消耗金币" :width="150">
                      <template #cell="{ record }">
                        {{
                          record.cost
                            ? record.cost.toLocaleString() + ' Meso'
                            : '免费'
                        }}
                      </template>
                    </a-table-column>

                    <!-- 合成材料 -->
                    <a-table-column title="合成材料明细 (Item ID x 数量)">
                      <template #cell="{ record }">
                        <a-space wrap v-if="record.mats && record.mats.length">
                          <a-tag
                            v-for="(matId, idx) in record.mats"
                            :key="idx"
                            color="orange"
                          >
                            <img
                              :src="getIconUrl('item', matId)"
                              style="width: 16px; vertical-align: middle; margin-right: 4px"
                            />
                            {{ matId }} ×
                            {{ record.matQty ? record.matQty[idx] : 0 }}
                          </a-tag>
                        </a-space>
                        <span v-else>-</span>
                      </template>
                    </a-table-column>
                  </template>
                </a-table>
              </a-tab-pane>
            </a-tabs>
          </a-card>
        </a-spin>
      </div>

      <!-- 分页组件 (仅在主列表模式时生效) -->
      <a-pagination
        v-show="craftId <= 0"
        style="margin-top: 20px"
        :total="total"
        :page-size="craftFilter.pageSize"
        :current="craftFilter.pageNo"
        show-total
        show-jumper
        show-page-size
        :page-size-options="[10, 20, 35, 70]"
        @change="pageChange"
        @page-size-change="pageSizeChange"
      />
    </a-card>
  </div>
</template>

<script lang="ts" setup>
  import { ref } from 'vue';
  import useLoading from '@/hooks/loading';
  import { Message } from '@arco-design/web-vue';
  import { getIconUrl } from '@/utils/mapleStoryAPI';
  import {
    getCraftList,
    getNpcMenuList,
    getCraftCategoryData,
    getNpcDialogs,
    getCraftFilter,
    CraftSearchRtnDTO,
    NpcCraftCat,
  } from '@/api/npcCraft';

  const { loading, setLoading } = useLoading(false);
  const detailLoading = ref(false);

  const craftId = ref<number>(-1);
  const total = ref<number>(0);

  // 筛选对象，对齐 npcShop
  const craftFilter = ref<getCraftFilter>({
    pageNo: 1,
    pageSize: 20,
    craftId: undefined,
    npcId: undefined,
    npcName: undefined,
  });

  // 主列表加载
  const craftList = ref<CraftSearchRtnDTO[]>([]);
  const loadCraftList = async () => {
    setLoading(true);
    try {
      craftId.value = -1;
      const { data } = await getCraftList(craftFilter.value);
      craftList.value = data.records;
      total.value = data.totalRow;
    } catch (err: any) {
      Message.error(err.message || '获取 NPC 制作列表失败');
    } finally {
      setLoading(false);
    }
  };
  loadCraftList();

  // 搜索 & 重置点击触发
  const loadClick = () => {
    craftFilter.value.pageNo = 1;
    loadCraftList();
  };

  const resetClick = () => {
    craftFilter.value = {
      pageNo: 1,
      pageSize: 20,
      craftId: undefined,
      npcId: undefined,
      npcName: undefined,
    };
    loadCraftList();
  };

  // 分页切换
  const pageChange = (page: number) => {
    craftFilter.value.pageNo = page;
    loadCraftList();
  };

  const pageSizeChange = (size: number) => {
    craftFilter.value.pageNo = 1;
    craftFilter.value.pageSize = size;
    loadCraftList();
  };

  // 详情数据加载（台词 + 菜单 + 分类配方）
  const dialogs = ref<Record<string, string>>({});
  const categories = ref<NpcCraftCat[]>([]);

  const showCraftDetailClick = async (cId: number, npcId: number) => {
    craftId.value = cId;
    detailLoading.value = true;
    try {
      // 1. 并发获取对话台词 & 菜单列表
      const [dialogRes, menuRes] = await Promise.all([
        getNpcDialogs(npcId),
        getNpcMenuList(npcId),
      ]);

      dialogs.value = dialogRes.data || {};
      const menuList = menuRes.data || [];

      // 2. 获取各个 Menu 对应的详细配方项
      const categoryPromises = menuList.map((menu: any) =>
        getCraftCategoryData(npcId, menu.menuIndex)
      );
      const categoryResults = await Promise.all(categoryPromises);

      categories.value = categoryResults
        .map((res, index) => {
          if (!res.data) return null;
          return {
            ...res.data,
            menuIndex: res.data.menuIndex ?? menuList[index]?.menuIndex,
            categoryName: res.data.categoryName ?? menuList[index]?.categoryName,
          };
        })
        .filter((item): item is NpcCraftCat => Boolean(item));
    } catch (err: any) {
      Message.error(err.message || '获取配方详情失败');
    } finally {
      detailLoading.value = false;
    }
  };
</script>

<script lang="ts">
  export default {
    name: 'NpcCraft',
  };
</script>

<style lang="less" scoped>
  .container {
    padding: 0 20px 20px 20px;
  }
  :deep(.arco-card-body, .arco-row) {
    width: 100%;
  }
  .arco-input-wrapper,
  .arco-input-number {
    margin-right: 0;
    margin-bottom: 5px;
    width: 100%;
  }
  @media (min-width: 500px) {
    .arco-input-wrapper,
    .arco-input-number {
      margin-right: 8px;
      width: 140px;
    }
  }
</style>