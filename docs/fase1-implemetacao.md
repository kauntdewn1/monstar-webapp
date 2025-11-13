### Fase 1: MVP

- [ ]  Setup Nuxt + Tailwind
- [ ]  Home + Hero section
- [ ]  Grid de modalidades
- [ ]  Páginas estáticas (Regulamento, Pré-requisitos)
- [ ]  Footer com patrocinadores
- [ ]  Deploy Vercel

criar helper que facilite migração futura:


// composables/useImage.ts
export const useImage = () => {
const config = useRuntimeConfig()
const useCloudinary = false // ← Toggle fácil no futuro

const getImage = (path: string, transforms?: string) => {
if (useCloudinary) {
return `https://res.cloudinary.com/${config.public.cloudName}/image/upload/${transforms}/${path}`
}
return `/assets/images/${path}`
}

return { getImage }
}

Como já até removemos as imagens do projeto, considerar que além de trazer a imagem necessaria, precisamos alterar as extensões das imagens que usei no código abaixo:

---

## 📐 Estrutura Nuxt Proposta (Baseada no seu conteúdo)

```

monstar-nuxt/
├── public/
│   └── assets/
│       ├── images/              # (suas 545 imagens já migradas)
│       ├── fonts/
│       └── icons/
│
├── pages/
│   ├── index.vue                # Home (hero + grid modalidades)
│   ├── loja.vue                 # Futura loja (começar simples)
│   ├── carrinho.vue             # Carrinho (v2)
│   ├── contato.vue              # Formulário simples
│   │
│   ├── qualifier/
│   │   ├── index.vue            # Inscrições Qualifier
│   │   └── leaderboard.vue      # Ranking
│   │
│   ├── times/
│   │   └── index.vue            # Inscrições de times
│   │
│   ├── categorias/
│   │   ├── teens.vue
│   │   ├── elite.vue
│   │   ├── master.vue
│   │   ├── amador.vue
│   │   └── scaled.vue
│   │
│   ├── modalidades/
│   │   ├── fitness-race.vue
│   │   ├── run.vue
│   │   ├── weightlifting.vue
│   │   └── beach-tennis.vue     # (se ainda existe)
│   │
│   ├── eventos/
│   │   └── [slug].vue           # Dinâmico pra eventos passados
│   │
│   ├── regulamento.vue
│   ├── pre-requisitos.vue
│   ├── standards.vue
│   ├── workouts.vue
│   ├── valores.vue
│   ├── midia-oficial.vue
│   ├── links.vue
│   │
│   └── atleta/
│       ├── painel.vue           # Embed Digital Score?
│       └── minha-conta.vue
│
├── components/
│   ├── layout/
│   │   ├── Header.vue           # Menu principal
│   │   ├── Footer.vue           # Patrocinadores
│   │   └── MobileMenu.vue
│   │
│   ├── home/
│   │   ├── Hero.vue             # Seção principal
│   │   ├── ModalidadesGrid.vue
│   │   ├── CategoriasSlider.vue
│   │   ├── LocalFestival.vue    # Seção SESI
│   │   └── PatrocinadoresOuro.vue
│   │
│   ├── shared/
│   │   ├── ModalidadeCard.vue
│   │   ├── CategoriaCard.vue
│   │   ├── EventCard.vue
│   │   ├── CTAButton.vue
│   │   ├── MapEmbed.vue
│   │   └── VideoEmbed.vue       # (pro briefing de prova)
│   │
│   └── loja/                    # (futuro)
│       ├── ProductCard.vue
│       └── LoteTimer.vue        # Countdown de lote
│
├── composables/
│   ├── useImage.ts              # Helper de imagens
│   ├── useCategories.ts         # Dados das categorias
│   ├── useModalidades.ts        # Dados das modalidades
│   └── usePatrocinadores.ts     # Lista de sponsors
│
├── assets/
│   └── css/
│       └── main.css             # Estilos globais (se precisar)
│
├── types/
│   ├── categoria.ts
│   ├── modalidade.ts
│   └── evento.ts
│
└── nuxt.config.ts



🎨  Design 


// tailwind.config.ts
export default {
theme: {
extend: {
colors: {
monstar: {
gold: '#FFD700',      // Dourado da estrela
pink: '#FF006E',      // Rosa vibrante
cyan: '#00D9FF',      // Ciano das modalidades
lime: '#BFFF00',      // Verde limão
orange: '#FF8C00',    // Laranja
red: '#FF0000',       // Vermelho
purple: '#9D4EDD',    // Roxo
dark: '#0A0A0A',      // Preto do fundo
}
},
fontFamily: {
'heading': ['Montserrat', 'sans-serif'], // Assumindo
'body': ['Inter', 'sans-serif']
}
}
}
}


**Componentes Base:**


import React, { useState } from 'react';
import { Play, MapPin, Calendar, Users, Trophy, ExternalLink } from 'lucide-react';

// Dados mockados (substituir por composables depois)
const modalidades = [
{
id: 1,
title: 'WORKOUTS\nQUALIFIER',
subtitle: 'Monstar Games',
image: '/assets/images/backgrounds/BG-01.jpg',
color: 'from-lime-400 to-lime-600',
status: 'CLIQUE AQUI!',
link: '/qualifier',
available: true
},
{
id: 2,
title: 'INSCRIÇÕES\nTIMES',
subtitle: 'Monstar Games',
image: '/assets/images/produtos/INICIANTES.jpg',
color: 'from-yellow-400 to-yellow-600',
status: 'CLIQUE AQUI!',
link: '/times',
available: true
},
{
id: 3,
title: 'LEADERBOARD\nQUALIFIER',
subtitle: 'Ranking Oficial',
image: '/assets/images/produtos/ELITE.jpg',
color: 'from-pink-500 to-pink-700',
status: 'EM BREVE!',
link: '/leaderboard',
available: false
},
{
id: 4,
title: 'HEAD COACH\nSOLIDÁRIO',
subtitle: 'Monstar Affiliate',
image: '/assets/images/backgrounds/WEST.jpg',
color: 'from-orange-400 to-orange-600',
status: 'EM BREVE!',
link: '#',
available: false
}
];

const categorias = [
{
id: 1,
name: 'TEENS',
subtitle: 'CATEGORIA',
ageRange: '-17',
gender: 'MASCULINO | FEMININO',
image: '/assets/images/produtos/TEENS.jpg',
color: 'yellow'
},
{
id: 2,
name: 'AMADOR',
subtitle: 'CATEGORIA',
ageRange: '',
gender: 'MASCULINO | FEMININO',
image: '/assets/images/produtos/AMADOR.jpg',
color: 'cyan'
},
{
id: 3,
name: 'SCALED',
subtitle: 'CATEGORIA',
ageRange: '',
gender: 'MASCULINO | FEMININO',
image: '/assets/images/backgrounds/SCALED.jpg',
color: 'pink'
},
{
id: 4,
name: 'ELITE',
subtitle: 'CATEGORIA',
ageRange: '',
gender: 'MASCULINO | FEMININO',
image: '/assets/images/produtos/ELITE.jpg',
color: 'yellow'
}
];

const patrocinadores = [
{ name: 'BSCross', logo: '/assets/images/logos/AUDAX.png', tier: 'ouro' },
{ name: 'Linq Telecom', logo: '/assets/images/logos/Linq.png', tier: 'ouro' },
{ name: 'SESI', logo: '/assets/images/logos/Sesi.png', tier: 'principal' },
{ name: 'Pood', logo: '/assets/images/logos/Pood.png', tier: 'prata' }
];

// Hero Component
const Hero = () => {
return (
<div className="relative h-screen bg-black overflow-hidden">
{/* Background Image */}
<div className="absolute inset-0">
<img
src="/assets/images/backgrounds/BG-01.jpg"
alt="Monstar Games Background"
className="w-full h-full object-cover opacity-40"
/>
<div className="absolute inset-0 bg-gradient-to-b from-black/60 via-transparent to-black/80" />
</div>

```
  {/* Content */}
  <div className="relative z-10 flex flex-col items-center justify-center h-full text-white px-4">
    {/* Logo */}
    <div className="mb-8 animate-fade-in">
      <div className="w-64 h-64 relative">
        <svg viewBox="0 0 200 200" className="w-full h-full">
          <defs>
            <linearGradient id="starGradient" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="0%" stopColor="#FFD700" />
              <stop offset="100%" stopColor="#FFA500" />
            </linearGradient>
          </defs>
          <polygon
            points="100,20 120,80 180,80 130,120 150,180 100,140 50,180 70,120 20,80 80,80"
            fill="url(#starGradient)"
            stroke="#000"
            strokeWidth="3"
          />
          <text x="100" y="110" textAnchor="middle" fill="#000" fontSize="48" fontWeight="bold" fontFamily="Arial">M</text>
        </svg>
      </div>
      <h1 className="text-4xl font-bold text-center mt-4 tracking-wider">
        MONSTAR<br/>
        <span className="text-xl font-normal">GAMES</span>
      </h1>
    </div>

    {/* Main Title */}
    <h2 className="text-5xl md:text-7xl font-black mb-4 text-center leading-tight">
      INSCRIÇÕES QUALIFIER
    </h2>

    {/* Subtitle */}
    <p className="text-xl md:text-2xl mb-8 text-yellow-400">
      Monstar Games 2025/26 | Edição Goiânia
    </p>

    {/* CTA Button */}
    <a
      href="<https://registration.digitalscore.com.br/qualifier2026/home>"
      target="_blank"
      rel="noopener noreferrer"
      className="bg-cyan-500 hover:bg-cyan-600 px-12 py-5 rounded-lg text-xl font-bold transition-all transform hover:scale-105 shadow-2xl flex items-center gap-3"
    >
      CLIQUE AQUI!
      <ExternalLink size={24} />
    </a>

    {/* Scroll Indicator */}
    <div className="absolute bottom-10 animate-bounce">
      <div className="w-8 h-12 border-2 border-white rounded-full flex items-start justify-center p-2">
        <div className="w-1 h-3 bg-white rounded-full" />
      </div>
    </div>
  </div>

  {/* Animated Ticker */}
  <div className="absolute bottom-0 w-full bg-gradient-to-r from-pink-600 to-purple-600 py-3 overflow-hidden">
    <div className="animate-marquee whitespace-nowrap text-white font-bold text-lg">
      <span className="mx-8">INSCRIÇÕES QUALIFIER • TEMPORADA 2026</span>
      <span className="mx-8">INSCRIÇÕES TIMES</span>
      <span className="mx-8">STANDARDS 2026</span>
      <span className="mx-8">INSCRIÇÕES QUALIFIER • TEMPORADA 2026</span>
      <span className="mx-8">INSCRIÇÕES TIMES</span>
      <span className="mx-8">STANDARDS 2026</span>
    </div>
  </div>

  <style jsx>{`
    @keyframes marquee {
      0% { transform: translateX(0%); }
      100% { transform: translateX(-50%); }
    }
    .animate-marquee {
      display: inline-block;
      animation: marquee 30s linear infinite;
    }
    @keyframes fade-in {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .animate-fade-in {
      animation: fade-in 1s ease-out;
    }
  `}</style>
