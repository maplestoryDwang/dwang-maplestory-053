<template>
  <div class="container">
    <Breadcrumb />

    <a-card class="general-card" :title="$t('menu.game.quest')">
      <!-- 搜索栏 -->
      <a-row style="margin-bottom: 16px">
        <a-col>
          <a-space>
            <a-input-number
                v-model="questFilter.questId"
                placeholder="任务 ID"
                :min="0"
                style="width: 160px"
                @keydown.enter="loadClick"
            />
            <a-input
                v-model="questFilter.questName"
                placeholder="任务名称"
                style="width: 200px"
                @keydown.enter="loadClick"
            />
            <a-button type="primary" status="success" @click="loadClick">
              搜索
            </a-button>
            <a-button @click="resetClick">重置</a-button>
          </a-space>
        </a-col>
      </a-row>

      <!-- 任务列表 -->
      <a-table
          row-key="id"
          :loading="loading"
          :data="questList"
          column-resizable
          :pagination="false"
          :bordered="{ cell: true }"
      >
        <template #columns>
          <a-table-column
              title="任务ID"
              data-index="questId"
              :width="100"
              align="center"
          />
          <a-table-column
              title="任务名"
              data-index="questName"
              :width="200"
              align="center"
          />
          <a-table-column
              title="父任务"
              data-index="parentName"
              :width="180"
              align="center"
          />
          <a-table-column
              title="任务地区"
              data-index="areaName"
              :width="150"
              align="center"
          />
          <a-table-column title="是否重复" align="center" :width="120">
            <template #cell="{ record }">
              <a-tag v-if="record.repeatable" color="green">可重复</a-tag>
              <a-tag v-else color="gray">不可重复</a-tag>
            </template>
          </a-table-column>
          <a-table-column title="自动启动" align="center" :width="100">
            <template #cell="{ record }">
              <a-tag v-if="record.autoStart" color="blue">是</a-tag>
              <a-tag v-else color="arcoblue">否</a-tag>
            </template>
          </a-table-column>
          <a-table-column
              title="操作"
              :width="120"
              fixed="right"
              align="center"
          >
            <template #cell="{ record }">
              <a-button
                  type="text"
                  size="mini"
                  @click="showQuestDetail(record.questId)"
              >
                查看详情
              </a-button>
            </template>
          </a-table-column>
        </template>
      </a-table>

      <!-- 分页 -->
      <a-pagination
          style="margin-top: 20px"
          :total="total"
          :page-size="questFilter.pageSize"
          :current="questFilter.pageNo"
          show-total
          show-jumper
          show-page-size
          :page-size-options="[10, 20, 50, 100]"
          @change="pageChange"
          @page-size-change="pageSizeChange"
      />
    </a-card>

    <!-- 任务详情抽屉 -->
    <a-drawer
        :width="680"
        :visible="drawerVisible"
        unmount-on-close
        @cancel="drawerVisible = false"
        @ok="drawerVisible = false"
    >
      <template #title>
        任务详情 [ID: {{ questDetail?.id }}] - {{ questDetail?.name }}
      </template>
      <a-spin :loading="detailLoading" style="width: 100%">
        <div v-if="questDetail" class="quest-detail-container">
          <!-- 1. 基础信息 -->
          <a-descriptions title="基本属性" :column="2" bordered size="medium">
            <a-descriptions-item label="任务名称">{{ questDetail.name || '-' }}</a-descriptions-item>
            <a-descriptions-item label="所属地区">{{ questDetail.area || '-' }}</a-descriptions-item>
            <a-descriptions-item label="父级任务">{{ questDetail.parent || '-' }}</a-descriptions-item>
            <a-descriptions-item label="可否重复">
              <a-tag :color="questDetail.repeatable ? 'green' : 'red'">
                {{ questDetail.repeatable ? '允许' : '禁止' }}
              </a-tag>
            </a-descriptions-item>
            <a-descriptions-item label="自动开始">
              {{ questDetail.autoStart ? '是' : '否' }}
            </a-descriptions-item>
            <a-descriptions-item label="自动完成">
              {{ questDetail.autoComplete ? '是' : '否' }}
            </a-descriptions-item>
            <a-descriptions-item label="时间限制(秒)">{{ questDetail.timeLimit }}</a-descriptions-item>
            <a-descriptions-item label="关联怪物">
              <a-space wrap v-if="questDetail.relevantMobs?.length">
                <a-tag v-for="mobId in questDetail.relevantMobs" :key="mobId" color="purple">
                  {{ mobId }}
                </a-tag>
              </a-space>
              <span v-else>-</span>
            </a-descriptions-item>
          </a-descriptions>

          <a-divider />

          <!-- 2. 开始条件 (startRequirements) -->
          <div class="section-title">开始条件 (Start Requirements)</div>
          <div v-if="hasData(questDetail.startRequirements)">
            <a-card v-for="(val, key) in questDetail.startRequirements" :key="key" size="small" class="req-card">
              <template #title>
                <a-tag color="gold">{{ key }}</a-tag>
              </template>
              <!-- 动态条件渲染解析 -->
              <component :is="renderRequirementData(key, val)" />
            </a-card>
          </div>
          <a-empty v-else description="无开始条件" />

          <a-divider />

          <!-- 3. 完成条件 (completeRequirements) -->
          <div class="section-title">完成条件 (Complete Requirements)</div>
          <div v-if="hasData(questDetail.completeRequirements)">
            <a-card v-for="(val, key) in questDetail.completeRequirements" :key="key" size="small" class="req-card">
              <template #title>
                <a-tag color="cyan">{{ key }}</a-tag>
              </template>
              <component :is="renderRequirementData(key, val)" />
            </a-card>
          </div>
          <a-empty v-else description="无完成条件" />

          <a-divider />

          <!-- 4. 开始奖励/动作 (startActions) -->
          <div class="section-title">接取动作/奖励 (Start Actions)</div>
          <div v-if="hasData(questDetail.startActions)">
            <a-card v-for="(val, key) in questDetail.startActions" :key="key" size="small" class="req-card">
              <template #title>
                <a-tag color="orangered">{{ key }}</a-tag>
              </template>
              <component :is="renderActionData(key, val)" />
            </a-card>
          </div>
          <a-empty v-else description="无接取动作" />

          <a-divider />

          <!-- 5. 完成奖励/动作 (completeActions) -->
          <div class="section-title">完成奖励/动作 (Complete Actions)</div>
          <div v-if="hasData(questDetail.completeActions)">
            <a-card v-for="(val, key) in questDetail.completeActions" :key="key" size="small" class="req-card">
              <template #title>
                <a-tag color="green">{{ key }}</a-tag>
              </template>
              <component :is="renderActionData(key, val)" />
            </a-card>
          </div>
          <a-empty v-else description="无完成奖励" />
        </div>
      </a-spin>
    </a-drawer>
  </div>
