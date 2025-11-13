<script setup lang="ts">
useHead({
  title: 'Pré-requisitos | Monstar Games',
  meta: [
    { name: 'description', content: 'Pré-requisitos para participar do Monstar Games 2025/26. Requisitos de idade, experiência e categorias disponíveis.' },
    { property: 'og:title', content: 'Pré-requisitos | Monstar Games' },
    { property: 'og:description', content: 'Pré-requisitos para participar do Monstar Games 2025/26' }
  ]
})
</script>

<template>
  <div class="bg-black min-h-screen py-20 px-4">
    <div class="max-w-4xl mx-auto text-white">
      <h1 class="text-5xl font-black mb-8 text-center">PRÉ-REQUISITOS</h1>
      
      <div class="prose prose-invert max-w-none">
        <div class="bg-yellow-500/10 border border-yellow-500/30 rounded-lg p-6 mb-8">
          <p class="text-lg text-yellow-300 text-center">
            ⚠️ Os pré-requisitos completos estarão disponíveis em breve.
            <br />
            <span class="text-sm text-gray-400 mt-2 block">
              Consulte a página de <NuxtLink to="/standards" class="text-yellow-400 hover:underline">Standards</NuxtLink> para informações sobre categorias e cargas de trabalho.
            </span>
          </p>
        </div>
        
        <div class="text-center space-y-4">
          <NuxtLink
            to="/standards"
            class="inline-block bg-cyan-500 hover:bg-cyan-600 text-white px-8 py-3 rounded-lg font-bold transition mr-4"
          >
            Ver Standards
          </NuxtLink>
          <NuxtLink
            to="/contato"
            class="inline-block bg-transparent border-2 border-cyan-500 text-cyan-500 hover:bg-cyan-500 hover:text-white px-8 py-3 rounded-lg font-bold transition"
          >
            Entrar em Contato
          </NuxtLink>
        </div>
      </div>
    </div>
  </div>
</template>

