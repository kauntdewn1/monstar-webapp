# Scripts de Otimização de Imagens

Este diretório contém scripts para otimizar e comprimir as imagens do projeto.

## 📋 Scripts Disponíveis

### 1. `compress-images.sh`

Script principal que comprime todas as imagens PNG e JPG, e converte PNGs grandes para WebP.

**Funcionalidades:**
- ✅ Comprime PNGs mantendo qualidade (85-95%)
- ✅ Comprime JPGs com qualidade otimizada (85%)
- ✅ Converte PNGs > 500KB para WebP automaticamente
- ✅ Cria backups automáticos dos originais
- ✅ Mantém estrutura de diretórios
- ✅ Relatório detalhado de economia de espaço

**Como usar:**
```bash
./scripts/compress-images.sh
```

**Saída:**
- `public/assets/images/_backup/` - Backups dos originais
- `public/assets/images/_optimized/` - Versões comprimidas (PNG/JPG)
- `public/assets/images/_webp/` - Versões WebP (quando aplicável)

### 2. `apply-optimized.sh`

Aplica as imagens otimizadas, substituindo os arquivos originais.

**⚠️ ATENÇÃO:** Este script substitui os arquivos originais. Certifique-se de revisar os resultados antes de executar.

**Como usar:**
```bash
# 1. Primeiro execute a compressão
./scripts/compress-images.sh

# 2. Revise os resultados nas pastas _optimized e _webp

# 3. Se estiver satisfeito, aplique as otimizações
./scripts/apply-optimized.sh
```

## 🔧 Requisitos

### Ferramentas Necessárias

**Obrigatórias:**
- `bash` (já incluído no macOS/Linux)

**Opcionais (recomendadas):**
- **ImageMagick** - Para melhor qualidade de compressão
  ```bash
  brew install imagemagick
  ```
- **WebP Tools** - Para conversão WebP
  ```bash
  brew install webp
  ```

**Fallback:**
- `sips` - Ferramenta nativa do macOS (já incluída)

## 📊 Exemplo de Resultados

Após executar `compress-images.sh`, você verá:

```
✅ Compressão concluída!
📊 Estatísticas:
   • Total de arquivos processados: 545
   • Arquivos comprimidos: 520
   • Arquivos convertidos para WebP: 25
   • Espaço economizado: 15.32 MB
```

## 🎯 Próximos Passos

1. Execute `compress-images.sh` para processar todas as imagens
2. Revise os resultados nas pastas `_optimized` e `_webp`
3. Execute `apply-optimized.sh` para aplicar as otimizações
4. (Opcional) Remova as pastas `_backup`, `_optimized` e `_webp` após confirmar que tudo está funcionando

## 💡 Dicas

- **Teste primeiro:** Execute em algumas imagens de teste antes de processar todas
- **Backup:** Os backups são criados automaticamente, mas considere fazer um backup manual também
- **WebP:** Use WebP para imagens grandes (>500KB) para melhor compressão
- **Qualidade:** Ajuste os valores de qualidade nos scripts se necessário (linhas 35-45)

