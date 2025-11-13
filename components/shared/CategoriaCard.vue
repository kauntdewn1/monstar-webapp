<script setup lang="ts">
interface Categoria {
  id: number
  name: string
  subtitle: string
  ageRange: string
  gender: string
  image: string
  color: string
}

const props = defineProps<{
  categoria: Categoria
}>()

const { handleImageError, fallbackImage } = useImageError()

// Glassmorphism reveal effect
const revealPosition = ref({ x: 50, y: 50 })
const isHovering = ref(false)

const handleMouseMove = (event: MouseEvent) => {
  const target = event.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  const x = ((event.clientX - rect.left) / rect.width) * 100
  const y = ((event.clientY - rect.top) / rect.height) * 100
  revealPosition.value = { x, y }
}

const handleTouchMove = (event: TouchEvent) => {
  const target = event.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()
  const touch = event.touches[0]
  const x = ((touch.clientX - rect.left) / rect.width) * 100
  const y = ((touch.clientY - rect.top) / rect.height) * 100
  revealPosition.value = { x, y }
}

const handleMouseEnter = () => {
  isHovering.value = true
}

const handleMouseLeave = () => {
  isHovering.value = false
  revealPosition.value = { x: 50, y: 50 }
}

const colorBorders: Record<string, string> = {
  yellow: 'border-yellow-400',
  cyan: 'border-cyan-400',
  pink: 'border-pink-500'
}

const getColorRgba = (color: string) => {
  const colors: Record<string, string> = {
    yellow: 'rgba(255, 215, 0, 0.4)',
    cyan: 'rgba(0, 217, 255, 0.4)',
    pink: 'rgba(255, 0, 110, 0.4)'
  }
  return colors[color] || colors.yellow
}
</script>

<template>
  <div 
    class="relative rounded-lg md:rounded-xl overflow-hidden group cursor-pointer
           backdrop-blur-md border border-white/20
           bg-gradient-to-br from-white/10 to-white/5
           shadow-xl shadow-black/50
           hover:border-white/30 hover:shadow-2xl hover:shadow-black/60
           transition-all duration-300"
    @mousemove="handleMouseMove"
    @touchmove="handleTouchMove"
    @mouseenter="handleMouseEnter"
    @mouseleave="handleMouseLeave"
  >
    <!-- Image Background -->
    <div class="aspect-[3/4] md:aspect-[3/4] relative bg-gray-900 overflow-hidden">
      <!-- Base Image (sharp, always visible) -->
      <img
        :src="categoria.image"
        :alt="categoria.name"
        class="absolute inset-0 w-full h-full object-cover"
        loading="lazy"
        @error="(e) => handleImageError(e, fallbackImage)"
      />
      
      <!-- Blurred Glassmorphism Layer with Reveal Effect -->
      <div
        class="absolute inset-0 pointer-events-none transition-all duration-200"
        :style="{
          backdropFilter: 'blur(20px)',
          WebkitBackdropFilter: 'blur(20px)',
          background: isHovering
            ? `radial-gradient(circle 180px at ${revealPosition.x}% ${revealPosition.y}%, transparent 30%, rgba(0,0,0,0.7) 70%)`
            : 'rgba(0,0,0,0.4)',
          maskImage: isHovering
            ? `radial-gradient(circle 180px at ${revealPosition.x}% ${revealPosition.y}%, transparent 30%, black 70%)`
            : 'none',
          WebkitMaskImage: isHovering
            ? `radial-gradient(circle 180px at ${revealPosition.x}% ${revealPosition.y}%, transparent 30%, black 70%)`
            : 'none'
        }"
      />
      
      <!-- Grayscale Filter (removes on hover) -->
      <div
        class="absolute inset-0 pointer-events-none transition-opacity duration-500"
        :class="isHovering ? 'opacity-0' : 'opacity-100'"
        :style="{
          filter: 'grayscale(100%)',
          mixBlendMode: 'multiply'
        }"
      />

      <!-- Colored Stripes Overlay -->
      <div
        class="absolute inset-0 backdrop-blur-sm"
        :style="{
          background: `repeating-linear-gradient(
            135deg,
            transparent,
            transparent 40px,
            ${getColorRgba(categoria.color)} 40px,
            ${getColorRgba(categoria.color)} 60px
          )`
        }"
      />

      <!-- Gradient Bottom -->
      <div class="absolute inset-0 bg-gradient-to-t from-black via-transparent to-transparent" />
      
      <!-- Glassmorphism Overlay -->
      <div class="absolute inset-0 bg-gradient-to-br from-white/10 via-transparent to-transparent pointer-events-none" />

      <!-- Content with Glassmorphism Background -->
      <div class="absolute inset-0 flex flex-col justify-center items-center text-white p-3 md:p-6 z-10">
        <div class="backdrop-blur-md bg-black/20 rounded-lg p-2 md:p-4 border border-white/10 text-center w-full">
          <p class="text-xs md:text-sm font-medium mb-1 md:mb-2 tracking-widest opacity-90 drop-shadow-lg">{{ categoria.subtitle }}</p>
          <h3 class="text-3xl md:text-7xl font-black mb-1 md:mb-2 tracking-wider drop-shadow-2xl">
            {{ categoria.name }}
          </h3>
          <p v-if="categoria.ageRange" class="text-2xl md:text-6xl font-bold mb-2 md:mb-3 drop-shadow-lg">{{ categoria.ageRange }}</p>
          <p class="text-xs tracking-widest opacity-90 drop-shadow-lg">{{ categoria.gender }}</p>
        </div>
      </div>

      <!-- Border Effect -->
      <div
        :class="[
          'absolute inset-0 border-2 md:border-4',
          colorBorders[categoria.color],
          'opacity-30 md:opacity-0 group-hover:opacity-100 transition-opacity duration-300'
        ]"
      />
      
      <!-- Hover Effect -->
      <div class="absolute inset-0 bg-white/5 opacity-0 group-hover:opacity-100 transition-opacity duration-300" />
    </div>
  </div>
</template>

