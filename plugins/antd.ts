/// <reference types="nuxt" />
import Antd, { theme } from 'ant-design-vue'
import 'ant-design-vue/dist/reset.css'
import { defineNuxtPlugin } from 'nuxt/app'

export default defineNuxtPlugin((nuxtApp) => {
    nuxtApp.vueApp.use(Antd)
})