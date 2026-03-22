<script setup lang="ts">
import type { Incident } from '~/types'

const props = defineProps<{
  incident: Incident
  index?: number
}>()

const categoryColors: Record<string, string> = {
  "Α'": '#3d87c8',
  "Β'": '#7b93a8',
  "Γ'": '#9b8ea8',
  "Δ'": '#6aab8e',
  "Ε'": '#c0392b',
}

const catColor = computed(() => categoryColors[props.incident.category] ?? '#3d87c8')
const isCritical = computed(() => props.incident.score >= 9)
</script>

<template>
  <NuxtLink
    :to="`/incidents/${incident.id}`"
    class="incident-card"
    :class="{ 'incident-card--critical': isCritical }"
    :style="{ '--cat-color': catColor, 'animation-delay': `${(index ?? 0) * 0.06}s` }"
  >
    <!-- Left accent bar -->
    <div class="incident-card__accent" />

    <!-- Header -->
    <div class="incident-card__header">
      <div class="incident-card__meta">
        <span class="incident-card__category mono" :style="{ color: catColor }">
          ΚΑΤ {{ incident.category }}
        </span>
        <span class="incident-card__dot">·</span>
        <span class="incident-card__type mono">{{ incident.type }}</span>
      </div>
      <StatusBadge :status="incident.status" />
    </div>

    <!-- Title -->
    <h3 class="incident-card__title">{{ incident.title }}</h3>

    <!-- Description -->
    <p class="incident-card__desc">{{ incident.description }}</p>

    <!-- Footer -->
    <div class="incident-card__footer">
      <div class="incident-card__date mono">
        <span class="incident-card__date-icon">◷</span>
        {{ incident.date }}
      </div>
      <div class="incident-card__score-area">
        <span class="incident-card__order mono">Τάξη {{ incident.documentation_order }}</span>
        <ScoreBar :score="incident.score" />
      </div>
    </div>

    <!-- Critical glow -->
    <div v-if="isCritical" class="incident-card__critical-glow" />
  </NuxtLink>
</template>

<style scoped>
.incident-card {
  position: relative;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  padding: 1.25rem 1.25rem 1.25rem 1.5rem;
  background: var(--navy-mid);
  border: 1px solid var(--border);
  border-radius: 8px;
  text-decoration: none;
  color: inherit;
  overflow: hidden;
  transition: border-color 0.25s, transform 0.2s, box-shadow 0.25s;
  animation: fadeUp 0.4s ease both;
  cursor: pointer;
}

.incident-card:hover {
  border-color: var(--cat-color, var(--blue));
  transform: translateY(-2px);
  box-shadow: 0 8px 32px rgba(0,0,0,0.25);
}

.incident-card--critical {
  border-color: rgba(192, 57, 43, 0.3);
}

.incident-card--critical:hover {
  border-color: var(--red);
  box-shadow: 0 8px 32px rgba(192,57,43,0.15);
}

/* Left accent bar */
.incident-card__accent {
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 3px;
  background: var(--cat-color, var(--blue));
  border-radius: 8px 0 0 8px;
}

/* Header */
.incident-card__header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 0.5rem;
}

.incident-card__meta {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  flex-wrap: wrap;
}

.incident-card__category {
  font-size: 0.7rem;
  font-weight: 600;
  letter-spacing: 0.08em;
}

.incident-card__dot {
  color: var(--text-muted);
  font-size: 0.8rem;
}

.incident-card__type {
  font-size: 0.7rem;
  color: var(--text-secondary);
  letter-spacing: 0.04em;
}

/* Title */
.incident-card__title {
  font-family: var(--font-display);
  font-size: 1.05rem;
  font-weight: 700;
  line-height: 1.25;
  color: var(--text-primary);
  margin: 0;
  transition: color 0.2s;
}

.incident-card:hover .incident-card__title {
  color: #fff;
}

/* Description */
.incident-card__desc {
  font-size: 0.875rem;
  color: var(--text-secondary);
  line-height: 1.6;
  margin: 0;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

/* Footer */
.incident-card__footer {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  gap: 1rem;
  margin-top: 0.25rem;
  padding-top: 0.75rem;
  border-top: 1px solid var(--border);
}

.incident-card__date {
  display: flex;
  align-items: center;
  gap: 0.35rem;
  font-size: 0.72rem;
  color: var(--text-muted);
}

.incident-card__date-icon {
  color: var(--blue);
}

.incident-card__score-area {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 0.3rem;
  min-width: 160px;
}

.incident-card__order {
  font-size: 0.65rem;
  color: var(--text-muted);
  letter-spacing: 0.06em;
}

/* Critical glow */
.incident-card__critical-glow {
  position: absolute;
  top: -40px;
  right: -40px;
  width: 120px;
  height: 120px;
  background: radial-gradient(circle, rgba(192,57,43,0.08) 0%, transparent 70%);
  pointer-events: none;
}
</style>
