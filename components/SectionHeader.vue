<script setup lang="ts">
defineProps<{
  icon: string
  label: string
  description: string
  count?: number
}>()
</script>

<template>
  <div class="section-hdr">
    <div class="section-hdr__left">
      <span class="section-hdr__icon">{{ icon }}</span>
      <div>
        <h2 class="section-hdr__label">{{ label }}</h2>
        <p class="section-hdr__desc">{{ description }}</p>
      </div>
    </div>
    <div v-if="count !== undefined" class="section-hdr__count mono">
      {{ count }} <span>περιστατικά</span>
    </div>
  </div>
</template>

<style scoped>
.section-hdr {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
  padding: 1rem 1.25rem;
  background: var(--navy-light);
  border: 1px solid var(--border-mid);
  border-radius: 8px;
  margin-bottom: 1.25rem;
}

.section-hdr__left {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.section-hdr__icon {
  font-size: 1.75rem;
  flex-shrink: 0;
}

.section-hdr__label {
  font-family: var(--font-display);
  font-size: 1.1rem;
  font-weight: 800;
  color: var(--text-primary);
  margin: 0 0 0.1rem;
  letter-spacing: -0.01em;
}

.section-hdr__desc {
  font-size: 0.8rem;
  color: var(--text-secondary);
  margin: 0;
  line-height: 1.4;
}

.section-hdr__count {
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--blue-light);
  flex-shrink: 0;
  text-align: right;
}

.section-hdr__count span {
  display: block;
  font-size: 0.65rem;
  color: var(--text-muted);
  letter-spacing: 0.06em;
  text-transform: uppercase;
}
</style>