</div>

```

);
};

// Modalidade Card Component
const ModalidadeCard = ({ modalidade }) => {
const colorMap = {
'from-lime-400 to-lime-600': 'bg-gradient-to-br from-lime-400 to-lime-600',
'from-yellow-400 to-yellow-600': 'bg-gradient-to-br from-yellow-400 to-yellow-600',
'from-pink-500 to-pink-700': 'bg-gradient-to-br from-pink-500 to-pink-700',
'from-orange-400 to-orange-600': 'bg-gradient-to-br from-orange-400 to-orange-600'
};

return (
<a
href={modalidade.link}
className={`group relative overflow-hidden rounded-xl aspect-square cursor-pointer ${!modalidade.available && 'pointer-events-none'}`}
>
{/* Background Pattern */}
<div className="absolute inset-0 bg-black">
<div className="absolute inset-0 opacity-20"
style={{
backgroundImage: 'repeating-linear-gradient(45deg, transparent, transparent 10px, rgba(255,255,255,.05) 10px, rgba(255,255,255,.05) 20px)'
}}
/>
</div>

```
  {/* Gradient Overlay */}
  <div className={`absolute inset-0 ${colorMap[modalidade.color]} opacity-70 group-hover:opacity-80 transition-opacity`} />

  {/* Logo Watermark */}
  <div className="absolute top-6 left-6 opacity-80">
    <svg viewBox="0 0 60 60" className="w-20 h-20">
      <polygon
        points="30,5 36,24 54,24 39,36 45,54 30,42 15,54 21,36 6,24 24,24"
        fill="none"
        stroke="white"
        strokeWidth="2"
      />
      <text x="30" y="35" textAnchor="middle" fill="white" fontSize="18" fontWeight="bold">M</text>
    </svg>
  </div>

  {/* Content */}
  <div className="absolute inset-0 flex flex-col justify-end p-8 text-white">
    <p className="text-sm font-medium mb-2 opacity-90">{modalidade.subtitle}</p>
    <h3 className="text-4xl font-black mb-4 leading-tight whitespace-pre-line transform group-hover:translate-y-[-8px] transition-transform">
      {modalidade.title}
    </h3>
    <button
      className={`${modalidade.available ? 'bg-white text-black hover:bg-opacity-90' : 'bg-gray-400 text-gray-700'} px-8 py-3 rounded-lg font-bold self-start transition-all transform group-hover:scale-105 shadow-lg`}
    >
      {modalidade.status}
    </button>
  </div>

  {/* Hover Effect */}
  <div className="absolute inset-0 bg-black opacity-0 group-hover:opacity-10 transition-opacity" />
