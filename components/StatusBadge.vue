<script setup lang="ts">
import type { IncidentStatus } from '~/types'

const props = defineProps<{
  status: IncidentStatus
}>()

const config = computed(() => ({
  'Ενεργό':  { dot: '#c0392b', bg: 'rgba(192,57,43,0.12)',  border: 'rgba(192,57,43,0.35)', pulse: true  },
  'Εκκρεμεί': { dot: '#e67e22', bg: 'rgba(230,126,34,0.12)', border: 'rgba(230,126,34,0.35)', pulse: false },
  'Έκλεισε':  { dot: '#27ae60', bg: 'rgba(39,174,96,0.12)',  border: 'rgba(39,174,96,0.35)',  pulse: false },
}[props.status]))
</script>

<template>
  <span
    class="status-badge mono"
    :style="{
      background: config.bg,
      border: `1px solid ${config.border}`,
      color: config.dot,
    }"
  >
    <span
      class="status-dot"
      :class="{ 'status-dot--pulse': config.pulse }"
      :style="{ background: config.dot }"
    />
    {{ status }}
  </span>
</template>

<style scoped>
.status-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  padding: 0.2rem 0.6rem;
  border-radius: 4px;
  font-size: 0.72rem;
  font-weight: 600;
  letter-spacing: 0.04em;
  white-space: nowrap;
}

.status-dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  flex-shrink: 0;
}

.status-dot--pulse {
  animation: pulseDot 2s ease-in-out infinite;
}

@keyframes pulseDot {
  0%, 100% { opacity: 1; transform: scale(1); }
  50%       { opacity: 0.5; transform: scale(1.4); }
}
</style>
