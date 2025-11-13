#!/bin/bash

# Script de TESTE - Compressão de algumas imagens
# Processa apenas as primeiras 10 imagens para validação

set -e

IMAGES_DIR="public/assets/images"
BACKUP_DIR="public/assets/images/_backup"
OPTIMIZED_DIR="public/assets/images/_optimized"
WEBP_DIR="public/assets/images/_webp"
TEST_LIMIT=10

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🧪 TESTE: Compressão de $TEST_LIMIT imagens...${NC}\n"

# Criar diretórios necessários
mkdir -p "$BACKUP_DIR"
mkdir -p "$OPTIMIZED_DIR"
mkdir -p "$WEBP_DIR"

# Contadores (usando arquivos temporários para funcionar no subshell)
COUNTER_FILE=$(mktemp)
echo "0:0:0:0" > "$COUNTER_FILE"

# Função para obter tamanho do arquivo em bytes
get_file_size() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        stat -f%z "$1"
    else
        stat -c%s "$1"
    fi
}

# Função para formatar tamanho
format_size() {
    local bytes=$1
    if [ $bytes -gt 1048576 ]; then
        echo "$(echo "scale=2; $bytes / 1048576" | bc) MB"
    elif [ $bytes -gt 1024 ]; then
        echo "$(echo "scale=2; $bytes / 1024" | bc) KB"
    else
        echo "${bytes} bytes"
    fi
}

# Função para atualizar contadores
update_counters() {
    local compressed=$1
    local webp=$2
    local saved=$3
    
    IFS=':' read -r total compressed_count webp_count saved_total < "$COUNTER_FILE"
    compressed_count=$((compressed_count + compressed))
    webp_count=$((webp_count + webp))
    saved_total=$((saved_total + saved))
    echo "$total:$compressed_count:$webp_count:$saved_total" > "$COUNTER_FILE"
}

# Função para incrementar total
increment_total() {
    IFS=':' read -r total compressed_count webp_count saved_total < "$COUNTER_FILE"
    total=$((total + 1))
    echo "$total:$compressed_count:$webp_count:$saved_total" > "$COUNTER_FILE"
}

# Função para comprimir PNG
compress_png() {
    local file="$1"
    local output="$2"
    
    if command -v magick &> /dev/null; then
        # ImageMagick - PNG usa compression-level, não quality
        magick "$file" -strip -define png:compression-level=9 -define png:compression-filter=5 "$output"
    elif command -v sips &> /dev/null; then
        # sips (macOS nativo - mantém original e cria otimizado)
        sips -s format png -s formatOptions high "$file" --out "$output" &> /dev/null
    else
        cp "$file" "$output"
    fi
}

# Função para comprimir JPG
compress_jpg() {
    local file="$1"
    local output="$2"
    
    if command -v magick &> /dev/null; then
        magick "$file" -strip -quality 85 -interlace Plane "$output"
    elif command -v sips &> /dev/null; then
        sips -s format jpeg -s formatOptions high "$file" --out "$output" &> /dev/null
    else
        cp "$file" "$output"
    fi
}

# Função para converter PNG para WebP
convert_to_webp() {
    local file="$1"
    local output="$2"
    
    if command -v cwebp &> /dev/null; then
        cwebp -q 85 -m 6 "$file" -o "$output" 2>/dev/null
        return $?
    else
        echo -e "${YELLOW}⚠️  cwebp não encontrado. Instale com: brew install webp${NC}"
        return 1
    fi
}

# Processar apenas algumas imagens para teste
echo -e "${BLUE}📋 Processando primeiras $TEST_LIMIT imagens encontradas...${NC}\n"

