#!/bin/bash

# Script de Compressão e Otimização de Imagens
# Comprime PNGs e JPGs e converte PNGs grandes para WebP

set +e  # Continuar mesmo com erros

IMAGES_DIR="public/assets/images"
BACKUP_DIR="public/assets/images/_backup"
OPTIMIZED_DIR="public/assets/images/_optimized"
WEBP_DIR="public/assets/images/_webp"

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Iniciando compressão de imagens...${NC}\n"

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

# Processar todas as imagens
find "$IMAGES_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) ! -path "*/_*" | while read -r file; do
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
        backup_file="$BACKUP_DIR/$filename"
        optimized_file="$OPTIMIZED_DIR/$filename"
    else
        mkdir -p "$BACKUP_DIR/$relative_dir"
        mkdir -p "$OPTIMIZED_DIR/$relative_dir"
        backup_file="$BACKUP_DIR/$relative_dir/$filename"
        optimized_file="$OPTIMIZED_DIR/$relative_dir/$filename"
    fi
    
    # Backup do original
    if [ ! -f "$backup_file" ]; then
        cp "$file" "$backup_file"
    fi
    
    original_size=$(get_file_size "$file")
    extension="${filename##*.}"
    name_without_ext="${filename%.*}"
    
    # Verificar se arquivo não está vazio ou corrompido
    if [ ! -s "$file" ]; then
        echo -e "${YELLOW}⚠️${NC} $file → Arquivo vazio, pulando..."
        continue
    fi
    
    # Comprimir baseado no tipo
    if [[ "$extension" =~ ^(png|PNG)$ ]]; then
        if ! compress_png "$file" "$optimized_file" 2>/dev/null; then
            echo -e "${YELLOW}⚠️${NC} $file → Erro ao comprimir, pulando..."
            continue
        fi
        
        optimized_size=$(get_file_size "$optimized_file")
        saved=$((original_size - optimized_size))
        
        # Se PNG > 500KB, criar versão WebP
        if [ $original_size -gt 512000 ]; then
            if [ -z "$relative_dir" ]; then
                webp_file="$WEBP_DIR/${name_without_ext}.webp"
                mkdir -p "$WEBP_DIR"
            else
                webp_file="$WEBP_DIR/$relative_dir/${name_without_ext}.webp"
                mkdir -p "$WEBP_DIR/$relative_dir"
            fi
            
            if convert_to_webp "$file" "$webp_file"; then
                webp_size=$(get_file_size "$webp_file")
                webp_saved=$((original_size - webp_size))
                
                if [ $webp_saved -gt $saved ]; then
                    echo -e "${GREEN}✓${NC} $file → WebP (${webp_saved} bytes salvos)"
                    update_counters 0 1 $webp_saved
                else
                    rm "$webp_file"
                    echo -e "${GREEN}✓${NC} $file → PNG otimizado (${saved} bytes salvos)"
                    update_counters 1 0 $saved
                fi
            else
                echo -e "${GREEN}✓${NC} $file → PNG otimizado (${saved} bytes salvos)"
                update_counters 1 0 $saved
            fi
        else
            echo -e "${GREEN}✓${NC} $file → PNG otimizado (${saved} bytes salvos)"
            update_counters 1 0 $saved
        fi
        
    elif [[ "$extension" =~ ^(jpg|jpeg|JPG|JPEG)$ ]]; then
        if ! compress_jpg "$file" "$optimized_file" 2>/dev/null; then
            echo -e "${YELLOW}⚠️${NC} $file → Erro ao comprimir, pulando..."
            continue
        fi
        
        optimized_size=$(get_file_size "$optimized_file")
        saved=$((original_size - optimized_size))
        
        echo -e "${GREEN}✓${NC} $file → JPG otimizado (${saved} bytes salvos)"
        update_counters 1 0 $saved
    fi
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

echo -e "\n${GREEN}✅ Compressão concluída!${NC}"
echo -e "📊 Estatísticas:"
echo -e "   • Total de arquivos processados: $total_files"
echo -e "   • Arquivos comprimidos: $compressed_files"
echo -e "   • Arquivos convertidos para WebP: $webp_files"
echo -e "   • Espaço economizado: ${total_saved_mb} MB"
echo -e "\n📁 Estrutura criada:"
echo -e "   • Backups: $BACKUP_DIR"
echo -e "   • Otimizados: $OPTIMIZED_DIR"
echo -e "   • WebP: $WEBP_DIR"
echo -e "\n${YELLOW}⚠️  Revise os arquivos otimizados antes de substituir os originais!${NC}"
echo -e "${YELLOW}   Para aplicar: mv $OPTIMIZED_DIR/* $IMAGES_DIR/${NC}"

