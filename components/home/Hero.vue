<script setup lang="ts">
import { ExternalLink } from 'lucide-vue-next'

const { qualifier } = useExternalLinks()
const { handleImageError, fallbackImage } = useImageError()
</script>

<template>
  <div class="relative h-screen bg-black overflow-hidden">
    <!-- Background Image -->
    <div class="absolute inset-0">
      <img
        src="/assets/images/backgrounds/BG-01.png"
        alt="Monstar Games"
        class="w-full h-full object-cover opacity-40"
        loading="eager"
        @error="(e) => handleImageError(e, fallbackImage)"
      />
      <div class="absolute inset-0 bg-gradient-to-b from-black/60 via-transparent to-black/80" />
    </div>

    <!-- Content -->
    <div class="relative z-10 flex flex-col items-center justify-center h-full text-white px-4">
      <!-- Logo -->
      <div class="mb-20 animate-fade-in">
        <div class="w-72 h-72 relative mx-auto">
          <img
            src="/logo_oficial.png"
            alt="Monstar Games Logo"
            class="w-full h-full object-contain"
            loading="eager"
            @error="(e) => handleImageError(e, fallbackImage)"
          />
        </div>
      </div>

      <!-- Subtitle -->
      <p class="text-xl md:text-2xl mb-8 text-white-400">
        Monstar Games | Edição 2025/26
      </p>
      <p class="text-xl md:text-1xl mb-2 text-gray-600">
        INSCRIÇÕES QUALIFIER
      </p>

      <!-- CTA Button -->
      <a
        :href="qualifier"
        target="_blank"
        rel="noopener noreferrer"
        class="bg-cyan-500 hover:bg-cyan-600 px-12 py-5 rounded-lg text-xl font-bold transition-all transform hover:scale-105 shadow-2xl flex items-center gap-3"
      >
        CLIQUE AQUI!
        <ExternalLink :size="24" />
      </a>

      <!-- Scroll Indicator -->
      <div class="absolute bottom-10 animate-bounce">
        <div class="w-8 h-12 border-2 border-white rounded-full flex items-start justify-center p-2">
          <div class="w-1 h-3 bg-white rounded-full" />
        </div>
      </div>
    </div>

    <!-- Animated Ticker -->
    <div class="absolute bottom-0 w-full bg-gradient-to-r from-pink-600 to-purple-600 py-3 overflow-hidden">
      <div class="animate-marquee whitespace-nowrap text-white font-bold text-lg">
        <span class="mx-8">INSCRIÇÕES QUALIFIER • TEMPORADA 2026</span>
        <span class="mx-8">INSCRIÇÕES TIMES</span>
        <span class="mx-8">STANDARDS 2026</span>
        <span class="mx-8">INSCRIÇÕES QUALIFIER • TEMPORADA 2026</span>
        <span class="mx-8">INSCRIÇÕES TIMES</span>
        <span class="mx-8">STANDARDS 2026</span>
      </div>
    </div>
  </div>
</template>

