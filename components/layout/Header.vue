<script setup lang="ts">
import { ref } from 'vue'
import { Menu, X, ChevronDown, ExternalLink } from 'lucide-vue-next'

const { menuItems } = useNavigation()
const { qualifier } = useExternalLinks()
const { handleImageError, fallbackImage } = useImageError()

const mobileMenuOpen = ref(false)
const activeDropdown = ref<number | null>(null)

const toggleDropdown = (index: number) => {
  activeDropdown.value = activeDropdown.value === index ? null : index
}
</script>

<template>
  <div>
    <!-- Top Bar -->
    <div class="bg-gradient-to-r from-pink-600 to-purple-700 text-white py-2 text-center text-sm font-medium">
      <span class="animate-pulse">🔥 INSCRIÇÕES ABERTAS • QUALIFIER 2025/26</span>
    </div>

    <!-- Main Header -->
    <header class="bg-black/95 backdrop-blur-sm sticky top-0 z-50 border-b border-gray-800">
      <div class="max-w-7xl mx-auto px-4">
        <div class="flex items-center justify-between h-20">
          <!-- Logo -->
          <NuxtLink to="/" class="flex items-center group">
            <img
              src="/logo_hrz.png"
              alt="Monstar Games"
              class="h-12 w-auto group-hover:scale-105 transition-transform"
              loading="eager"
              @error="(e) => handleImageError(e, fallbackImage)"
            />
          </NuxtLink>

          <!-- Desktop Menu -->
          <nav class="hidden lg:flex items-center gap-1">
            <div
              v-for="(item, idx) in menuItems"
              :key="idx"
              class="relative group"
              @mouseenter="activeDropdown = idx"
              @mouseleave="activeDropdown = null"
            >
              <template v-if="item.items">
                <button class="px-4 py-2 text-white text-sm font-bold hover:text-yellow-400 transition flex items-center gap-1">
                  {{ item.label }}
                  <ChevronDown :size="16" />
                </button>

                <!-- Dropdown -->
                <div
                  :class="[
                    'absolute top-full left-0 bg-gray-900 border border-gray-700 rounded-lg shadow-2xl min-w-[220px] transition-all',
                    activeDropdown === idx ? 'opacity-100 visible translate-y-0' : 'opacity-0 invisible -translate-y-2'
                  ]"
                >
                  <a
                    v-for="(subItem, subIdx) in item.items"
                    :key="subIdx"
                    :href="subItem.href"
                    :target="subItem.external ? '_blank' : '_self'"
                    :rel="subItem.external ? 'noopener noreferrer' : ''"
                    class="block px-4 py-3 text-white text-sm hover:bg-yellow-500 hover:text-black transition first:rounded-t-lg last:rounded-b-lg flex items-center justify-between"
                  >
                    {{ subItem.name }}
                    <ExternalLink v-if="subItem.external" :size="14" />
                  </a>
                </div>
              </template>
              <template v-else>
                <NuxtLink
                  :to="item.href"
                  class="px-4 py-2 text-white text-sm font-bold hover:text-yellow-400 transition"
                >
                  {{ item.label }}
                </NuxtLink>
              </template>
            </div>
          </nav>

          <!-- CTA Button -->
          <a
            :href="qualifier"
            target="_blank"
            rel="noopener noreferrer"
            class="hidden lg:block bg-gradient-to-r from-cyan-500 to-blue-600 text-white px-6 py-2 rounded-lg font-bold hover:shadow-lg hover:shadow-cyan-500/50 transition"
          >
            INSCREVER-SE
          </a>

          <!-- Mobile Menu Button -->
          <button
            @click="mobileMenuOpen = !mobileMenuOpen"
            class="lg:hidden text-white p-2"
          >
            <X v-if="mobileMenuOpen" :size="28" />
            <Menu v-else :size="28" />
          </button>
        </div>
      </div>

      <!-- Mobile Menu -->
      <div v-if="mobileMenuOpen" class="lg:hidden bg-gray-900 border-t border-gray-800">
        <nav class="px-4 py-4 space-y-1">
          <div v-for="(item, idx) in menuItems" :key="idx">
            <template v-if="item.items">
              <button
                @click="toggleDropdown(idx)"
                class="w-full text-left px-4 py-3 text-white font-bold hover:bg-gray-800 rounded flex items-center justify-between"
              >
                {{ item.label }}
                <ChevronDown
                  :size="18"
                  :class="['transition-transform', activeDropdown === idx ? 'rotate-180' : '']"
                />
              </button>

              <div v-if="activeDropdown === idx" class="ml-4 mt-1 space-y-1">
                <a
                  v-for="(subItem, subIdx) in item.items"
                  :key="subIdx"
                  :href="subItem.href"
                  :target="subItem.external ? '_blank' : '_self'"
                  class="block px-4 py-2 text-gray-300 text-sm hover:text-yellow-400 hover:bg-gray-800 rounded"
                >
                  {{ subItem.name }}
                </a>
              </div>
            </template>
            <template v-else>
              <NuxtLink
                :to="item.href"
                class="block px-4 py-3 text-white font-bold hover:bg-gray-800 rounded"
              >
                {{ item.label }}
              </NuxtLink>
            </template>
          </div>

          <a
            :href="qualifier"
            target="_blank"
            rel="noopener noreferrer"
            class="block mt-4 bg-cyan-500 text-white text-center px-6 py-3 rounded-lg font-bold"
          >
            INSCREVER-SE
          </a>
        </nav>
      </div>
    </header>
  </div>
</template>

