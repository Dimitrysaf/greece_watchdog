<script setup lang="ts">
import { INCIDENTS, SECTIONS } from '~/utils/mockData'

const route = useRoute()
const incident = computed(() => INCIDENTS.find(i => i.id === route.params.id))
const section = computed(() => SECTIONS.find(s => s.key === incident.value?.section))

const related = computed(() =>
  INCIDENTS.filter(i => i.section === incident.value?.section && i.id !== incident.value?.id).slice(0, 3)
)

if (!incident.value) {
  throw createError({ statusCode: 404, message: 'Περιστατικό δεν βρέθηκε' })
}

useHead({ title: `${incident.value?.title} · Παρατηρητήριο Ελλάδας` })

const categoryLabels: Record<string, string> = {
  "Α'": 'Θεσμική & Νομική Σήψη',
  "Β'": 'Κρατική Λειτουργία & Καταστολή',
  "Γ'": 'Κοινωνική Έκρηξη & Πολιτική Απονομιμοποίηση',
  "Δ'": 'Οικονομική & Διεθνής Διάσταση',
  "Ε'": 'Τελικά Σύνορα',
}

const orderLabels: Record<string, string> = {
  "Α'": 'Επίσημα έγγραφα, ΦΕΚ, δικαστικές αποφάσεις',
  "Β'": 'Δημόσιες δηλώσεις σε ΜΜΕ (καταγεγραμμένες)',
  "Γ'": 'Οπτικοακουστικό υλικό χωρίς επίσημη επιβεβαίωση',
}
</script>

<template>
  <div v-if="incident" class="detail-page">
    <div class="container">

      <!-- Breadcrumb -->
      <nav class="breadcrumb mono fade-up">
        <NuxtLink to="/">Αρχική</NuxtLink>
        <span>›</span>
        <NuxtLink to="/">{{ section?.label }}</NuxtLink>
        <span>›</span>
        <span>{{ incident.title }}</span>
      </nav>

      <div class="detail-layout">
        <!-- Main content -->
        <article class="detail-main fade-up stagger-1">

          <!-- Header -->
          <div class="detail-header">
            <div class="detail-header__meta">
              <span class="detail-cat mono">ΚΑΤ {{ incident.category }}</span>
              <span class="detail-sep">·</span>
              <span class="detail-type mono">{{ incident.type }}</span>
              <span v-if="incident.subsection" class="detail-sep">·</span>
              <span v-if="incident.subsection" class="detail-sub mono">{{ incident.subsection }}</span>
            </div>
            <h1 class="detail-title">{{ incident.title }}</h1>
            <div class="detail-header__footer">
              <div class="detail-date mono">
                <span>◷</span> {{ incident.date }}
              </div>
              <StatusBadge :status="incident.status" />
            </div>
          </div>

          <!-- Score -->
          <div class="detail-score-block">
            <div class="detail-score-block__label mono">Επικινδυνότητα</div>
            <ScoreBar :score="incident.score" />
          </div>

          <!-- Description -->
          <div class="detail-body">
            <h2 class="detail-section-title">Περιγραφή</h2>
            <p>{{ incident.description }}</p>
          </div>

          <!-- References -->
          <div v-if="incident.references?.length" class="detail-refs">
            <h2 class="detail-section-title">Παραπομπές</h2>
            <ul class="refs-list">
              <li v-for="ref in incident.references" :key="ref" class="refs-list__item">
                <a
                  v-if="ref.startsWith('http')"
                  :href="ref"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="refs-list__link mono"
                >
                  ↗ {{ ref }}
                </a>
                <span v-else class="refs-list__plain mono">{{ ref }}</span>
              </li>
            </ul>
          </div>

          <!-- Comments placeholder -->
          <div class="detail-comments">
            <h2 class="detail-section-title">Σχόλια</h2>
            <div class="comments-placeholder mono">
              Συνδεθείτε για να αφήσετε σχόλιο ή πρόταση επεξεργασίας.
              <NuxtLink to="/login" class="comments-login-link">Σύνδεση →</NuxtLink>
            </div>
          </div>

        </article>

        <!-- Sidebar -->
        <aside class="detail-sidebar fade-up stagger-2">

          <!-- Metadata card -->
          <div class="sidebar-card">
            <div class="sidebar-card__title mono">Μεταδεδομένα</div>
            <div class="sidebar-meta">
              <div class="sidebar-meta__row">
                <span class="sidebar-meta__key mono">Κατηγορία</span>
                <span class="sidebar-meta__val">{{ incident.category }} — {{ categoryLabels[incident.category] }}</span>
              </div>
              <div class="sidebar-meta__row">
                <span class="sidebar-meta__key mono">Τάξη</span>
                <span class="sidebar-meta__val">{{ incident.documentation_order }} — {{ orderLabels[incident.documentation_order] }}</span>
              </div>
              <div class="sidebar-meta__row">
                <span class="sidebar-meta__key mono">Κατάσταση</span>
                <StatusBadge :status="incident.status" />
              </div>
              <div class="sidebar-meta__row">
                <span class="sidebar-meta__key mono">Βαθμολογία</span>
                <span class="sidebar-meta__val mono" style="color: var(--red); font-weight: 700;">
                  {{ incident.score }}/10
                </span>
              </div>
            </div>
          </div>

          <!-- Related incidents -->
          <div v-if="related.length" class="sidebar-card">
            <div class="sidebar-card__title mono">Σχετικά περιστατικά</div>
            <div class="related-list">
              <NuxtLink
                v-for="rel in related"
                :key="rel.id"
                :to="`/incidents/${rel.id}`"
                class="related-item"
              >
                <div class="related-item__title">{{ rel.title }}</div>
                <div class="related-item__footer">
                  <StatusBadge :status="rel.status" />
                  <span class="mono" style="font-size: 0.7rem; color: var(--text-muted);">{{ rel.score }}/10</span>
                </div>
              </NuxtLink>
            </div>
          </div>

        </aside>
      </div>
    </div>
  </div>
