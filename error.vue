<template>
  <NuxtLayout>
    <a-result
      :status="status"
      :title="title"
      :sub-title="subtitle"
    >
      <template #extra>
        <a-button type="primary" @click="handleError">
          {{ t('error.back_home') }}
        </a-button>
      </template>
    </a-result>
  </NuxtLayout>
</template>

<script setup lang="ts">
// @ts-ignore
import { clearError } from '#imports'
import { useI18n } from 'vue-i18n'
import { computed } from 'vue'

const { t } = useI18n()

const props = defineProps<{ error: { statusCode: number } }>()

const status = computed(() => {
  if ([403, 404, 500].includes(props.error.statusCode)) return String(props.error.statusCode)
  return 'warning'
})

const title = computed(() => String(props.error.statusCode))

const subtitle = computed(() => ({
  404: t('error.404_subtitle'),
  500: t('error.500_subtitle'),
  403: t('error.403_subtitle'),
}[props.error.statusCode] ?? t('error.warning_title')))

const handleError = () => clearError({ redirect: '/' })
</script>