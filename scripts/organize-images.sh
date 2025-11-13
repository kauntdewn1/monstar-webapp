#!/bin/bash

# Script para Organizar Imagens por Categoria
# Move imagens para subpastas baseado em padrões de nomenclatura

set -e

IMAGES_DIR="public/assets/images"
BACKUP_DIR="public/assets/images/_backup"

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}📁 Organizando imagens por categoria...${NC}\n"

# Criar estrutura de pastas
mkdir -p "$IMAGES_DIR/logos"
mkdir -p "$IMAGES_DIR/produtos"
mkdir -p "$IMAGES_DIR/backgrounds"
mkdir -p "$IMAGES_DIR/eventos"
mkdir -p "$IMAGES_DIR/fotos"
mkdir -p "$IMAGES_DIR/outros"

# Contadores
moved=0
skipped=0

# Função para mover arquivo mantendo estrutura de backup
move_file() {
    local file="$1"
    local target_dir="$2"
    local filename=$(basename "$file")
    
    # Não mover se já estiver na pasta correta
    if [ "$(dirname "$file")" = "$target_dir" ]; then
        return 0
    fi
    
    # Verificar se arquivo de destino já existe
    if [ -f "$target_dir/$filename" ]; then
        echo -e "${YELLOW}⚠️${NC} $filename já existe em $target_dir, pulando..."
        skipped=$((skipped + 1))
        return 0
    fi
    
    mv "$file" "$target_dir/$filename"
    moved=$((moved + 1))
    echo -e "${GREEN}✓${NC} $filename → $target_dir"
}

# Processar todas as imagens
find "$IMAGES_DIR" -maxdepth 1 -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) ! -path "*/_*" | while read -r file; do
    filename=$(basename "$file" | tr '[:upper:]' '[:lower:]')
    filename_upper=$(basename "$file")
    
    # LOGOS E MARCAS
    if [[ "$filename" =~ (logo|logotipo|audax|audaz|agencia|oficial|apoio|pood|conceito|formacao|sesi|digitalscore|linq|wma|prime|kmaker|reign|reing|hercules|alberto|cota|pira|oak|nissa|inovare|avince|sicoob|puro|flampark|rx|performance|big-box|bs-cross|upper|lower|seated|workouts|quadro|valor|investimento|comprar-agora|patrocinadores|parceiros|sponsor|pulseira|pwrd|landstar|escola|adaptive|ipog|affiliate|prefeitura|face|ig|youtube) ]]; then
        move_file "$file" "$IMAGES_DIR/logos"
        continue
    fi
    
    # PRODUTOS E CATEGORIAS
    if [[ "$filename" =~ (lote|teens|iniciantes|elite|master|standards|amador|categoria|categorias|produto|curos|sadf) ]]; then
        move_file "$file" "$IMAGES_DIR/produtos"
        continue
    fi
    
    # BACKGROUNDS
    if [[ "$filename" =~ ^(bg|background|scaled|west|fundo|site-banner|banner) ]]; then
        move_file "$file" "$IMAGES_DIR/backgrounds"
        continue
    fi
    
    # EVENTOS E COMPETIÇÕES
    if [[ "$filename" =~ (evento|competicao|campeonato|monstar|fitness|race|beach|calistenia|goiania|goiânia|goi|qualifier|inscricoes|times|time|team|leaderboard|workout|prefeitura) ]]; then
        move_file "$file" "$IMAGES_DIR/eventos"
        continue
    fi
    
    # FOTOS DE PESSOAS/EVENTOS
    if [[ "$filename" =~ ^(mnt_|img_|foto|rcg_|lns_|whatsapp|46905018401|finaltcb|ginasio|local|video|rcg-) ]]; then
        move_file "$file" "$IMAGES_DIR/fotos"
        continue
    fi
    
    # OUTROS (padrão, favicon, etc)
    if [[ "$filename" =~ (favicon|favicone|artboard|untitled|cropped|plt|nc|lpo|trio|texto|clique|eu-quero|desconto|monstar-games|monstar-run|monstar-fitness) ]]; then
        move_file "$file" "$IMAGES_DIR/outros"
        continue
    fi
    
    # Se não se encaixar em nenhuma categoria, deixar na raiz ou mover para outros
    echo -e "${YELLOW}?${NC} $filename_upper → mantido na raiz (categoria não identificada)"
done

echo -e "\n${GREEN}✅ Organização concluída!${NC}"
echo -e "📊 Estatísticas:"
echo -e "   • Arquivos movidos: $moved"
echo -e "   • Arquivos pulados: $skipped"
echo -e "\n${BLUE}📁 Estrutura criada:${NC}"
echo -e "   • logos/ - Logos e marcas"
echo -e "   • produtos/ - Produtos e categorias"
echo -e "   • backgrounds/ - Backgrounds e fundos"
echo -e "   • eventos/ - Eventos e competições"
echo -e "   • fotos/ - Fotos de pessoas/eventos"
echo -e "   • outros/ - Outros arquivos"
echo -e "\n${YELLOW}💡 Revise a organização e ajuste manualmente se necessário!${NC}"