find "$IMAGES_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) ! -path "*/_*" | head -$TEST_LIMIT | while read -r file; do
    increment_total
    
    filename=$(basename "$file")
    dir=$(dirname "$file")
    relative_dir="${dir#$IMAGES_DIR}"
    relative_dir="${relative_dir#/}"  # Remove leading slash if present
    
    # Criar estrutura de diretórios
    if [ -z "$relative_dir" ]; then
        # Arquivo está na raiz de images
        mkdir -p "$BACKUP_DIR"
        mkdir -p "$OPTIMIZED_DIR"
    else
        mkdir -p "$BACKUP_DIR/$relative_dir"
        mkdir -p "$OPTIMIZED_DIR/$relative_dir"
    fi
    
    original_size=$(get_file_size "$file")
    original_size_formatted=$(format_size $original_size)
    
    echo -e "${BLUE}📸 Processando: $filename${NC} (${original_size_formatted})"
    
    # Backup do original
    if [ -z "$relative_dir" ]; then
        backup_file="$BACKUP_DIR/$filename"
        optimized_file="$OPTIMIZED_DIR/$filename"
    else
        backup_file="$BACKUP_DIR/$relative_dir/$filename"
        optimized_file="$OPTIMIZED_DIR/$relative_dir/$filename"
    fi
    
    if [ ! -f "$backup_file" ]; then
        cp "$file" "$backup_file"
    fi
    
    extension="${filename##*.}"
    name_without_ext="${filename%.*}"
    
    # Comprimir baseado no tipo
    if [[ "$extension" =~ ^(png|PNG)$ ]]; then
        compress_png "$file" "$optimized_file"
        
        optimized_size=$(get_file_size "$optimized_file")
        optimized_size_formatted=$(format_size $optimized_size)
        saved=$((original_size - optimized_size))
        saved_formatted=$(format_size $saved)
        percent_saved=$(echo "scale=1; ($saved * 100) / $original_size" | bc)
        
        # Se PNG > 500KB, criar versão WebP
        if [ $original_size -gt 512000 ]; then
            if [ -z "$relative_dir" ]; then
                webp_file="$WEBP_DIR/${name_without_ext}.webp"
                mkdir -p "$WEBP_DIR"
            else
                webp_file="$WEBP_DIR/$relative_dir/${name_without_ext}.webp"
                mkdir -p "$WEBP_DIR/$relative_dir"
            fi
            
            echo -e "   ${YELLOW}→${NC} Tentando converter para WebP..."
            
            if convert_to_webp "$file" "$webp_file"; then
                webp_size=$(get_file_size "$webp_file")
                webp_size_formatted=$(format_size $webp_size)
                webp_saved=$((original_size - webp_size))
                webp_saved_formatted=$(format_size $webp_saved)
                webp_percent=$(echo "scale=1; ($webp_saved * 100) / $original_size" | bc)
                
                if [ $webp_saved -gt $saved ]; then
                    echo -e "   ${GREEN}✓${NC} WebP: ${webp_size_formatted} (economia: ${webp_saved_formatted} - ${webp_percent}%)"
                    update_counters 0 1 $webp_saved
                else
                    rm "$webp_file"
                    echo -e "   ${GREEN}✓${NC} PNG otimizado: ${optimized_size_formatted} (economia: ${saved_formatted} - ${percent_saved}%)"
                    update_counters 1 0 $saved
                fi
            else
                echo -e "   ${GREEN}✓${NC} PNG otimizado: ${optimized_size_formatted} (economia: ${saved_formatted} - ${percent_saved}%)"
                update_counters 1 0 $saved
            fi
        else
            echo -e "   ${GREEN}✓${NC} PNG otimizado: ${optimized_size_formatted} (economia: ${saved_formatted} - ${percent_saved}%)"
            update_counters 1 0 $saved
        fi
        
    elif [[ "$extension" =~ ^(jpg|jpeg|JPG|JPEG)$ ]]; then
        compress_jpg "$file" "$optimized_file"
        
        optimized_size=$(get_file_size "$optimized_file")
        optimized_size_formatted=$(format_size $optimized_size)
        saved=$((original_size - optimized_size))
        saved_formatted=$(format_size $saved)
        percent_saved=$(echo "scale=1; ($saved * 100) / $original_size" | bc)
        
        echo -e "   ${GREEN}✓${NC} JPG otimizado: ${optimized_size_formatted} (economia: ${saved_formatted} - ${percent_saved}%)"
        update_counters 1 0 $saved
    fi
    echo ""
done

# Ler contadores finais
IFS=':' read -r total_files compressed_files webp_files total_saved < "$COUNTER_FILE"
rm "$COUNTER_FILE"

# Calcular estatísticas finais
if command -v bc &> /dev/null; then
    total_saved_mb=$(echo "scale=2; $total_saved / 1048576" | bc)
else
    # Fallback usando awk
    total_saved_mb=$(awk "BEGIN {printf \"%.2f\", $total_saved / 1048576}")
fi

echo -e "${GREEN}✅ Teste de compressão concluído!${NC}\n"
echo -e "${BLUE}📊 Estatísticas do Teste:${NC}"
echo -e "   • Total de arquivos processados: $total_files"
echo -e "   • Arquivos comprimidos: $compressed_files"
echo -e "   • Arquivos convertidos para WebP: $webp_files"
echo -e "   • Espaço economizado: ${total_saved_mb} MB"
echo -e "\n${BLUE}📁 Estrutura criada:${NC}"
echo -e "   • Backups: $BACKUP_DIR"
echo -e "   • Otimizados: $OPTIMIZED_DIR"
echo -e "   • WebP: $WEBP_DIR"
echo -e "\n${YELLOW}💡 Revise os arquivos otimizados antes de executar o script completo!${NC}"
echo -e "${YELLOW}   Para processar todas as imagens: ./scripts/compress-images.sh${NC}"

