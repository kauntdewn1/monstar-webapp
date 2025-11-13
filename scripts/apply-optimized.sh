#!/bin/bash

# Script para aplicar as imagens otimizadas (substituir originais)

set -e

IMAGES_DIR="public/assets/images"
OPTIMIZED_DIR="public/assets/images/_optimized"
WEBP_DIR="public/assets/images/_webp"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}⚠️  ATENÇÃO: Este script irá substituir as imagens originais pelas otimizadas!${NC}"
read -p "Deseja continuar? (s/N): " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Ss]$ ]]; then
    echo -e "${RED}Operação cancelada.${NC}"
    exit 1
fi

echo -e "${GREEN}🔄 Aplicando imagens otimizadas...${NC}\n"

# Aplicar PNGs e JPGs otimizados
if [ -d "$OPTIMIZED_DIR" ]; then
    find "$OPTIMIZED_DIR" -type f | while read -r optimized_file; do
        relative_path="${optimized_file#$OPTIMIZED_DIR/}"
        original_file="$IMAGES_DIR/$relative_path"
        
        if [ -f "$original_file" ]; then
            cp "$optimized_file" "$original_file"
            echo -e "${GREEN}✓${NC} Aplicado: $relative_path"
        fi
    done
fi

# Copiar WebPs para pasta principal (manter originais também)
if [ -d "$WEBP_DIR" ]; then
    find "$WEBP_DIR" -type f -name "*.webp" | while read -r webp_file; do
        relative_path="${webp_file#$WEBP_DIR/}"
        target_file="$IMAGES_DIR/$relative_path"
        target_dir=$(dirname "$target_file")
        
        mkdir -p "$target_dir"
        cp "$webp_file" "$target_file"
        echo -e "${GREEN}✓${NC} WebP copiado: $relative_path"
    done
fi

echo -e "\n${GREEN}✅ Imagens otimizadas aplicadas com sucesso!${NC}"

