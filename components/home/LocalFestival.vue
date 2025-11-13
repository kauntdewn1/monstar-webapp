<script setup lang="ts">
import { MapPin } from 'lucide-vue-next'

const { getImage } = useImage()
const { handleImageError, fallbackImage } = useImageError()
</script>

<template>
  <section class="bg-gradient-to-r from-pink-600 to-purple-700 py-20 px-4">
    <div class="max-w-7xl mx-auto">
      <h2 class="text-5xl font-bold text-white text-center mb-12">
        LOCAL FESTIVAL
      </h2>

      <div class="grid md:grid-cols-2 gap-8 items-center">
        <!-- Image -->
        <div class="rounded-lg overflow-hidden shadow-2xl">
          <img
            :src="getImage('outros/FOTO-FERREIRA.png')"
            alt="SESI Clube Ferreira Pacheco"
            class="w-full h-auto"
            loading="lazy"
            @error="(e) => handleImageError(e, fallbackImage)"
          />
        </div>

        <!-- Info -->
        <div class="text-white">
          <h3 class="text-3xl font-bold mb-4">SESI Clube Ferreira Pacheco</h3>
          <p class="text-lg mb-4 opacity-90">
            Clube Antônio Ferreira Pacheco - Goiânia - GO
          </p>

          <p class="mb-4 leading-relaxed">
            O Clube do trabalhador foi inaugurado no dia 24 de março de 1968.
            O nome escolhido é uma homenagem ao então presidente da Federação
            das Indústrias, Antônio Ferreira Pacheco.
          </p>

          <p class="mb-6 leading-relaxed">
            Em sua estrutura física, o Clube possui parque aquático com seis piscinas,
            quatro quadras polivalentes cobertas, duas quadras de tênis de campo,
            três campos de futebol gramado, sendo um oficial, salão de jogos (bilhar),
            sauna, academia de musculação, churrascaria, alojamentos, salão de festas,
            lago com pedalinhos e pesque pague.
          </p>

          <a
            href="https://maps.google.com/?q=Avenida+João+Leite+1013+Santa+Genoveva+Goiânia"
            target="_blank"
            rel="noopener noreferrer"
            class="inline-flex items-center gap-2 bg-white text-purple-700 px-6 py-3 rounded-lg font-bold hover:bg-opacity-90 transition"
          >
            <MapPin :size="20" />
            Ver no Mapa
          </a>
        </div>
      </div>
    </div>
  </section>
</template>