</a>

```

);
};

// Categoria Card Component
const CategoriaCard = ({ categoria }) => {
const colorBorders = {
yellow: 'border-yellow-400',
cyan: 'border-cyan-400',
pink: 'border-pink-500'
};

return (
<div className="relative rounded-xl overflow-hidden group cursor-pointer">
{/* Image Background */}
<div className="aspect-[3/4] relative bg-gray-900">
<img
src={categoria.image}
alt={[categoria.name](http://categoria.name/)}
className="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500"
/>

```
    {/* Colored Stripes Overlay */}
    <div className="absolute inset-0" style={{
      background: `repeating-linear-gradient(
        135deg,
        transparent,
        transparent 40px,
        ${categoria.color === 'yellow' ? 'rgba(255, 215, 0, 0.4)' :
          categoria.color === 'cyan' ? 'rgba(0, 217, 255, 0.4)' :
          'rgba(255, 0, 110, 0.4)'} 40px,
        ${categoria.color === 'yellow' ? 'rgba(255, 215, 0, 0.4)' :
          categoria.color === 'cyan' ? 'rgba(0, 217, 255, 0.4)' :
          'rgba(255, 0, 110, 0.4)'} 60px
      )`
    }} />

    {/* Gradient Bottom */}
    <div className="absolute inset-0 bg-gradient-to-t from-black via-transparent to-transparent" />

    {/* Content */}
    <div className="absolute inset-0 flex flex-col justify-center items-center text-white p-6">
      <p className="text-sm font-medium mb-2 tracking-widest">{categoria.subtitle}</p>
      <h3 className="text-7xl font-black mb-2 tracking-wider drop-shadow-lg">
        {categoria.name}
      </h3>
      {categoria.ageRange && (
        <p className="text-6xl font-bold mb-3">{categoria.ageRange}</p>
      )}
      <p className="text-xs tracking-widest opacity-90">{categoria.gender}</p>
    </div>

    {/* Border Effect */}
    <div className={`absolute inset-0 border-4 ${colorBorders[categoria.color]} opacity-0 group-hover:opacity-100 transition-opacity`} />
  </div>
