// @ts-ignore
import { defineI18nConfig } from '@nuxtjs/i18n/dist/runtime/composables/shared'

export default defineI18nConfig(() => {
  console.log('i18n config loaded!')
  return {
    legacy: false,
    locale: 'el',
    messages: {
      el: {
        menu: {
          home: 'Αρχική',
          about: 'Σχετικά',
          submit: 'Φόρμα Έκδοσης',
          login: 'Σύνδεση'
        }
      },
      en: {
        menu: {
          home: 'Home',
          about: 'About',
          submit: 'Submit Report',
          login: 'Login'
        }
      }
    }
  }
})