</template>

<script lang="ts" setup>
import { ref, h } from 'vue';
import useLoading from '@/hooks/loading';
import {
  getQuestFilter,
  getQuestList,
  getQuestDetail, // 请确保在 @/api/quest 中定义了此接口
  QuestDetailVO,
} from '@/api/quest';
import { QuestState } from '@/store/modules/quest/type';
import { Tag, Space, Table, Image } from '@arco-design/web-vue';
import { getIconUrl } from '@/utils/mapleStoryAPI';

const { loading, setLoading } = useLoading(false);
const detailLoading = ref(false);
const drawerVisible = ref(false);

const total = ref<number>(0);
const questList = ref<QuestState[]>([]);
const questDetail = ref<QuestDetailVO | null>(null);

const questFilter = ref<getQuestFilter>({
  pageNo: 1,
  pageSize: 20,
  onlyTotal: false,
  notPage: false,
  questId: undefined,
  questName: undefined,
});

const pageChange = (page: number) => {
  questFilter.value.pageNo = page;
  loadQuestList();
};

const pageSizeChange = (pageSize: number) => {
  questFilter.value.pageNo = 1;
  questFilter.value.pageSize = pageSize;
  loadQuestList();
};

const loadClick = () => {
  questFilter.value.pageNo = 1;
  loadQuestList();
};

const resetClick = () => {
  questFilter.value = {
    pageNo: 1,
    pageSize: 20,
    onlyTotal: false,
    notPage: false,
    questId: undefined,
    questName: undefined,
  };
  loadQuestList();
};

const loadQuestList = async () => {
  setLoading(true);
  try {
    const { data } = await getQuestList(questFilter.value);
    questList.value = data.records;
    total.value = data.totalRow;
  } finally {
    setLoading(false);
  }
};
loadQuestList();

