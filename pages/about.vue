<script setup lang="ts">
useHead({ title: 'Σχετικά · Παρατηρητήριο Ελλάδας' })
</script>

<template>
  <div class="about-page">
    <div class="container">
      <div class="about-inner">
        <div class="about-eyebrow mono fade-up">◉ Σχετικά με το έργο</div>
        <h1 class="about-title fade-up stagger-1">Τι είναι το<br /><span class="about-accent">Παρατηρητήριο Ελλάδας</span></h1>

        <div class="about-content fade-up stagger-2">
          <p>
            Το Παρατηρητήριο Ελλάδας είναι μια <strong>ανεξάρτητη πλατφόρμα καταγραφής</strong> αντικειμενικών και επαληθεύσιμων γεγονότων που συνθέτουν εικόνα θεσμικής απόκλισης από το Σύνταγμα της Ελληνικής Δημοκρατίας και τα ευρωπαϊκά πρότυπα.
          </p>
          <p>
            Δεν αποτελεί επίσημη έκθεση κράτους ή δικαστηρίου. Δεν είναι πολιτική τοποθέτηση. Είναι εργαλείο παρακολούθησης — όπως ο Rule of Law Monitor της Ευρωπαϊκής Επιτροπής, αλλά με πρωτογενή εστίαση στην Ελλάδα και πλήρη διαφάνεια πηγών.
          </p>

          <h2>Μεθοδολογία</h2>
          <p>Κάθε περιστατικό αξιολογείται ως προς:</p>
          <ul>
            <li><strong>Αξιοπιστία</strong> — τάξη τεκμηρίωσης (Α΄/Β΄/Γ΄)</li>
            <li><strong>Σοβαρότητα</strong> — βαθμολογία 1–10</li>
            <li><strong>Κατάσταση</strong> — Ενεργό / Εκκρεμεί / Έκλεισε</li>
          </ul>

          <h2>Τι δεν είναι αυτό</h2>
          <p>
            Η χώρα <strong>δεν βρίσκεται σε συνταγματική κατάρρευση</strong>. Εκλογές διεξάγονται, Βουλή λειτουργεί, ευρωπαϊκοί θεσμοί παραμένουν ενεργοί. Αυτό που καταγράφεται είναι διάβρωση — σταδιακή εξασθένιση των μηχανισμών ελέγχου.
          </p>

          <h2>Πηγές</h2>
          <p>
            Η αξιολόγηση βασίζεται αποκλειστικά σε δημόσιες, επαληθεύσιμες πηγές: ΦΕΚ, δικαστικές αποφάσεις, δημόσιες δηλώσεις με καταγεγραμμένη πηγή και ημερομηνία, εκθέσεις διεθνών οργανισμών (EU Rule of Law Report, RSF, Human Rights Watch, World Justice Project).
          </p>
        </div>

        <!-- External orgs -->
        <div class="about-orgs fade-up stagger-3">
          <div class="about-orgs__title mono">Διεθνείς φορείς που επισημαίνουν τα ίδια προβλήματα</div>
          <div class="orgs-grid">
            <div class="org-chip mono">Ευρωπαϊκή Επιτροπή<br/><span>Rule of Law Report 2025</span></div>
            <div class="org-chip mono">Human Rights Watch<br/><span>World Report 2026</span></div>
            <div class="org-chip mono">World Justice Project<br/><span>48η θέση παγκοσμίως 2025</span></div>
            <div class="org-chip mono">RSF<br/><span>89η θέση παγκοσμίως 2025</span></div>
            <div class="org-chip mono">Ευρωπαϊκό Κοινοβούλιο<br/><span>Ψήφισμα 7/2/2024</span></div>
          </div>
        </div>

      </div>
    </div>
  </div>
</template>

<style scoped>
.about-page {
  padding: 3rem 0 5rem;
}

.about-inner {
  max-width: 720px;
}

.about-eyebrow {
  font-size: 0.78rem;
  color: var(--blue-light);
  letter-spacing: 0.1em;
  margin-bottom: 1rem;
}

.about-title {
  font-size: clamp(2rem, 5vw, 3.5rem);
  font-weight: 800;
  letter-spacing: -0.03em;
  line-height: 1.1;
  margin: 0 0 2.5rem;
}

.about-accent {
  background: linear-gradient(135deg, var(--blue-light), #7bb8e8);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.about-content {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.about-content p {
  font-size: 1rem;
  color: var(--text-secondary);
  line-height: 1.75;
  margin: 0;
}

.about-content strong {
  color: var(--text-primary);
}

.about-content h2 {
  font-family: var(--font-display);
  font-size: 1.1rem;
  font-weight: 700;
  color: var(--text-primary);
  margin: 0.75rem 0 0;
  padding-top: 1.5rem;
  border-top: 1px solid var(--border);
}

.about-content ul {
  padding-left: 1.25rem;
  color: var(--text-secondary);
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
  font-size: 0.95rem;
}

.about-orgs {
  margin-top: 3rem;
  padding-top: 2rem;
  border-top: 1px solid var(--border);
}

.about-orgs__title {
  font-size: 0.72rem;
  color: var(--text-muted);
  letter-spacing: 0.1em;
  text-transform: uppercase;
  margin-bottom: 1rem;
}

.orgs-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 0.75rem;
}

.org-chip {
  padding: 0.6rem 1rem;
  border: 1px solid var(--border-mid);
  border-radius: 6px;
  font-size: 0.75rem;
  font-weight: 600;
  color: var(--text-secondary);
  line-height: 1.4;
  background: var(--navy-mid);
}

.org-chip span {
  display: block;
  font-size: 0.65rem;
  color: var(--text-muted);
  font-weight: 400;
}
</style>
