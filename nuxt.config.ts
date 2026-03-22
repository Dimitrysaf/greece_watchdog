export default defineNuxtConfig({
  modules: ['@nuxtjs/supabase', 'vue-fomantic-ui/nuxt'],
  app: {
    head: {
      link: [
        { rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/fomantic-ui@2.9.3/dist/semantic.min.css' }
      ]
    }
  }
})


