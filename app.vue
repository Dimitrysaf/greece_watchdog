<template>
  <a-config-provider v-bind="themeConfig">
    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
  </a-config-provider>
</template>

<script setup lang="ts">
import { theme } from 'ant-design-vue'

const themeConfig = {
  theme: {
    algorithm: theme.defaultAlgorithm,
    token: {
      borderRadius: 4,
      borderRadiusLG: 6,
      colorInfo: '#3a87ad',
    },
    components: {
      Tooltip: { fontSize: 12 },
      Checkbox: { colorBorder: '#666', borderRadius: 2, algorithm: true },
      Radio: { colorBorder: '#666', borderRadius: 2, algorithm: true },
    },
  },
}
</script>