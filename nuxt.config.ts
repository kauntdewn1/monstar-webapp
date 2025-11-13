// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: false },
  modules: ['@nuxtjs/tailwindcss'],

  app: {
    head: {
      title: 'Monstar Games 2025/26 | Goiânia',
      htmlAttrs: {
        lang: 'pt-BR'
      },
      meta: [
        { name: 'description', content: 'Competição de Fitness em Goiânia - Monstar Games. Inscrições abertas para Qualifier 2025/26. Standards, categorias e regulamento completo.' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'language', content: 'pt-BR' },
        { name: 'geo.region', content: 'BR-GO' },
        { name: 'geo.placename', content: 'Goiânia' },
        { name: 'robots', content: 'index, follow' },
        // Open Graph
        { property: 'og:title', content: 'Monstar Games 2025/26 | Goiânia' },
        { property: 'og:description', content: 'Competição de Fitness em Goiânia - Monstar Games. Inscrições abertas para Qualifier 2025/26.' },
        { property: 'og:type', content: 'website' },
        { property: 'og:image', content: '/logo_oficial.png' },
        { property: 'og:locale', content: 'pt_BR' },
        // Twitter Card
        { name: 'twitter:card', content: 'summary_large_image' },
        { name: 'twitter:title', content: 'Monstar Games 2025/26 | Goiânia' },
        { name: 'twitter:description', content: 'Competição de Fitness em Goiânia - Monstar Games' },
        { name: 'twitter:image', content: '/logo_oficial.png' }
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
        { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
        { 
          rel: 'stylesheet', 
          href: 'https://fonts.googleapis.com/css2?family=Montserrat:wght@700;900&family=Inter:wght@400;500;600;700&display=swap' 
        }
      ]
    }
  },

  css: ['~/assets/css/main.css'],

  runtimeConfig: {
    public: {
      cloudName: process.env.CLOUDINARY_CLOUD_NAME || '',
      useCloudinary: false
    }
  },

  vite: {
    optimizeDeps: {
      include: ['lucide-vue-next']
    },
    build: {
      rollupOptions: {
        external: ['app-manifest']
      }
    }
  },

  nitro: {
    compatibilityDate: '2025-11-13',
    preset: 'vercel'
  },

  // Desabilitar app manifest experimental para evitar erros de import
  experimental: {
    appManifest: false
  }
})
