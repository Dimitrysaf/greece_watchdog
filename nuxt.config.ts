// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },

  modules: [
    '@nuxtjs/supabase',
    '@nuxtjs/tailwindcss',
  ],

  supabase: {
    // Your Supabase URL and Key go in .env
    // SUPABASE_URL=...
    // SUPABASE_KEY=...
    redirectOptions: {
      login: '/login',
      callback: '/confirm',
      exclude: ['/', '/incidents/*'],
    }
  },

  css: ['~/assets/css/main.css'],

  app: {
    head: {
      title: 'Παρατηρητήριο Ελλάδας',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        {
          name: 'description',
          content: 'Ανεξάρτητη καταγραφή θεσμικών αποκλίσεων στην Ελλάδα, 2023–σήμερα.'
        },
        { property: 'og:title', content: 'Παρατηρητήριο Ελλάδας' },
        { property: 'og:description', content: 'Ανεξάρτητη καταγραφή θεσμικών αποκλίσεων, 2023–σήμερα.' },
      ],
      link: [
        { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
        { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: '' },
        {
          rel: 'stylesheet',
          href: 'https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;600&family=Syne:wght@400;600;700;800&family=Literata:ital,wght@0,400;0,500;1,400&display=swap'
        }
      ]
    }
  },

  runtimeConfig: {
    public: {
      appName: 'Παρατηρητήριο Ελλάδας',
    }
  },

  compatibilityDate: '2024-11-01',
})
