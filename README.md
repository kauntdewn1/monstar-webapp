# Monstar Games - Web Application

Plataforma moderna e escalável para Monstar Games, construída com **Nuxt.js 3** e **Tailwind CSS**.

## 🚀 Tecnologias

- **Framework:** Nuxt.js 3
- **Styling:** Tailwind CSS
- **Ícones:** Lucide Vue Next
- **Deploy:** Vercel

## 📦 Instalação

```bash
# Instalar dependências
npm install

# Desenvolvimento
npm run dev

# Build para produção
npm run build

# Preview da build
npm run preview
```

## 🚀 Deploy na Vercel

O projeto está configurado para deploy automático na Vercel:

1. **Conecte o repositório** na Vercel
2. A Vercel detectará automaticamente o Nuxt.js
3. O build será executado automaticamente
4. O projeto estará disponível em produção

### Configuração

- **Build Command:** `npm run build`
- **Output Directory:** `.output/public`
- **Install Command:** `npm install`
- **Framework:** Nuxt.js
- **Região:** São Paulo (gru1)

### Variáveis de Ambiente (Opcional)

Se precisar usar Cloudinary no futuro, adicione no painel da Vercel:
- `CLOUDINARY_CLOUD_NAME` - Nome da sua conta Cloudinary

## 📁 Estrutura do Projeto

```
monstar-webapp/
├── components/
│   ├── layout/          # Header, Footer
│   ├── home/            # Hero, LocalFestival
│   └── shared/          # Cards reutilizáveis
├── composables/         # useImage, useNavigation, etc.
├── pages/               # Rotas da aplicação
├── public/              # Assets estáticos
└── docs/                # Documentação
```

## ✅ Recursos Implementados

- [x] Setup Nuxt + Tailwind
- [x] Home + Hero section
- [x] Grid de modalidades com glassmorphism
- [x] Grid de categorias com glassmorphism interativo
- [x] Páginas estáticas (Regulamento, Pré-requisitos, Standards)
- [x] Footer com patrocinadores
- [x] Header com navegação completa
- [x] Seção Local Festival
- [x] Responsividade mobile-first
- [x] SEO otimizado (meta tags, sitemap, robots.txt)
- [x] Tratamento de erros (error.vue, image error handling)
- [x] Validação de links externos

## 🎨 Composables

- `useImage()` - Helper para imagens (preparado para Cloudinary)
- `useNavigation()` - Menu de navegação
- `useModalidades()` - Dados das modalidades
- `useCategories()` - Dados das categorias
- `usePatrocinadores()` - Lista de patrocinadores
- `useExternalLinks()` - Links externos (Digital Score, etc.)
- `useImageError()` - Tratamento de erros de imagem

## 📚 Documentação

- `docs/MIGRACAO.md` - Relatório de migração
- `docs/fase1-implemetacao.md` - Plano de implementação
- `AUDITORIA_PRODUCAO.md` - Auditoria pré-produção

## 🔧 Scripts Disponíveis

- `npm run dev` - Servidor de desenvolvimento
- `npm run build` - Build para produção
- `npm run generate` - Gerar site estático
- `npm run preview` - Preview da build de produção

## 📝 Notas

- As imagens estão organizadas em `public/`
- O projeto usa lazy loading para otimização
- Glassmorphism aplicado nos cards de modalidades e categorias
- Efeito de revelação interativa nos cards de categorias (passar dedo/cursor)
