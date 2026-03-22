<template>
    <a-menu mode="horizontal">
        <a-menu-item key="home">
            <router-link to="/">{{ t('menu.home') }}</router-link>
        </a-menu-item>
        <a-menu-item key="about">
            <router-link to="/about">{{ t('menu.about') }}</router-link>
        </a-menu-item>
        <a-menu-item key="submit">
            <router-link to="/submit">{{ t('menu.submit') }}</router-link>
        </a-menu-item>
        <a-menu-item key="login">
            <router-link to="/login">{{ t('menu.login') }}</router-link>
        </a-menu-item>
    </a-menu>
</template>

<script setup lang="ts">
import { useI18n } from 'vue-i18n'

const { t } = useI18n()
</script>