<script setup lang="ts">
useHead({
  title: 'Regulamento | Monstar Games',
  meta: [
    { name: 'description', content: 'Regulamento completo da competição Monstar Games 2025/26 em Goiânia. Normas, regras e diretrizes para participantes.' },
    { property: 'og:title', content: 'Regulamento | Monstar Games' },
    { property: 'og:description', content: 'Regulamento completo da competição Monstar Games 2025/26' }
  ]
})
</script>

<template>
  <div class="bg-black min-h-screen py-20 px-4">
    <div class="max-w-4xl mx-auto text-white">
      <h1 class="text-5xl font-black mb-8 text-center">REGULAMENTO</h1>
      
      <div class="prose prose-invert max-w-none">
        <div class="bg-yellow-500/10 border border-yellow-500/30 rounded-lg p-6 mb-8">
          <p class="text-lg text-yellow-300 text-center">
            ⚠️ O regulamento completo estará disponível em breve. 
            <br />
            <span class="text-sm text-gray-400 mt-2 block">
              Para mais informações, entre em contato através do formulário de contato.
            </span>
          </p>
        </div>
        
        <div class="text-center">
          <NuxtLink
            to="/contato"
            class="inline-block bg-cyan-500 hover:bg-cyan-600 text-white px-8 py-3 rounded-lg font-bold transition"
          >
            Entrar em Contato
          </NuxtLink>
        </div>
      </div>
    </div>
  </div>
</template>

