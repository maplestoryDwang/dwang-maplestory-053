<template>
  <div class="container">
    <Breadcrumb :items="['menu.game', 'menu.game.npcCraft']" />

    <!-- 头部搜索过滤栏 -->
    <a-card class="general-card" title="NPC 锻造配置查看">
      <a-row :gutter="16" style="margin-bottom: 16px">
        <a-col :span="8">
          <a-input-search
            v-model="searchNpcId"
            placeholder="请输入 NPC ID (例如 2000000)"
            search-button
            type="number"
            @search="loadNpcData"
          >
            <template #button-icon>
              <icon-search />
            </template>
            <template #button-default> 查询 </template>
          </a-input-search>
        </a-col>
      </a-row>

      <a-spin :loading="loading" style="width: 100%">
        <div v-if="hasSearched">
          <!-- 1. NPC 专属对话台词展示 -->
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

          <!-- 2. 分类与配方展示 Tab 选项卡 -->
          <a-card title="锻造分类与配方列表" size="small">
            <a-empty
              v-if="categories.length === 0"
              description="该 NPC 暂未配置任何锻造分类"
            />

            <a-tabs v-else type="card-gutter">
              <a-tab-pane
                v-for="cat in categories"
                :key="cat.categoryId"
                :title="`[Menu ${cat.categoryId}] ${cat.categoryName}`"
              >
                <!-- 分类基本信息 -->
                <a-space direction="vertical" fill style="margin-bottom: 12px">
                  <a-alert
                    v-if="cat.warningText"
                    type="warning"
                    title="风险/警告提示"
                  >
                    {{ cat.warningText }}
                  </a-alert>
                  <div v-if="cat.promptText">
                    <b>引导提示词：</b> {{ cat.promptText }}
                  </div>
                </a-space>

                <!-- 装备/材料配方表格 -->
                <a-table
                  :data="cat.options || []"
                  :pagination="false"
                  row-key="id"
                  bordered
                >
                  <template #columns>
                    <a-table-column
                      title="配方/产物 ID"
                      data-index="itemId"
                      :width="120"
                    />
                    <a-table-column title="显示名称" data-index="displayText">
                      <template #cell="{ record }">
                        {{ record.displayText || `#t${record.itemId}#` }}
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

                    <a-table-column
                      title="消耗金币"
                      data-index="cost"
                      :width="120"
                    >
                      <template #cell="{ record }">
                        {{
                          record.cost
                            ? record.cost.toLocaleString() + ' Meso'
                            : '免费'
                        }}
                      </template>
                    </a-table-column>

                    <!-- 所需材料结构展示 -->
                    <a-table-column title="合成材料明细 (Item ID x 数量)">
                      <template #cell="{ record }">
                        <a-space wrap>
                          <a-tag
                            v-for="(matId, idx) in record.mats"
                            :key="idx"
                            color="orange"
                          >
                            道具 {{ matId }} ×
                            {{ record.matQty ? record.matQty[idx] : 0 }}
                          </a-tag>
                        </a-space>
                      </template>
                    </a-table-column>
                  </template>
                </a-table>
              </a-tab-pane>
            </a-tabs>
          </a-card>
        </div>
      </a-spin>
    </a-card>
  </div>
</template>

<script lang="ts" setup>
  import { ref } from 'vue';
  import { Message } from '@arco-design/web-vue';
  import {
    getNpcMenuList,
    getCraftCategoryData,
    getNpcDialogs,
    NpcCraftCat,
  } from '@/api/npcCraft';

  const searchNpcId = ref<number | undefined>(2000000);
  const loading = ref(false);
  const hasSearched = ref(false);

  const dialogs = ref<Record<string, string>>({});
  const categories = ref<NpcCraftCat[]>([]);

  // 查询加载 NPC 锻造配置
  const loadNpcData = async () => {
    if (!searchNpcId.value) {
      Message.warning('请输入有效的 NPC ID');
      return;
    }

    loading.value = true;
    try {
      const npcId = Number(searchNpcId.value);

      // 并发请求台词和菜单列表，提高效率并避开 no-await-in-loop 限制
      const [dialogRes, menuRes] = await Promise.all([
        getNpcDialogs(npcId),
        getNpcMenuList(npcId),
      ]);

      dialogs.value = dialogRes.data || {};
      const menuList = menuRes.data || [];

      // 使用 Promise.all 替代 for-of 循环内的 await
      const categoryPromises = menuList.map((menu) =>
        getCraftCategoryData(npcId, menu.menuIndex)
      );

      const categoryResults = await Promise.all(categoryPromises);
      categories.value = categoryResults
        .map((res) => res.data)
        .filter((item): item is NpcCraftCat => Boolean(item));

      hasSearched.value = true;
      Message.success(`成功加载 NPC [${npcId}] 锻造数据`);
    } catch (err: any) {
      Message.error(err.message || '获取 NPC 锻造数据失败');
    } finally {
      loading.value = false;
    }
  };
</script>

<style scoped lang="less">
  .container {
    padding: 0 20px 20px 20px;
  }
</style>
