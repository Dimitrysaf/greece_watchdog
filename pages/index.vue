<script setup lang="ts">
import { INCIDENTS, SECTIONS } from '~/utils/mockData'

useHead({ title: 'Παρατηρητήριο Ελλάδας' })

const activeFilter = ref<string>('all')

const stats = computed(() => ({
  total:    INCIDENTS.length,
  active:   INCIDENTS.filter(i => i.status === 'Ενεργό').length,
  critical: INCIDENTS.filter(i => i.score >= 9).length,
  pending:  INCIDENTS.filter(i => i.status === 'Εκκρεμεί').length,
}))

const filteredIncidents = computed(() =>
  activeFilter.value === 'all'
    ? INCIDENTS
    : INCIDENTS.filter(i => i.section === activeFilter.value)
)

const incidentsBySection = computed(() =>
  SECTIONS.map(s => ({
    ...s,
    incidents: INCIDENTS.filter(i => i.section === s.key),
  }))
)
</script>

<template>
  <div>
    <!-- ── Hero ── -->
    <section class="hero grid-dots">
      <div class="container hero__inner">
        <div class="hero__eyebrow mono fade-up">
          ◉ Ανεξάρτητη Καταγραφή · 2023–2026
        </div>
        <h1 class="hero__title fade-up stagger-1">
          Παρατηρητήριο<br />
          <span class="hero__title--accent">Ελλάδας</span>
        </h1>
        <p class="hero__desc fade-up stagger-2">
          Αντικειμενική τεκμηρίωση αποκλίσεων από το Σύνταγμα και τα ευρωπαϊκά πρότυπα.
          Κάθε περιστατικό αξιολογείται ως προς αξιοπιστία, σοβαρότητα και διάρκεια.
        </p>

        <!-- Stats -->
        <div class="hero__stats fade-up stagger-3">
          <div class="stat">
            <div class="stat__value">{{ stats.total }}</div>
            <div class="stat__label mono">Περιστατικά</div>
          </div>
          <div class="stat stat--red">
            <div class="stat__value">{{ stats.active }}</div>
            <div class="stat__label mono">Ενεργά</div>
          </div>
          <div class="stat stat--orange">
            <div class="stat__value">{{ stats.critical }}</div>
            <div class="stat__label mono">Κρίσιμα (9+)</div>
          </div>
          <div class="stat">
            <div class="stat__value">{{ stats.pending }}</div>
            <div class="stat__label mono">Εκκρεμή</div>
          </div>
        </div>
      </div>
    </section>

    <!-- ── Opinion Banner ── -->
    <section class="opinion-banner">
      <div class="container">
        <div class="opinion-banner__inner">
          <div class="opinion-banner__icon">⚠</div>
          <p class="opinion-banner__text">
            Πρόκειται για <strong>διάβρωση, όχι κατάρρευση</strong>. Δεν έχει ανασταλεί το Σύνταγμα.
            Ωστόσο, οι μηχανισμοί ελέγχου — δικαιοσύνη, ανεξάρτητες αρχές, ΜΜΕ — λειτουργούν υπό πίεση.
            Η Ευρωπαϊκή Επιτροπή, η Human Rights Watch και ο World Justice Project επισημαίνουν τα ίδια προβλήματα.
          </p>
        </div>
      </div>
    </section>

    <!-- ── Filter Bar ── -->
    <section class="filter-bar">
      <div class="container">
        <div class="filter-bar__inner">
          <button
            class="filter-btn"
            :class="{ 'filter-btn--active': activeFilter === 'all' }"
            @click="activeFilter = 'all'"
          >
            Όλα
          </button>
          <button
            v-for="section in SECTIONS"
            :key="section.key"
            class="filter-btn"
            :class="{ 'filter-btn--active': activeFilter === section.key }"
            @click="activeFilter = section.key"
          >
            {{ section.icon }} {{ section.label }}
          </button>
        </div>
      </div>
    </section>

    <!-- ── Incidents by section ── -->
    <section class="incidents-area">
      <div class="container">

        <!-- Filtered flat view -->
        <div v-if="activeFilter !== 'all'" class="incidents-grid">
          <IncidentCard
            v-for="(incident, idx) in filteredIncidents"
            :key="incident.id"
            :incident="incident"
            :index="idx"
          />
        </div>

        <!-- Grouped by section -->
        <div v-else class="incidents-sections">
          <div
            v-for="section in incidentsBySection"
            :key="section.key"
            class="incidents-section"
          >
            <SectionHeader
              :icon="section.icon"
              :label="section.label"
              :description="section.description"
              :count="section.incidents.length"
            />
            <div class="incidents-grid">
              <IncidentCard
                v-for="(incident, idx) in section.incidents"
                :key="incident.id"
                :incident="incident"
                :index="idx"
              />
            </div>
          </div>
        </div>

      </div>
    </section>
  </div>
