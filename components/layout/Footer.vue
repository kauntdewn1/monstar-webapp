<script setup lang="ts">
const { patrocinadores } = usePatrocinadores()
const { handleImageError, fallbackImage } = useImageError()
</script>

<template>
  <footer class="bg-black text-white py-12 px-4 border-t border-gray-800">
    <div class="max-w-7xl mx-auto">
      <!-- Patrocinadores Section -->
      <section id="patrocinadores" class="mb-12">
        <h2 class="text-4xl font-bold text-center mb-4">
          APRESENTADOR OFICIAL
        </h2>
        <p class="text-xl text-center text-yellow-400 mb-8">
          PATROCINADORES OURO
        </p>

        <div class="grid grid-cols-2 md:grid-cols-4 gap-6 md:gap-8 items-center">
          <div
            v-for="(sponsor, idx) in patrocinadores"
            :key="idx"
            class="bg-white p-4 md:p-6 rounded-lg flex items-center justify-center hover:scale-105 transition-transform h-24 md:h-32"
          >
            <img
              :src="sponsor.logo"
              :alt="sponsor.name"
              class="max-w-full max-h-full w-auto h-full object-contain brightness-0 invert transition-all"
              loading="lazy"
              @error="(e) => handleImageError(e, fallbackImage)"
            />
          </div>
        </div>
      </section>

      <!-- Footer Info -->
      <div class="text-center">
        <div class="mb-6">
          <svg viewBox="0 0 60 60" class="w-16 h-16 mx-auto mb-4">
            <polygon
              points="30,5 36,24 54,24 39,36 45,54 30,42 15,54 21,36 6,24 24,24"
              fill="#FFD700"
            />
          </svg>
          <p class="text-2xl font-bold">MONSTAR GAMES</p>
        </div>

        <p class="text-gray-400 mb-4">
          © 2025 Monstar Games. Todos os direitos reservados.
        </p>

        <div class="flex justify-center gap-6">
          <a 
            href="https://www.instagram.com/monstargames/" 
            target="_blank"
            rel="noopener noreferrer"
            class="text-gray-400 hover:text-white transition"
          >
            Instagram
          </a>
          <NuxtLink to="/contato" class="text-gray-400 hover:text-white transition">Contato</NuxtLink>
        </div>
      </div>
    </div>
  </footer>
</template>