</div>

```

);
};

// Patrocinadores Section
const PatrocinadoresSection = () => {
return (
<section className="bg-gradient-to-b from-gray-900 to-black py-20 px-4">
<div className="max-w-7xl mx-auto">
<h2 className="text-4xl font-bold text-center text-white mb-4">
APRESENTADOR OFICIAL
</h2>
<p className="text-xl text-center text-yellow-400 mb-12">
PATROCINADORES OURO
</p>

```
    <div className="grid grid-cols-2 md:grid-cols-4 gap-8 items-center">
      {patrocinadores.map((sponsor, idx) => (
        <div
          key={idx}
          className="bg-white p-6 rounded-lg flex items-center justify-center hover:scale-105 transition-transform"
        >
          <img
            src={sponsor.logo}
            alt={sponsor.name}
            className="max-w-full max-h-24 object-contain filter grayscale hover:grayscale-0 transition-all"
          />
        </div>
      ))}
    </div>
  </div>
</section>

```

);
};

// Local Festival Section
const LocalFestivalSection = () => {
return (
<section className="bg-gradient-to-r from-pink-600 to-purple-700 py-20 px-4">
<div className="max-w-7xl mx-auto">
<h2 className="text-5xl font-bold text-white text-center mb-12">
LOCAL FESTIVAL
</h2>

```
    <div className="grid md:grid-cols-2 gap-8 items-center">
      {/* Image */}
      <div className="rounded-lg overflow-hidden shadow-2xl">
        <img
          src="/assets/images/eventos/sesi-clube.jpg"
          alt="SESI Clube Ferreira Pacheco"
          className="w-full h-auto"
        />
      </div>

      {/* Info */}
      <div className="text-white">
        <h3 className="text-3xl font-bold mb-4">SESI Clube Ferreira Pacheco</h3>
        <p className="text-lg mb-4 opacity-90">
          Clube Antônio Ferreira Pacheco - Goiânia - GO
        </p>

        <p className="mb-4 leading-relaxed">
          O Clube do trabalhador foi inaugurado no dia 24 de março de 1968.
          O nome escolhido é uma homenagem ao então presidente da Federação
          das Indústrias, Antônio Ferreira Pacheco.
        </p>

        <p className="mb-6 leading-relaxed">
          Em sua estrutura física, o Clube possui parque aquático com seis piscinas,
          quatro quadras polivalentes cobertas, duas quadras de tênis de campo,
          três campos de futebol gramado, sendo um oficial, salão de jogos (bilhar),
          sauna, academia de musculação, churrascaria, alojamentos, salão de festas,
          lago com pedalinhos e pesque pague.
        </p>

        <a
          href="<https://maps.google.com/?q=Avenida+João+Leite+1013+Santa+Genoveva+Goiânia>"
          target="_blank"
          rel="noopener noreferrer"
          className="inline-flex items-center gap-2 bg-white text-purple-700 px-6 py-3 rounded-lg font-bold hover:bg-opacity-90 transition"
        >
          <MapPin size={20} />
          Ver no Mapa
        </a>
      </div>
    </div>
  </div>
