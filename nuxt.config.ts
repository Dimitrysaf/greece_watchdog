export default defineNuxtConfig({
  modules: ['@nuxtjs/supabase', '@nuxtjs/i18n'],
  // @ts-ignore
  i18n: {
    locales: [
      { code: 'el', file: 'el.json' },
      { code: 'en', file: 'en.json' }
    ],
    defaultLocale: 'el'
  },
  supabase: {
    redirect: false
  },
  compatibilityDate: '2026-03-22'
})