</template>

<style scoped>
.detail-page {
  padding: 2rem 0 5rem;
}

/* ── Breadcrumb ── */
.breadcrumb {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.75rem;
  color: var(--text-muted);
  margin-bottom: 2rem;
}

.breadcrumb a {
  color: var(--blue-light);
  text-decoration: none;
}

.breadcrumb a:hover { text-decoration: underline; }

/* ── Layout ── */
.detail-layout {
  display: grid;
  grid-template-columns: 1fr 300px;
  gap: 2rem;
  align-items: start;
}

/* ── Main ── */
.detail-main {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.detail-header {
  padding-bottom: 1.5rem;
  border-bottom: 1px solid var(--border);
}

.detail-header__meta {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.75rem;
  flex-wrap: wrap;
}

.detail-cat { font-size: 0.75rem; font-weight: 600; color: var(--blue-light); letter-spacing: 0.06em; }
.detail-sep { color: var(--text-muted); }
.detail-type { font-size: 0.75rem; color: var(--text-secondary); }
.detail-sub  { font-size: 0.75rem; color: var(--text-muted); }

.detail-title {
  font-size: clamp(1.5rem, 3vw, 2.25rem);
  font-weight: 800;
  letter-spacing: -0.02em;
  margin: 0 0 1rem;
  line-height: 1.15;
}

.detail-header__footer {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.detail-date {
  display: flex;
  align-items: center;
  gap: 0.35rem;
  font-size: 0.78rem;
  color: var(--text-muted);
}

/* Score block */
.detail-score-block {
  background: var(--navy-mid);
  border: 1px solid var(--border);
  border-radius: 8px;
  padding: 1rem 1.25rem;
  display: flex;
  align-items: center;
  gap: 1.5rem;
}

.detail-score-block__label {
  font-size: 0.72rem;
  color: var(--text-muted);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  flex-shrink: 0;
}

/* Body */
.detail-body p {
  font-size: 1rem;
  line-height: 1.75;
  color: var(--text-secondary);
}

.detail-section-title {
  font-family: var(--font-display);
  font-size: 0.85rem;
  font-weight: 700;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--text-muted);
  margin: 0 0 0.75rem;
}

/* References */
.refs-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.refs-list__link {
  font-size: 0.75rem;
  color: var(--blue-light);
  word-break: break-all;
  text-decoration: none;
  line-height: 1.5;
  transition: color 0.2s;
}

.refs-list__link:hover { color: #fff; text-decoration: underline; }

.refs-list__plain {
  font-size: 0.75rem;
  color: var(--text-secondary);
}

/* Comments */
.comments-placeholder {
  padding: 1.5rem;
  background: var(--navy-mid);
  border: 1px dashed var(--border-mid);
  border-radius: 8px;
  font-size: 0.82rem;
  color: var(--text-muted);
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
}

.comments-login-link {
  color: var(--blue-light);
  text-decoration: none;
  white-space: nowrap;
}

/* ── Sidebar ── */
.detail-sidebar {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  position: sticky;
  top: 100px;
}

.sidebar-card {
  background: var(--navy-mid);
  border: 1px solid var(--border);
  border-radius: 8px;
  padding: 1.1rem;
}

.sidebar-card__title {
  font-size: 0.7rem;
  font-weight: 600;
  color: var(--text-muted);
  letter-spacing: 0.1em;
  text-transform: uppercase;
  margin-bottom: 0.9rem;
  padding-bottom: 0.6rem;
  border-bottom: 1px solid var(--border);
}

.sidebar-meta {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.sidebar-meta__row {
  display: flex;
  flex-direction: column;
  gap: 0.2rem;
}

.sidebar-meta__key {
  font-size: 0.65rem;
  color: var(--text-muted);
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

.sidebar-meta__val {
  font-size: 0.82rem;
  color: var(--text-secondary);
  line-height: 1.4;
}

/* Related */
.related-list {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.related-item {
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
  padding: 0.65rem;
  background: var(--navy-light);
  border: 1px solid var(--border);
  border-radius: 6px;
  text-decoration: none;
  color: inherit;
  transition: border-color 0.2s;
}

.related-item:hover { border-color: var(--blue); }

.related-item__title {
  font-family: var(--font-display);
  font-size: 0.8rem;
  font-weight: 600;
  color: var(--text-primary);
  line-height: 1.3;
}

.related-item__footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

/* ── Responsive ── */
@media (max-width: 768px) {
  .detail-layout {
    grid-template-columns: 1fr;
  }
  .detail-sidebar {
    position: static;
  }
}
</style>