</section>

```

);
};

// Main App Component
const MonstarApp = () => {
return (
<div className="bg-black min-h-screen">
{/* Hero */}
<Hero />

```
  {/* Modalidades Section */}
  <section className="py-20 px-4 bg-gradient-to-b from-black to-gray-900">
    <h2 className="text-5xl font-bold text-white text-center mb-16">
      MODALIDADES MONSTAR
    </h2>

    <div className="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
      {modalidades.map(mod => (
        <ModalidadeCard key={mod.id} modalidade={mod} />
      ))}
    </div>
  </section>

  {/* Categorias Section */}
  <section className="py-20 px-4 bg-gray-900">
    <h2 className="text-5xl font-bold text-white text-center mb-4">
      CATEGORIAS QUALIFIER
    </h2>

    <div className="max-w-7xl mx-auto">
      {/* Slider simulado (depois implementar com Swiper ou Embla) */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mt-12">
        {categorias.map(cat => (
          <CategoriaCard key={cat.id} categoria={cat} />
        ))}
      </div>
    </div>
  </section>

  {/* Local Festival */}
  <LocalFestivalSection />

  {/* Patrocinadores */}
  <PatrocinadoresSection />

  {/* Footer Simples */}
  <footer className="bg-black text-white py-12 px-4 border-t border-gray-800">
    <div className="max-w-7xl mx-auto text-center">
      <div className="mb-6">
        <svg viewBox="0 0 60 60" className="w-16 h-16 mx-auto mb-4">
          <polygon
            points="30,5 36,24 54,24 39,36 45,54 30,42 15,54 21,36 6,24 24,24"
            fill="#FFD700"
          />
        </svg>
        <p className="text-2xl font-bold">MONSTAR GAMES</p>
      </div>

      <p className="text-gray-400 mb-4">
        © 2025 Monstar Games. Todos os direitos reservados.
      </p>

      <div className="flex justify-center gap-6">
        <a href="#" className="text-gray-400 hover:text-white transition">Instagram</a>
        <a href="#" className="text-gray-400 hover:text-white transition">Facebook</a>
        <a href="/contato" className="text-gray-400 hover:text-white transition">Contato</a>
      </div>
    </div>
  </footer>
</div>

```

);
};

export default MonstarApp;



## 🚀 agora imediato

### 1. **Setup Inicial**

bash

`npx nuxi@latest init monstar-nuxt
cd monstar-nuxt
npm install

*# Instalar dependências*
npm install @nuxtjs/tailwindcss
npm install lucide-vue-next  *# Ícones*
npm install swiper           *# Carrossel de categorias*`

### 3. **Configurar Nuxt**

typescript

`*// nuxt.config.ts*
export default defineNuxtConfig({
  modules: ['@nuxtjs/tailwindcss'],
  
  app: {
    head: {
      title: 'Monstar Games 2025/26 | Goiânia',
      meta: [
        { name: 'description', content: 'Competição de Fitness em Goiânia' }
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/assets/icons/favicon.ico' }
      ]
    }
  },

  css: ['~/assets/css/main.css']
})`

### 4. **Criar Composables** (15 min)

typescript

`*// composables/useModalidades.ts*
export const useModalidades = () => {
  const modalidades = [
    {
      id: 1,
      title: 'WORKOUTS\nQUALIFIER',
      image: 'backgrounds/BG-01.jpg',
      color: 'from-lime-400 to-lime-600',
      link: 'https://registration.digitalscore.com.br/qualifier2026/home'
    },
    *// ... resto*
  ]

  return { modalidades }
}`

### 5. **Migrar Links Externos** (importante!)

typescript

`*// composables/useExternalLinks.ts*
export const useExternalLinks = () => {
  return {
    qualifier: 'https://registration.digitalscore.com.br/qualifier2026/home',
    leaderboard: 'https://panel.digitalscore.com.br/',
    judges: 'https://www.e-inscricao.com/arbitrosdigitalscore/monstargames2023',
    staffForm: 'https://docs.google.com/forms/d/e/1FAIpQLSceP-CIW9lY24rUg-Dsd11WJk0vdSBnsBMWgE8TdBtPlJ47ug/viewform'
  }
}`

---

## 

## 💡 Dicas de Otimização

### 1. **Lazy Loading de Imagens**

vue

`<img 
  :src="`/assets/images/${path}`"
  loading="lazy"
  decoding="async"
/>`

### 2. **Preload de Fontes**

typescript

`*// nuxt.config.ts*
app: {
  head: {
    link: [
      { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
      { 
        rel: 'stylesheet', 
        href: 'https://fonts.googleapis.com/css2?family=Montserrat:wght@700;900&display=swap' 
      }
    ]
  }
}`


então:

## 🛠️ **Para Usar no Nuxt**

### 1. Criar composable do Header

typescript

`*// composables/useNavigation.ts*
export const useNavigation = () => {
  const menuItems = [
    {
      label: 'QUALIFIER',
      items: [
        { name: 'Inscrições', href: 'https://registration.digitalscore.com.br/qualifier2026/home', external: true },
        { name: 'Leaderboard', href: '/leaderboard' },
        { name: 'Painel do Atleta', href: 'https://panel.digitalscore.com.br/', external: true },
        { name: 'Workouts', href: '/workouts' }
      ]
    },
    *// ... resto*
  ]

  return { menuItems }
}`

### 2. Criar componente Header

vue

`<!-- components/layout/Header.vue -->
<script setup>
import { ref } from 'vue'
import { Menu, X, ChevronDown } from 'lucide-vue-next'

const { menuItems } = useNavigation()
const mobileMenuOpen = ref(false)
const activeDropdown = ref(null)
</script>

<template>
  <!-- Cole o JSX convertido pra Vue aqui -->
</template>`

### 3. Usar no Layout

vue

`<!-- layouts/default.vue -->
<template>
  <div>
    <Header />
    <slot />
    <Footer />
  </div>
</template>`

### 4. Página Standards

vue

`<!-- pages/standards.vue -->
<script setup>
const { data: categories } = await useFetch('/api/standards') // ou importar JSON
</script>

<template>
  <!-- Conteúdo da página -->
</template>`

---

## 🎨 **Melhorias que Você Pode Adicionar**

1. **Search Bar no Menu**

vue

`<input 
  type="search" 
  placeholder="Buscar..."
  class="bg-gray-800 text-white px-4 py-2 rounded-lg"
/>`

1. **Indicador de Página Ativa**

typescript

`const route = useRoute()
const isActive = (path) => route.path === path`

1. **Animações com GSAP**

bash

`npm install gsap`

1. **Dark/Light Mode Toggle** (se quiser)
2. **Scroll Progress Bar**

vue

`<div class="fixed top-0 h-1 bg-yellow-400" :style="`width: ${scrollProgress}%`" />`