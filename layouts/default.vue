<template>
  <div class="layout">
    <!-- Navbar -->
    <nav class="navbar">
      <div class="container navbar__inner">
        <NuxtLink to="/" class="navbar__brand">
          <span class="navbar__eye">◉</span>
          <div>
            <div class="navbar__title">Παρατηρητήριο Ελλάδας</div>
            <div class="navbar__sub mono">observatory.gr</div>
          </div>
        </NuxtLink>

        <div class="navbar__links">
          <NuxtLink to="/" class="nav-link">Αρχική</NuxtLink>
          <NuxtLink to="/incidents" class="nav-link">Περιστατικά</NuxtLink>
          <NuxtLink to="/about" class="nav-link">Σχετικά</NuxtLink>
          <NuxtLink to="/login" class="nav-btn">Σύνδεση</NuxtLink>
        </div>
      </div>
    </nav>

    <!-- Page content -->
    <main class="main-content">
      <slot />
    </main>

    <!-- Footer -->
    <footer class="site-footer">
      <div class="container site-footer__inner">
        <div class="site-footer__brand">
          <span class="mono" style="color: var(--text-muted); font-size: 0.8rem;">
            © 2026 Παρατηρητήριο Ελλάδας — Ανεξάρτητη καταγραφή. Όχι επίσημη έκθεση κράτους ή δικαστηρίου.
          </span>
        </div>
        <div class="site-footer__links">
          <a href="https://hellenicconstitution.miraheze.org" target="_blank" class="footer-link">
            Πηγή
          </a>
        </div>
      </div>
    </footer>
  </div>
</template>

<style scoped>
.layout {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  position: relative;
  z-index: 1;
}

/* ── Navbar ── */
.navbar {
  position: sticky;
  top: 0;
  z-index: 100;
  background: rgba(13, 31, 51, 0.85);
  backdrop-filter: blur(16px);
  border-bottom: 1px solid var(--border);
}

.navbar__inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 64px;
}

.navbar__brand {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  text-decoration: none;
  color: var(--text-primary);
}

.navbar__eye {
  font-size: 1.5rem;
  color: var(--blue-light);
  animation: spin 12s linear infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to   { transform: rotate(360deg); }
}

.navbar__title {
  font-family: var(--font-display);
  font-weight: 700;
  font-size: 1rem;
  line-height: 1.2;
}

.navbar__sub {
  color: var(--text-muted);
  font-size: 0.7rem;
  line-height: 1;
}

.navbar__links {
  display: flex;
  align-items: center;
  gap: 1.5rem;
}

.nav-link {
  font-family: var(--font-display);
  font-size: 0.85rem;
  font-weight: 600;
  color: var(--text-secondary);
  text-decoration: none;
  letter-spacing: 0.03em;
  transition: color 0.2s;
}

.nav-link:hover,
.nav-link.router-link-active {
  color: var(--text-primary);
}

.nav-btn {
  font-family: var(--font-display);
  font-size: 0.8rem;
  font-weight: 700;
  padding: 0.4rem 1rem;
  border: 1px solid var(--border-mid);
  border-radius: 4px;
  color: var(--blue-light);
  text-decoration: none;
  transition: all 0.2s;
  letter-spacing: 0.03em;
}

.nav-btn:hover {
  background: var(--navy-light);
  border-color: var(--blue);
  color: var(--text-primary);
}

/* ── Main ── */
.main-content {
  flex: 1;
}

/* ── Footer ── */
.site-footer {
  border-top: 1px solid var(--border);
  padding: 1.25rem 0;
  margin-top: 4rem;
}

.site-footer__inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.footer-link {
  font-family: var(--font-mono);
  font-size: 0.75rem;
  color: var(--text-muted);
  text-decoration: none;
  transition: color 0.2s;
}

.footer-link:hover {
  color: var(--blue-light);
}

@media (max-width: 640px) {
  .navbar__links { gap: 0.75rem; }
  .nav-link { display: none; }
  .nav-btn { display: block; }
  .site-footer__inner { flex-direction: column; gap: 0.5rem; text-align: center; }
}
</style>
