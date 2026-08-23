<template>
  <div class="container">
    <Breadcrumb />
    <a-card class="general-card" :title="$t('menu.dashboard.event')">
      <a-space direction="vertical" align="start">
        <a-form-item :hide-label="true">
          <a-col :offset="0">
            <a-input
              v-model="condition.eventName"
              :placeholder="$t('event.placeholder.eventName')"
              @keydown.enter="searchData"
            />
            <a-select
              v-model="enabledFilter"
              :placeholder="$t('event.placeholder.enabled')"
              allow-clear
              style="width: 160px"
            >
              <a-option value="all">
                {{ $t('event.enabled.all') }}
              </a-option>
              <a-option value="true">
                {{ $t('event.enabled.true') }}
              </a-option>
              <a-option value="false">
                {{ $t('event.enabled.false') }}
              </a-option>
            </a-select>
            <a-button type="primary" @click="searchData">
              {{ $t('button.search') }}
            </a-button>
            <a-button @click="resetSearch">
              {{ $t('button.reset') }}
            </a-button>
            <a-button
              type="primary"
              status="success"
              :disabled="selectedKeys.length > 0"
              @click="addClick"
            >
              {{ $t('button.add') }}
            </a-button>
            <a-button
              type="primary"
              status="danger"
              :disabled="selectedKeys.length === 0"
              @click="delClick"
            >
              {{ $t('button.delete') }}
            </a-button>
          </a-col>
        </a-form-item>
      </a-space>
      <a-table
        v-model:selectedKeys="selectedKeys"
        row-key="id"
        :loading="loading"
        :data="eventList"
        column-resizable
        :pagination="false"
        :bordered="{ cell: true }"
        :row-selection="{
          type: 'checkbox',
          showCheckedAll: true,
          onlyCurrent: false,
        }"
      >
        <template #columns>
          <a-table-column
            :title="$t('event.column.id')"
            data-index="id"
            :width="80"
            align="center"
          />
          <a-table-column
            :title="$t('event.column.eventName')"
            data-index="eventName"
            :width="200"
            align="center"
          />
          <a-table-column
            :title="$t('event.column.enabled')"
            data-index="enabled"
            :width="100"
            align="center"
          >
            <template #cell="{ record }">
              <a-tag :color="record.enabled ? 'green' : 'red'">
                {{
                  record.enabled
                    ? $t('event.enabled.true')
                    : $t('event.enabled.false')
                }}
              </a-tag>
            </template>
          </a-table-column>
          <a-table-column
            :title="$t('event.column.remark')"
            data-index="remark"
            :width="400"
            align="center"
          />
          <a-table-column
            :title="$t('event.column.operate')"
            :width="100"
            align="center"
          >
            <template #cell="{ record }">
              <a-button type="text" size="mini" @click="uptClick(record)">
                {{ $t('button.edit') }}
              </a-button>
            </template>
          </a-table-column>
        </template>
      </a-table>
      <a-pagination
        style="margin-top: 20px"
        :total="total"
        :page-size="condition.pageSize"
        :current="condition.pageNo"
        show-total
        show-jumper
        show-page-size
        :page-size-options="[10, 20, 40, 80, 100]"
        @change="pageChange"
        @page-size-change="pageSizeChange"
      />
      <a-modal
        v-model:visible="editVisible"
        :width="450"
        :title="editTitle"
        draggable
        :ok-text="$t('button.submit')"
        @ok="editOk"
      >
        <a-form :model="editData" :auto-label-width="true">
          <a-form-item
            field="eventName"
            :label="$t('event.column.eventName')"
            :required="true"
            :disabled="editData.id != null && editData.id != 0"
          >
            <a-input v-model="editData.eventName" :max-length="128" />
          </a-form-item>
          <a-form-item
            field="enabled"
            :label="$t('event.column.enabled')"
            :required="true"
          >
            <a-switch v-model="editData.enabled" />
          </a-form-item>
          <a-form-item field="remark" :label="$t('event.column.remark')">
            <a-textarea v-model="editData.remark" :max-length="500" />
          </a-form-item>
        </a-form>
      </a-modal>
      <a-modal
        v-model:visible="confirmVisible"
        :width="450"
        draggable
        @ok="confirmOk"
      >
        <template #title>
          {{ $t('button.delete') }}
        </template>
        <div>{{ $t('event.confirm.text') }}</div>
      </a-modal>
    </a-card>
  </div>
