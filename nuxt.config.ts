import tailwindcss from '@tailwindcss/vite'

export default defineNuxtConfig({
  modules: ['@nuxtjs/supabase', '@nuxtjs/i18n'],
  // @ts-ignore
  supabase: { redirect: false },
  // @ts-ignore
  i18n: {
    locales: [
      { code: 'el', file: 'el.json' },
      { code: 'en', file: 'en.json' }
    ],
    defaultLocale: 'el',
  },
  vite: {
    plugins: [tailwindcss()]
  },
  css: ['~/assets/css/tailwind.css'],
  compatibilityDate: '2026-03-22'
})