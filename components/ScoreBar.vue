<script setup lang="ts">
const props = defineProps<{ score: number }>()

const color = computed(() => {
  if (props.score >= 9) return '#c0392b'
  if (props.score >= 7) return '#e67e22'
  return '#27ae60'
})

const label = computed(() => {
  if (props.score >= 9) return 'Κρίσιμο'
  if (props.score >= 7) return 'Υψηλό'
  return 'Μέτριο'
})
</script>

<template>
  <div class="score-bar">
    <div class="score-bar__track">
      <div
        class="score-bar__fill"
        :style="{ width: `${score * 10}%`, background: color }"
      />
    </div>
    <div class="score-bar__meta mono">
      <span :style="{ color }">{{ score }}/10</span>
      <span class="score-bar__label" :style="{ color }">{{ label }}</span>
    </div>
  </div>
</template>

<style scoped>
.score-bar {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.score-bar__track {
  flex: 1;
  height: 4px;
  background: rgba(255,255,255,0.08);
  border-radius: 2px;
  overflow: hidden;
}

.score-bar__fill {
  height: 100%;
  border-radius: 2px;
  transition: width 0.6s ease;
}

.score-bar__meta {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.75rem;
  font-weight: 600;
  white-space: nowrap;
}

.score-bar__label {
  opacity: 0.7;
  font-size: 0.68rem;
}
</style>