</template>

<script setup lang="ts">
  import { reactive, ref } from 'vue';
  import {
    deleteEvent,
    EventDetailVO,
    EventSearch,
    getEventList,
    saveEvent,
  } from '@/api/event';
  import { useI18n } from 'vue-i18n';
  import useLoading from '@/hooks/loading';

  const { t } = useI18n();
  const enabledFilter = ref<string>('all'); // 默认显示
  const condition = ref<EventSearch>({
    eventName: '',
    pageNo: 1,
    pageSize: 20,
  });
  const eventList = ref<EventDetailVO[]>([]);
  const total = ref<number>(0);
  const { loading, setLoading } = useLoading(false);
  const selectedKeys = ref<number[]>([]);
  const editVisible = ref<boolean>(false);
  const editTitle = ref<string>('');
  const editData = reactive<EventDetailVO>({
    id: 0,
    eventName: '',
    enabled: true,
    remark: '',
  });
  const confirmVisible = ref<boolean>(false);

  const loadEvents = async () => {
    setLoading(true);
    try {
      const param: EventSearch = {
        ...condition.value,
        eventName: condition.value.eventName || undefined,
        enabled:
          enabledFilter.value === 'all'
            ? undefined
            : enabledFilter.value === 'true',
      };
      const { data } = await getEventList(param);
      eventList.value = data.records;
      total.value = data.totalRow;
      selectedKeys.value = [];
    } finally {
      setLoading(false);
    }
  };

  const pageChange = (data: number) => {
    condition.value.pageNo = data;
    loadEvents();
  };

  const pageSizeChange = (data: number) => {
    condition.value.pageNo = 1;
    condition.value.pageSize = data;
    loadEvents();
  };

  const searchData = async () => {
    condition.value.pageNo = 1;
    await loadEvents();
  };

  const resetSearch = () => {
    condition.value.eventName = '';
    condition.value.pageNo = 1;
    condition.value.pageSize = 20;
    enabledFilter.value = 'all';
  };

  const addClick = () => {
    resetEditData();
    editVisible.value = true;
    editTitle.value = t('button.add');
  };

  const delClick = async () => {
    confirmVisible.value = true;
  };

  const uptClick = (record: EventDetailVO) => {
    editData.id = record.id;
    editData.eventName = record.eventName;
    editData.enabled = record.enabled;
    editData.remark = record.remark;
    editVisible.value = true;
    editTitle.value = t('button.edit');
  };

  const editOk = async () => {
    const payload: EventDetailVO = {
      id: editData.id || undefined,
      eventName: editData.eventName,
      enabled: editData.enabled,
      remark: editData.remark,
    };
    await saveEvent(payload);
    resetEditData();
    editVisible.value = false;
    await loadEvents();
  };

  const resetEditData = () => {
    editData.id = 0;
    editData.eventName = '';
    editData.enabled = true;
    editData.remark = '';
  };

  const confirmOk = async () => {
    await Promise.all(
      selectedKeys.value.map((id) =>
        deleteEvent({
          id,
          eventName: '',
          enabled: false,
          remark: '',
        })
      )
    );
    await loadEvents();
  };

  loadEvents();
</script>

<script lang="ts">
  export default {
    name: 'Event',
  };
</script>

<style scoped lang="less">
  :deep(.arco-form-item-content-flex) {
    flex-wrap: wrap;
    align-items: center;
    justify-content: flex-start;
  }
  :deep(.arco-space-horizontal, .arco-col arco-col-24) {
    flex-wrap: wrap;
    align-items: center;
  }
  :deep(.arco-row-align-start > .arco-col) {
    flex-wrap: wrap;
  }
  :deep(.arco-card-body > .arco-space-vertical) {
    width: 100% !important;
  }
  :deep(.arco-space-item .arco-input-wrapper) {
    width: 100% !important;
    max-width: 400px !important;
  }
  :deep(.arco-space-item) {
    width: 100%;
  }
  :deep(.arco-form-item-content > div) {
    width: 100%;
  }
  :deep(.arco-form-item-content > div > *) {
    margin-right: 5px;
    margin-top: 5px;
  }
  :deep(.arco-table-th) {
    min-width: 30px;
  }
</style>