// 查看任务详情
const showQuestDetail = async (id: number) => {
  drawerVisible.value = true;
  detailLoading.value = true;
  try {
    const { data } = await getQuestDetail(id);
    questDetail.value = data;
  } finally {
    detailLoading.value = false;
  }
};

// 工具判断 Map 是否包含数据
const hasData = (obj?: Record<string, any>) => {
  return obj && Object.keys(obj).length > 0;
};

// ==================== 核心 VO 动态解析渲染函数 ====================

/**
 * 渲染 Requirements 条件数据
 */
const renderRequirementData = (key: string, data: any) => {
  if (!data) return h('span', '-');

  switch (key) {
    case 'JOB':
      // 职业需求: { jobs: [0, 100] }
      return h(
          Space,
          { wrap: true },
          () => data.jobs?.map((jobId: number) => h(Tag, { color: 'arcoblue' }, () => `职业 ID: ${jobId}`))
      );

    case 'MOB':
      // 击杀怪物需求: { questId: 1001, mobs: { "100100": 10 } }
      return h('div', [
        data.questId ? h('div', { style: 'margin-bottom: 6px;' }, `关联任务ID: ${data.questId}`) : null,
        h(
            Space,
            { direction: 'vertical', fill: true },
            () => Object.entries(data.mobs || {}).map(([mobId, count]) =>
                h(Tag, { color: 'red' }, () => `怪物 ID [${mobId}] : 需击杀 ${count} 只`)
            )
        ),
      ]);

    case 'ITEM':
      // 物品需求: { items: { "2000000": 5 } }
      return h(
          Space,
          { wrap: true },
          () => Object.entries(data.items || {}).map(([itemId, count]) =>
              h(Tag, { color: 'green' }, () => [
                h(Image, { src: getIconUrl('item', Number(itemId)), width: 20, style: 'margin-right: 4px' }),
                `物品 ID [${itemId}] x ${count}`,
              ])
          )
      );

    case 'NPC':
    case 'INFO_NUMBER':
      // 简单的数值对象需求: { value: 1012000 }
      return h('span', `目标 / 参数值: ${data.value ?? data}`);

    default:
      // 未定义的通用 JSON 展示
      return h('pre', { style: 'margin: 0; font-size: 12px;' }, JSON.stringify(data, null, 2));
  }
};

/**
 * 渲染 Actions 奖励/动作数据
 */
const renderActionData = (key: string, data: any) => {
  if (!data) return h('span', '-');

  switch (key) {
    case 'ITEM':
      // 物品奖励列表: { items: [ { id: 2000000, count: 5, prop: 100, ... } ] }
      return h(Table, {
        data: data.items || [],
        pagination: false,
        size: 'mini',
        bordered: true,
        columns: [
          {
            title: '图标',
            width: 60,
            render: ({ record }: any) => h(Image, { src: getIconUrl('item', record.id), width: 24 }),
          },
          { title: '物品ID', dataIndex: 'id', width: 90 },
          { title: '数量', dataIndex: 'count', width: 70 },
          { title: '概率(%)', dataIndex: 'prop', width: 80, render: ({ record }: any) => record.prop ?? 100 },
          { title: '职业限定', dataIndex: 'job', width: 90 },
          { title: '性别', dataIndex: 'gender', width: 70 },
        ],
      });

    case 'EXP':
      return h(Tag, { color: 'gold' }, () => `经验值: +${data.exp ?? data.value ?? data}`);

    case 'MESO':
      return h(Tag, { color: 'gold' }, () => `金币: +${data.meso ?? data.value ?? data}`);

    default:
      // 未定义的通用 JSON 展示
      return h('pre', { style: 'margin: 0; font-size: 12px;' }, JSON.stringify(data, null, 2));
  }
};
</script>

<script lang="ts">
export default {
  name: 'QuestManagement',
};
</script>

<style lang="less" scoped>
:deep(.arco-card-body, .arco-row) {
  width: 100%;
}

.section-title {
  font-size: 14px;
  font-weight: bold;
  margin-bottom: 10px;
  color: var(--color-text-1);
}

.req-card {
  margin-bottom: 10px;
  background-color: var(--color-fill-1);
}

.quest-detail-container {
  padding-right: 8px;
}
</style>