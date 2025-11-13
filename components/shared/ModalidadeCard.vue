<script setup lang="ts">
interface Modalidade {
  id: number
  title: string
  subtitle: string
  image: string
  color: string
  status: string
  link: string
  available: boolean
}

const props = defineProps<{
  modalidade: Modalidade
}>()

const { handleImageError, fallbackImage } = useImageError()

const colorMap: Record<string, string> = {
  'from-lime-400 to-lime-600': 'bg-gradient-to-br from-lime-400 to-lime-600',
  'from-yellow-400 to-yellow-600': 'bg-gradient-to-br from-yellow-400 to-yellow-600',
  'from-pink-500 to-pink-700': 'bg-gradient-to-br from-pink-500 to-pink-700',
  'from-orange-400 to-orange-600': 'bg-gradient-to-br from-orange-400 to-orange-600'
}
</script>

<template>
  <a
    :href="modalidade.link"
    :class="[
      'group relative overflow-hidden rounded-lg md:rounded-xl cursor-pointer',
      'aspect-[4/5] md:aspect-square',
      'backdrop-blur-md border border-white/20',
      'bg-gradient-to-br from-white/10 to-white/5',
      'shadow-xl shadow-black/50',
      'hover:border-white/30 hover:shadow-2xl hover:shadow-black/60',
      'transition-all duration-300',
      !modalidade.available && 'pointer-events-none opacity-60'
    ]"
  >
    <!-- Background Pattern -->
    <div class="absolute inset-0 bg-black/40 backdrop-blur-sm">
      <div
        class="absolute inset-0 opacity-30"
        :style="{
          backgroundImage: 'repeating-linear-gradient(45deg, transparent, transparent 10px, rgba(255,255,255,.05) 10px, rgba(255,255,255,.05) 20px)'
        }"
      />
    </div>

    <!-- Gradient Overlay with Glassmorphism -->
    <div
      :class="[
        'absolute inset-0 backdrop-blur-sm',
        colorMap[modalidade.color],
        'opacity-60 group-hover:opacity-70 transition-opacity duration-300'
      ]"
    />
    
    <!-- Glassmorphism Overlay -->
    <div class="absolute inset-0 bg-gradient-to-br from-white/20 via-white/10 to-transparent pointer-events-none" />

    <!-- Logo Watermark -->
    <div class="absolute top-2 left-2 md:top-6 md:left-6 opacity-80">
      <img
        src="/star2.png"
        alt="Monstar Games"
        class="w-10 h-10 md:w-20 md:h-20 object-contain"
        loading="lazy"
        @error="(e) => handleImageError(e, fallbackImage)"
      />
    </div>

    <!-- Content with Glassmorphism Background -->
    <div class="absolute inset-0 flex flex-col justify-end p-3 md:p-8 text-white z-10">
      <div class="backdrop-blur-md bg-black/20 rounded-lg p-2 md:p-4 border border-white/10">
        <p class="text-xs md:text-sm font-medium mb-1 md:mb-2 opacity-90 drop-shadow-lg">{{ modalidade.subtitle }}</p>
        <h3 class="text-xl md:text-4xl font-black mb-2 md:mb-4 leading-tight whitespace-pre-line transform group-hover:translate-y-[-8px] transition-transform drop-shadow-2xl">
          {{ modalidade.title }}
        </h3>
        <button
          :class="[
            'px-4 py-2 md:px-8 md:py-3 rounded-lg text-xs md:text-base font-bold self-start transition-all transform group-hover:scale-105',
            'backdrop-blur-sm border border-white/30',
            'shadow-xl shadow-black/50',
            modalidade.available
              ? 'bg-white/90 text-black hover:bg-white hover:shadow-2xl'
              : 'bg-gray-400/80 text-gray-700 border-gray-500/30'
          ]"
        >
          {{ modalidade.status }}
        </button>
      </div>
    </div>

    <!-- Hover Effect -->
    <div class="absolute inset-0 bg-white/5 opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-xl" />
  </a>
</template>

