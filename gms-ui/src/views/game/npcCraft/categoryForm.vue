<template>
  <a-modal
    v-model:visible="visible"
    :ok-loading="loading"
    :on-before-ok="handleBeforeOk"
    @cancel="handleCancel"
  >
    <template #title> {{ formData.id ? '编辑分类' : '新增分类' }} </template>
    <div>
      <a-form
        :model="formData"
        label-col="{ span: 6 }"
        wrapper-col="{ span: 18 }"
      >
        <a-form-item label="NPC ID">
          <a-input-number
            v-model="formData.npcId"
            :disabled="!!formData.id"
            style="width: 100%"
          />
        </a-form-item>
        <a-form-item label="菜单索引 Menu">
          <a-input-number v-model="formData.menuIndex" style="width: 100%" />
        </a-form-item>
        <a-form-item label="分类名称" required>
          <a-input v-model="formData.categoryName" placeholder="如：精炼矿石" />
        </a-form-item>
        <a-form-item label="制作类型">
          <a-select v-model="formData.craftType">
            <a-option value="EQUIP_SINGLE">EQUIP_SINGLE - 装备精炼</a-option>
            <a-option value="EQUIP_UPGRADE"
              >EQUIP_UPGRADE - 装备合成/升级</a-option
            >
            <a-option value="MATERIAL_BATCH"
              >MATERIAL_BATCH - 材料批量</a-option
            >
          </a-select>
        </a-form-item>
        <a-form-item label="引导提示词">
          <a-textarea
            v-model="formData.promptText"
            :auto-size="{ minRows: 2, maxRows: 4 }"
          />
        </a-form-item>
        <a-form-item label="风险/警告文本">
          <a-textarea
            v-model="formData.warningText"
            :auto-size="{ minRows: 2, maxRows: 4 }"
          />
        </a-form-item>
        <a-form-item label="台词模板 ID">
          <a-input-number v-model="formData.templateId" style="width: 100%" />
        </a-form-item>
      </a-form>
    </div>
  </a-modal>
</template>

<script lang="ts" setup>
  import { ref } from 'vue';
  import useLoading from '@/hooks/loading';
  import { Message } from '@arco-design/web-vue';
  import { NpcCraftCat, saveCategory } from '@/api/npcCraft';

  const { loading, setLoading } = useLoading(false);
  const visible = ref<boolean>(false);
  const formData = ref<NpcCraftCat>({
    npcId: 0,
    menuIndex: 0,
    categoryName: '',
    craftType: 'EQUIP_SINGLE',
    templateId: 1,
  });

  const emit = defineEmits(['loadData']);

  const handleBeforeOk = async () => {
    if (!formData.value.categoryName) {
      Message.error('分类名称不能为空');
      return false;
    }
    setLoading(true);
    try {
      await saveCategory(formData.value);
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

  // 新增分类：传入 NPC ID
  const initAdd = (npcId: number) => {
    formData.value = {
      npcId,
      menuIndex: 0,
      categoryName: '',
      craftType: 'EQUIP_SINGLE',
      templateId: 1,
    };
    visible.value = true;
  };

  // 编辑分类：传入已有分类
  const initEdit = (cat: NpcCraftCat) => {
    formData.value = {
      id: cat.id ?? cat.categoryId,
      npcId: cat.npcId,
      menuIndex: cat.menuIndex,
      categoryName: cat.categoryName,
      craftType: cat.craftType || 'EQUIP_SINGLE',
      promptText: cat.promptText,
      warningText: cat.warningText,
      templateId: cat.templateId || 1,
    };
    visible.value = true;
  };

  defineExpose({ initAdd, initEdit });
</script>

<script lang="ts">
  export default {
    name: 'NpcCraftCategoryForm',
  };
</script>