</template>

<style scoped>
/* ── Hero ── */
.hero {
  padding: 5rem 0 3.5rem;
  border-bottom: 1px solid var(--border);
  position: relative;
  overflow: hidden;
}

.hero::after {
  content: '';
  position: absolute;
  bottom: -80px;
  left: 50%;
  transform: translateX(-50%);
  width: 600px;
  height: 200px;
  background: radial-gradient(ellipse, rgba(46,109,164,0.12) 0%, transparent 70%);
  pointer-events: none;
}

.hero__inner {
  max-width: 760px;
}

.hero__eyebrow {
  font-size: 0.78rem;
  color: var(--blue-light);
  letter-spacing: 0.1em;
  margin-bottom: 1rem;
  font-weight: 600;
}

.hero__title {
  font-size: clamp(2.5rem, 6vw, 4.5rem);
  font-weight: 800;
  line-height: 1.05;
  margin: 0 0 1.25rem;
  letter-spacing: -0.03em;
}

.hero__title--accent {
  background: linear-gradient(135deg, var(--blue-light), #7bb8e8);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero__desc {
  font-size: 1.05rem;
  color: var(--text-secondary);
  max-width: 580px;
  line-height: 1.7;
  margin: 0 0 2.5rem;
}

.hero__stats {
  display: flex;
  gap: 2rem;
  flex-wrap: wrap;
}

.stat {
  display: flex;
  flex-direction: column;
  gap: 0.15rem;
}

.stat__value {
  font-family: var(--font-display);
  font-size: 2.5rem;
  font-weight: 800;
  line-height: 1;
  color: var(--text-primary);
}

.stat--red .stat__value  { color: var(--red); }
.stat--orange .stat__value { color: var(--orange); }

.stat__label {
  font-size: 0.7rem;
  color: var(--text-muted);
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

/* ── Opinion Banner ── */
.opinion-banner {
  padding: 1.25rem 0;
  background: rgba(230, 126, 34, 0.06);
  border-bottom: 1px solid rgba(230, 126, 34, 0.2);
}

.opinion-banner__inner {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
}

.opinion-banner__icon {
  font-size: 1.1rem;
  color: var(--orange);
  flex-shrink: 0;
  margin-top: 0.1rem;
}

.opinion-banner__text {
  font-size: 0.875rem;
  color: var(--text-secondary);
  line-height: 1.65;
  margin: 0;
}

.opinion-banner__text strong {
  color: var(--orange);
}

/* ── Filter Bar ── */
.filter-bar {
  padding: 1rem 0;
  border-bottom: 1px solid var(--border);
  position: sticky;
  top: 64px;
  z-index: 50;
  background: rgba(13, 31, 51, 0.92);
  backdrop-filter: blur(12px);
}

.filter-bar__inner {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.filter-btn {
  font-family: var(--font-display);
  font-size: 0.8rem;
  font-weight: 600;
  padding: 0.35rem 0.9rem;
  border: 1px solid var(--border);
  border-radius: 20px;
  background: transparent;
  color: var(--text-secondary);
  cursor: pointer;
  transition: all 0.2s;
  letter-spacing: 0.02em;
}

.filter-btn:hover {
  border-color: var(--blue);
  color: var(--text-primary);
}

.filter-btn--active {
  background: var(--blue);
  border-color: var(--blue);
  color: #fff;
}

/* ── Incidents Area ── */
.incidents-area {
  padding: 2.5rem 0 4rem;
}

.incidents-sections {
  display: flex;
  flex-direction: column;
  gap: 3rem;
}

.incidents-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
  gap: 1rem;
}

@media (max-width: 640px) {
  .hero { padding: 3rem 0 2.5rem; }
  .hero__stats { gap: 1.25rem; }
  .stat__value { font-size: 2rem; }
  .incidents-grid { grid-template-columns: 1fr; }
}
</style>
