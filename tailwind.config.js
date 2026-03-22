/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './components/**/*.{js,vue,ts}',
    './layouts/**/*.vue',
    './pages/**/*.vue',
    './composables/**/*.{js,ts}',
    './app.vue',
  ],
  theme: {
    extend: {
      colors: {
        navy: {
          DEFAULT: '#0d1f33',
          mid: '#132840',
          light: '#1e3a55',
        },
        blue: {
          DEFAULT: '#2e6da4',
          light: '#3d87c8',
        },
        ice: {
          DEFAULT: '#e8f0f7',
          dark: '#d0e0ef',
        },
      },
      fontFamily: {
        display: ['Syne', 'sans-serif'],
        body:    ['Literata', 'serif'],
        mono:    ['IBM Plex Mono', 'monospace'],
      },
    },
  },
  plugins: [],
}
