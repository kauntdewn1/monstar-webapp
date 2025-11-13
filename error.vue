<script setup lang="ts">
import { AlertCircle, Home, RefreshCw } from 'lucide-vue-next'

const props = defineProps<{
  error: {
    statusCode?: number
    statusMessage?: string
    message?: string
  }
}>()

const handleError = () => clearError({ redirect: '/' })

const statusMessages: Record<number, string> = {
  404: 'Página não encontrada',
  500: 'Erro interno do servidor',
  403: 'Acesso negado',
  503: 'Serviço indisponível'
}

const errorTitle = computed(() => {
  if (props.error.statusCode && statusMessages[props.error.statusCode]) {
    return statusMessages[props.error.statusCode]
  }
  return props.error.statusMessage || 'Ocorreu um erro'
})

const errorMessage = computed(() => {
  if (props.error.statusCode === 404) {
    return 'A página que você está procurando não existe ou foi movida.'
  }
  if (props.error.statusCode === 500) {
    return 'Algo deu errado no servidor. Nossa equipe foi notificada.'
  }
  return props.error.message || 'Tente novamente mais tarde ou entre em contato conosco.'
})
</script>

<template>
  <div class="min-h-screen bg-black text-white flex items-center justify-center px-4">
    <div class="max-w-2xl w-full text-center">
      <!-- Error Icon -->
      <div class="mb-8 flex justify-center">
        <div class="w-32 h-32 rounded-full bg-red-500/20 flex items-center justify-center">
          <AlertCircle :size="64" class="text-red-500" />
        </div>
      </div>

      <!-- Error Code -->
      <h1 v-if="error.statusCode" class="text-9xl font-black mb-4 text-transparent bg-clip-text bg-gradient-to-r from-red-500 to-orange-500">
        {{ error.statusCode }}
      </h1>

      <!-- Error Title -->
      <h2 class="text-4xl font-bold mb-6">
        {{ errorTitle }}
      </h2>

      <!-- Error Message -->
      <p class="text-xl text-gray-400 mb-8">
        {{ errorMessage }}
      </p>

      <!-- Actions -->
      <div class="flex flex-col sm:flex-row gap-4 justify-center">
        <button
          @click="handleError"
          class="bg-cyan-500 hover:bg-cyan-600 px-8 py-4 rounded-lg text-lg font-bold transition-all transform hover:scale-105 flex items-center justify-center gap-2"
        >
          <Home :size="20" />
          Voltar ao Início
        </button>
        <button
          @click="$router.go(-1)"
          class="bg-gray-800 hover:bg-gray-700 px-8 py-4 rounded-lg text-lg font-bold transition-all flex items-center justify-center gap-2"
        >
          <RefreshCw :size="20" />
          Voltar
        </button>
      </div>

      <!-- Contact Info -->
      <div class="mt-12 pt-8 border-t border-gray-800">
        <p class="text-gray-500 mb-2">Precisa de ajuda?</p>
        <NuxtLink
          to="/contato"
          class="text-cyan-500 hover:text-cyan-400 transition underline"
        >
          Entre em contato conosco
        </NuxtLink>
      </div>
    </div>
  </div>
</template>

