# Παρατηρητήριο Ελλάδας

Ανεξάρτητη πλατφόρμα καταγραφής θεσμικών αποκλίσεων στην Ελλάδα, 2023–σήμερα.

## Tech Stack

| Layer      | Τεχνολογία              |
|------------|-------------------------|
| Frontend   | **Nuxt 3** (Vue 3)      |
| Styling    | Tailwind CSS + custom CSS variables |
| Database   | **Supabase** (Postgres + Auth) |
| Hosting    | **Vercel**              |
| Fonts      | Syne · Literata · IBM Plex Mono |

---

## Γρήγορη εκκίνηση

```bash
# 1. Εγκατάσταση dependencies
npm install

# 2. Αντίγραφο env
cp .env.example .env
# → Βάλε τα Supabase credentials σου στο .env

# 3. Dev server
npm run dev
# → http://localhost:3000
```

---

## Δομή Project

```
paratiritrio-elladas/
├── assets/css/
│   └── main.css              # Design tokens + global styles
├── components/
│   ├── IncidentCard.vue      # Κύρια κάρτα περιστατικού
│   ├── ScoreBar.vue          # Μπάρα επικινδυνότητας
│   ├── SectionHeader.vue     # Header θεματικής ενότητας
│   └── StatusBadge.vue       # Ενεργό / Εκκρεμεί / Έκλεισε
├── composables/
│   └── useIncidents.ts       # Data layer (mock → Supabase)
├── layouts/
│   └── default.vue           # Navbar + Footer
├── pages/
│   ├── index.vue             # Homepage με filter
│   ├── about.vue             # Σχετικά
│   ├── login.vue             # Σύνδεση
│   └── incidents/[id].vue    # Σελίδα περιστατικού
├── types/
│   └── index.ts              # TypeScript types
├── utils/
│   └── mockData.ts           # Όλα τα δεδομένα από το PDF
├── supabase-schema.sql       # SQL schema για το Supabase
├── nuxt.config.ts
├── tailwind.config.js
└── vercel.json
```

---

## Supabase Setup

1. Δημιούργησε νέο project στο [supabase.com](https://supabase.com)
2. Πήγαινε στο **SQL Editor** και εκτέλεσε το `supabase-schema.sql`
3. Αντέγραψε `Project URL` και `anon public key` στο `.env`
4. Uncomment τα Supabase blocks στο `composables/useIncidents.ts`

---

## Deploy στο Vercel

```bash
# Εγκατάσταση Vercel CLI
npm i -g vercel

# Deploy
vercel

# Ή απλά: σύνδεσε το GitHub repo στο vercel.com
# και βάλε τα env vars στο dashboard
```

Env vars που χρειάζεται το Vercel:
```
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_KEY=your-anon-public-key
```

---

## Roadmap

- [x] Proof of concept UI με mock data
- [x] Incident cards με score, status, κατηγορία
- [x] Filter ανά θεματική ενότητα
- [x] Detail page ανά περιστατικό
- [x] Supabase schema (incidents, comments, proposals, profiles)
- [ ] Σύνδεση με Supabase (live data)
- [ ] Authentication (email + Google OAuth)
- [ ] Σχόλια ανά incident
- [ ] Προτάσεις επεξεργασίας
- [ ] Admin panel
- [ ] i18n (EN/EL)
