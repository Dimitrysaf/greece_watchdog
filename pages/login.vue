<script setup lang="ts">
useHead({ title: 'Σύνδεση · Παρατηρητήριο Ελλάδας' })

// With @nuxtjs/supabase, you can use useSupabaseClient() here
// const supabase = useSupabaseClient()
// const handleLogin = async () => { await supabase.auth.signInWithOAuth({ provider: 'google' }) }
</script>

<template>
  <div class="login-page">
    <div class="login-card fade-up">
      <div class="login-card__eye">◉</div>
      <h1 class="login-card__title">Σύνδεση</h1>
      <p class="login-card__desc">
        Συνδεθείτε για να αφήσετε σχόλια και προτάσεις επεξεργασίας.
      </p>

      <div class="login-fields">
        <div class="field">
          <label class="field__label mono">Email</label>
          <input type="email" class="field__input" placeholder="you@example.com" />
        </div>
        <div class="field">
          <label class="field__label mono">Κωδικός</label>
          <input type="password" class="field__input" placeholder="••••••••" />
        </div>
        <button class="login-btn">Σύνδεση</button>
        <div class="login-card__or mono">— ή —</div>
        <button class="oauth-btn">
          <span>G</span> Σύνδεση με Google
        </button>
      </div>

      <p class="login-card__note mono">
        Δεν έχετε λογαριασμό;
        <NuxtLink to="/register" class="login-link">Εγγραφή</NuxtLink>
      </p>
    </div>
  </div>
</template>

<style scoped>
.login-page {
  min-height: calc(100vh - 200px);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
}

.login-card {
  width: 100%;
  max-width: 400px;
  background: var(--navy-mid);
  border: 1px solid var(--border-mid);
  border-radius: 12px;
  padding: 2.5rem;
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
  text-align: center;
}

.login-card__eye {
  font-size: 2rem;
  color: var(--blue-light);
}

.login-card__title {
  font-family: var(--font-display);
  font-size: 1.75rem;
  font-weight: 800;
  margin: 0;
}

.login-card__desc {
  font-size: 0.875rem;
  color: var(--text-secondary);
  margin: 0;
  line-height: 1.6;
}

.login-fields {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  text-align: left;
}

.field {
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
}

.field__label {
  font-size: 0.7rem;
  color: var(--text-muted);
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

.field__input {
  background: var(--navy-light);
  border: 1px solid var(--border);
  border-radius: 6px;
  padding: 0.65rem 0.9rem;
  color: var(--text-primary);
  font-family: var(--font-body);
  font-size: 0.9rem;
  outline: none;
  transition: border-color 0.2s;
}

.field__input:focus {
  border-color: var(--blue);
}

.field__input::placeholder {
  color: var(--text-muted);
}

.login-btn {
  margin-top: 0.25rem;
  padding: 0.75rem;
  background: var(--blue);
  border: none;
  border-radius: 6px;
  color: #fff;
  font-family: var(--font-display);
  font-weight: 700;
  font-size: 0.9rem;
  cursor: pointer;
  transition: background 0.2s;
}

.login-btn:hover {
  background: var(--blue-light);
}

.login-card__or {
  text-align: center;
  color: var(--text-muted);
  font-size: 0.72rem;
  letter-spacing: 0.1em;
}

.oauth-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.6rem;
  padding: 0.7rem;
  background: transparent;
  border: 1px solid var(--border-mid);
  border-radius: 6px;
  color: var(--text-secondary);
  font-family: var(--font-display);
  font-size: 0.85rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
}

.oauth-btn span {
  font-weight: 800;
  color: var(--blue-light);
}

.oauth-btn:hover {
  border-color: var(--blue);
  color: var(--text-primary);
}

.login-card__note {
  font-size: 0.75rem;
  color: var(--text-muted);
  margin: 0;
}

.login-link {
  color: var(--blue-light);
  text-decoration: none;
}
</style>
