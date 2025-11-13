/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./components/**/*.{js,vue,ts}",
    "./layouts/**/*.vue",
    "./pages/**/*.vue",
    "./plugins/**/*.{js,ts}",
    "./app.vue",
    "./error.vue",
  ],
  theme: {
    extend: {
      colors: {
        monstar: {
          gold: '#FFD700',
          pink: '#FF006E',
          cyan: '#00D9FF',
          lime: '#BFFF00',
          orange: '#FF8C00',
          red: '#FF0000',
          purple: '#9D4EDD',
          dark: '#0A0A0A',
        }
      },
      fontFamily: {
        'heading': ['Montserrat', 'sans-serif'],
        'body': ['Inter', 'sans-serif']
      },
      animation: {
        'marquee': 'marquee 30s linear infinite',
        'fade-in': 'fade-in 1s ease-out',
      },
      keyframes: {
        marquee: {
          '0%': { transform: 'translateX(0%)' },
          '100%': { transform: 'translateX(-50%)' }
        },
        'fade-in': {
          'from': { opacity: '0', transform: 'translateY(20px)' },
          'to': { opacity: '1', transform: 'translateY(0)' }
        }
      }
    },
  },
  plugins: [],
}

