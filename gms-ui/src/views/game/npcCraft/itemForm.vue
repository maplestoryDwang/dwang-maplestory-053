<template>
  <a-modal
    v-model:visible="visible"
    :ok-loading="loading"
    :on-before-ok="handleBeforeOk"
    :width="640"
    @cancel="handleCancel"
  >
    <template #title> {{ formData.id ? '编辑配方' : '新增配方' }} </template>
    <div>
      <a-form
        :model="formData"
        label-col="{ span: 6 }"
        wrapper-col="{ span: 18 }"
      >
        <a-form-item label="产物物品 ID" required>
          <a-space>
            <a-input-number v-model="formData.itemId" style="width: 180px" />
            <img
              v-if="formData.itemId"
              :src="getIconUrl('item', formData.itemId)"
              alt=""
            />
          </a-space>
        </a-form-item>
        <a-form-item label="显示名称">
          <a-input
            v-model="formData.displayText"
            placeholder="留空则自动读取道具名"
          />
        </a-form-item>
        <a-form-item label="是否装备">
          <a-switch
            v-model="formData.isEquip"
            type="round"
            :checked-value="true"
            :unchecked-value="false"
          >
            <template #checked>装备</template>
            <template #unchecked>道具/消耗品</template>
          </a-switch>
        </a-form-item>
        <a-form-item label="产出数量">
          <a-input-number
            v-model="formData.yieldQty"
            :min="1"
            style="width: 180px"
          />
        </a-form-item>
        <a-form-item label="限制等级">
          <a-input-number
            v-model="formData.reqLevel"
            :min="0"
            style="width: 180px"
          />
        </a-form-item>
        <a-form-item label="职业要求">
          <a-select v-model="formData.jobName">
            <a-option value="全职业">全职业</a-option>
            <a-option value="战士">战士</a-option>
            <a-option value="魔法师">魔法师</a-option>
            <a-option value="飞侠">飞侠</a-option>
            <a-option value="弓箭手">弓箭手</a-option>
          </a-select>

        </a-form-item>
        <a-form-item label="消耗金币">
          <a-input-number
            v-model="formData.cost"
            :min="0"
            style="width: 180px"
          />
        </a-form-item>
        <a-form-item label="排序">
          <a-input-number
            v-model="formData.sortOrder"
            :min="0"
            style="width: 180px"
          />
        </a-form-item>

        <!-- 材料明细 -->
        <a-form-item label="合成材料">
          <div style="width: 100%">
            <div
              v-for="(mat, idx) in formData.mats"
              :key="idx"
              style="margin-bottom: 8px"
            >
              <a-space>
                <a-input-number
                  v-model="mat.matId"
                  placeholder="材料 ID"
                  style="width: 130px"
                />
                <img
                  v-if="mat.matId"
                  :src="getIconUrl('item', mat.matId)"
                  style="width: 24px"
                  alt=""
                />
                <span>×</span>
                <a-input-number
                  v-model="mat.matQty"
                  placeholder="数量"
                  :min="1"
                  style="width: 100px"
                />
                <a-button
                  type="text"
                  status="danger"
                  size="mini"
                  @click="removeMat(idx)"
                >
                  删除
                </a-button>
              </a-space>
            </div>
            <a-button type="dashed" long @click="addMat">+ 添加材料</a-button>
          </div>
        </a-form-item>
      </a-form>
    </div>
  </a-modal>
</template>

<script lang="ts" setup>
  import { ref } from 'vue';
  import useLoading from '@/hooks/loading';
  import { Message } from '@arco-design/web-vue';
  import { getIconUrl } from '@/utils/mapleStoryAPI';
  import { NpcCraftItemForm, NpcCraftMatForm, saveItem } from '@/api/npcCraft';

  const { loading, setLoading } = useLoading(false);
  const visible = ref<boolean>(false);
  const formData = ref<NpcCraftItemForm>({
    categoryId: 0,
    itemId: 0,
    isEquip: false,
    yieldQty: 1,
    reqLevel: 0,
    jobName: '',
    cost: 0,
    displayText: '',
    sortOrder: 0,
    mats: [],
  });

  const emit = defineEmits(['loadData']);

  const addMat = () => {
    formData.value.mats?.push({ matId: 0, matQty: 1 } as NpcCraftMatForm);
  };

  const removeMat = (idx: number) => {
    formData.value.mats?.splice(idx, 1);
  };

  const handleBeforeOk = async () => {
    if (!formData.value.itemId) {
      Message.error('产物物品 ID 不能为空');
      return false;
    }
    // 过滤掉未填写的材料行
    const mats = (formData.value.mats || []).filter((m) => m.matId && m.matQty);
    setLoading(true);
    try {
      await saveItem({ ...formData.value, mats });
      visible.value = false;
      Message.success(formData.value.id ? '更新成功！' : '新增成功！');
      emit('loadData');
      return true;
    } catch (err: any) {
      Message.error(err.message || '保存失败');
      return false;
    } finally {
      setLoading(false);
    }
  };

  const handleCancel = () => {
    visible.value = false;
  };

  // 新增配方：传入所属分类 ID
  const initAdd = (categoryId: number) => {
    formData.value = {
      categoryId,
      itemId: 0,
      isEquip: false,
      yieldQty: 1,
      reqLevel: 0,
      jobName: '',
      cost: 0,
      displayText: '',
      sortOrder: 0,
      mats: [],
    };
    visible.value = true;
  };

  // 编辑配方：传入已有配方 (NpcCraftOption / RecipeOptionDTO)
  const initEdit = (opt: any) => {
    formData.value = {
      id: opt.recipeId ?? opt.id,
      categoryId: opt.catId,
      itemId: opt.itemId,
      isEquip: !!opt.isEquip,
      yieldQty: opt.yieldQty ?? 1,
      reqLevel: opt.reqLevel ?? 0,
      jobName: opt.jobName || '',
      cost: opt.cost ?? 0,
      displayText: opt.displayText || '',
      sortOrder: opt.sortOrder ?? 0,
      mats: (opt.mats || []).map((matId: number, idx: number) => ({
        matId,
        matQty: opt.matQty ? opt.matQty[idx] : 1,
      })),
    };
    visible.value = true;
  };

  defineExpose({ initAdd, initEdit });
</script>

<script lang="ts">
  export default {
    name: 'NpcCraftItemForm',
  };
</script>
