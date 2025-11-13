<script setup lang="ts">
useHead({
  title: 'Monstar Games 2025/26 | Goiânia',
  meta: [
    { name: 'description', content: 'Competição de Fitness em Goiânia - Monstar Games. Inscrições abertas para Qualifier 2025/26. Standards, categorias e regulamento completo.' }
  ]
})

const { modalidades } = useModalidades()
const { categorias } = useCategories()
</script>

<template>
  <div class="bg-black min-h-screen">
    <!-- Hero -->
    <HomeHero />

    <!-- Modalidades Section -->
    <section class="py-8 md:py-20 px-4 bg-gradient-to-b from-black to-gray-900">
      <h2 class="text-2xl md:text-5xl font-bold text-white text-center mb-6 md:mb-16">
        MODALIDADES MONSTAR
      </h2>

      <div class="max-w-7xl mx-auto grid grid-cols-2 md:grid-cols-2 lg:grid-cols-4 gap-3 md:gap-6">
        <SharedModalidadeCard
          v-for="mod in modalidades"
          :key="mod.id"
          :modalidade="mod"
        />
      </div>
    </section>

    <!-- Categorias Section -->
    <section class="py-8 md:py-20 px-4 bg-gray-900">
      <h2 class="text-2xl md:text-5xl font-bold text-white text-center mb-4 md:mb-4">
        CATEGORIAS QUALIFIER
      </h2>

      <div class="max-w-7xl mx-auto">
        <div class="grid grid-cols-2 md:grid-cols-2 lg:grid-cols-4 gap-3 md:gap-6 mt-6 md:mt-12">
          <SharedCategoriaCard
            v-for="cat in categorias"
            :key="cat.id"
            :categoria="cat"
          />
        </div>
      </div>
    </section>

    <!-- Local Festival -->
    <HomeLocalFestival />
  </div>
</template>

