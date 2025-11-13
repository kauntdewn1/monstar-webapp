# Relatório de Migração - Monstar Games

## Data da Migração
**Data:** $(date +"%d/%m/%Y %H:%M")

## Resumo Executivo

Este documento detalha a migração de recursos do projeto antigo (`monstar-php`) para o novo projeto moderno (`monstar-webapp`).

## Recursos Migrados

### 1. Imagens

- **Total de imagens copiadas:** 545 arquivos
- **Tamanho total:** ~79 MB
- **Localização:** `/public/assets/images/`
- **Formatos:** PNG, JPG, JPEG, SVG, WEBP, GIF, ICO

#### Categorias de Imagens Identificadas:
- **Logos e Marcas:**
  - AUDAX
  - AGENCIA-OFICIAL
  - APOIO
  - Pood
  - Conceito
  - Formação
  - Sesi
  - Digital Score
  - Linq
  - WMA
  - Prime

- **Categorias de Produtos/Serviços:**
  - Lotes (1o-LOTE, 2o-LOTE, 3o-LOTE)
  - TEENS
  - INICIANTES
  - ELITE
  - MASTER
  - STANDARDS
  - AMADOR
  - COMPRAR-AGORA
  - INVESTIMENTO

- **Backgrounds e Elementos Visuais:**
  - BG-01
  - SCALED
  - WEST
  - Fotos de eventos e competições

### 2. Estrutura do Projeto Antigo

O projeto antigo era baseado em **WordPress** com:
- Tema: Astra (com tema filho customizado)
- Plugins principais:
  - Elementor (page builder)
  - Elementor Pro
  - Essential Addons for Elementor

#### Páginas Identificadas:
- Home
- Carrinho
- Contato
- Finalizar Compra
- Loja
- Minha Conta
- Leaderboard
- Painel do Atleta
- Workouts
- Times
- Valores
- Regulamentos
- Standards
- Pré-requisitos
- Mídia Oficial
- Links
- Várias páginas de eventos (monstar-games, monstar-beach-tennis, monstar-calistenia, etc.)

## Estrutura do Novo Projeto

```
monstar-webapp/
├── public/
│   └── assets/
│       ├── images/     (545 imagens migradas)
│       ├── fonts/     (preparado para fontes customizadas)
│       └── icons/      (preparado para ícones)
├── src/               (código fonte do novo projeto)
└── docs/              (documentação)
    └── MIGRACAO.md    (este arquivo)
```

## Próximos Passos Recomendados

### 1. Organização de Imagens

- [x] Scripts de compressão criados
- [x] Criar subpastas por categoria (logos, produtos, backgrounds, etc.) - **Concluído**
- [ ] Remover versões redimensionadas duplicadas (mantendo apenas originais)
- [x] Otimizar imagens para web (compressão, formatos modernos) - **Scripts prontos**
- [ ] Criar um sistema de nomenclatura consistente

#### Scripts de Compressão Criados

**Localização:** `scripts/compress-images.sh`

**Funcionalidades:**

- Comprime PNGs e JPGs usando ImageMagick ou sips (macOS nativo)
- Converte PNGs grandes (>500KB) para WebP automaticamente
- Cria backups dos arquivos originais em `public/assets/images/_backup/`
- Salva versões otimizadas em `public/assets/images/_optimized/`
- Salva versões WebP em `public/assets/images/_webp/`
- Mantém estrutura de diretórios original

**Uso:**
```bash
# Executar compressão
./scripts/compress-images.sh

# Revisar resultados e aplicar (substituir originais)
./scripts/apply-optimized.sh
```

**Ferramentas Utilizadas:**

- ImageMagick (`magick`) - Compressão avançada
- sips (macOS) - Compressão nativa como fallback
- cwebp - Conversão para WebP

**Nota:** Os scripts criam backups automáticos antes de qualquer modificação.

#### Organização por Categorias

**Localização:** `scripts/organize-images.sh`

**Funcionalidades:**
- Organiza automaticamente imagens em subpastas por categoria
- Usa padrões de nomenclatura para identificar categorias
- Mantém estrutura de diretórios
- Evita duplicatas (não move se arquivo já existe no destino)

**Estrutura Criada:**
```
public/assets/images/
├── logos/          (322 arquivos - 27 MB)
├── produtos/       (50 arquivos - 9 MB)
├── backgrounds/    (21 arquivos - 17 MB)
├── eventos/        (43 arquivos - 7.4 MB)
├── fotos/          (60 arquivos - 12 MB)
└── outros/         (80 arquivos - 3 MB)
```

**Categorias Identificadas:**
- **Logos:** Logos, marcas, cotas, pulseiras, quadros, etc.
- **Produtos:** Lotes, categorias (TEENS, ELITE, MASTER, etc.)
- **Backgrounds:** Fundos, banners, backgrounds
- **Eventos:** Competições, workouts, eventos Monstar
- **Fotos:** Fotos de pessoas, eventos, competições
- **Outros:** Artboards, favicons, arquivos diversos

**Uso:**
```bash
./scripts/organize-images.sh
```

**Nota:** Alguns arquivos podem permanecer na raiz se não se encaixarem em nenhuma categoria. Revise manualmente se necessário.

### 2. Análise de Funcionalidades

- [ ] Mapear funcionalidades do WordPress para nova stack
- [ ] Identificar APIs e integrações necessárias
- [ ] Documentar regras de negócio

### 3. Stack Tecnológica Sugerida

Considerando a necessidade de uma stack moderna e escalável:
- **Frontend:** React/Next.js ou Vue/Nuxt.js
- **Backend:** Node.js (Express/NestJS) ou Python (FastAPI/Django)
- **Banco de Dados:** PostgreSQL ou MongoDB
- **Autenticação:** JWT ou OAuth2
- **E-commerce:** Integração com gateway de pagamento
- **CMS:** Headless CMS (Strapi, Contentful) se necessário

### 4. Recursos Adicionais a Considerar
- [ ] Verificar se há fontes customizadas no projeto antigo
- [ ] Identificar ícones e SVGs reutilizáveis
- [ ] Extrair cores e paleta de design
- [ ] Documentar tipografia utilizada

## Observações

- O CSS customizado do tema filho do WordPress não foi migrado, pois será recriado na nova stack
- As versões redimensionadas das imagens foram mantidas para referência, mas podem ser removidas após análise
- Recomenda-se revisar todas as imagens para garantir que são necessárias no novo projeto

## Contato

Para dúvidas sobre esta migração, consulte a equipe de desenvolvimento.

