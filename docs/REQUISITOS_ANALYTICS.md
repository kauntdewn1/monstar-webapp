# 📊 Requisitos para Implementação de Analytics

## O que solicitar ao cliente

### 1. **Google Analytics 4 (GA4) - Recomendado**

#### Informações necessárias:

**✅ ID de Medição (Measurement ID)**

- Formato: `G-XXXXXXXXXX`
- Onde encontrar: Google Analytics → Admin → Propriedade → Informações da propriedade
- **Exemplo:** `G-ABC123XYZ456`

**✅ Acesso à conta do Google Analytics**

- Email com acesso de "Editor" ou "Administrador"
- Ou apenas o Measurement ID se o cliente preferir configurar manualmente

**✅ Objetivos de rastreamento (opcional, mas recomendado)**

- Quais ações do usuário são mais importantes?
  - Cliques em "INSCREVER-SE"
  - Downloads de PDFs (regulamento, standards)
  - Visualizações de páginas específicas
  - Interações com cards de modalidades/categorias
  - Cliques em links externos (Digital Score, etc.)

---

### 2. **Google Tag Manager (GTM) - Alternativa**

Se o cliente preferir usar GTM (mais flexível):

**✅ Container ID**
- Formato: `GTM-XXXXXXX`
- Onde encontrar: Google Tag Manager → Contêiner → ID do contêiner
- **Exemplo:** `GTM-ABC1234`

**✅ Acesso à conta do GTM**
- Email com acesso de "Editor" ou "Administrador"

---

### 3. **Facebook Pixel (Meta Pixel) - Opcional**

Se o cliente quiser rastrear conversões do Facebook/Instagram:

**✅ Pixel ID**
- Formato: Número de 15-16 dígitos
- Onde encontrar: Facebook Events Manager → Configurações → Pixel do Facebook
- **Exemplo:** `123456789012345`

**✅ Eventos personalizados (opcional)**

- Quais eventos rastrear?
  - Inscrições iniciadas
  - Visualizações de categorias
  - Downloads de documentos

---

### 4. **Outras ferramentas (opcional)**

#### Hotjar / Microsoft Clarity (Heatmaps)

- **Necessário:** ID da conta ou script de instalação

#### Google Search Console

- **Necessário:** Acesso à conta ou código de verificação

#### LinkedIn Insight Tag

- **Necessário:** Partner ID (se aplicável)

---

## 📋 Checklist de Informações para o Cliente

Envie este checklist ao cliente:

```
□ Google Analytics 4 (GA4)
  □ Measurement ID (G-XXXXXXXXXX): _______________________
  □ Acesso à conta: Sim / Não
  □ Email com acesso: _______________________

□ Google Tag Manager (GTM) - Opcional
  □ Container ID (GTM-XXXXXXX): _______________________
  □ Acesso à conta: Sim / Não

□ Facebook Pixel - Opcional
  □ Pixel ID: _______________________
  □ Eventos personalizados necessários: _______________________

□ Outras ferramentas
  □ Hotjar / Clarity: _______________________
  □ Google Search Console: Sim / Não
  □ Outras: _______________________

□ Objetivos de rastreamento
  □ Cliques em botões de inscrição
  □ Downloads de documentos
  □ Visualizações de páginas específicas
  □ Outros: _______________________

□ Conformidade com LGPD
  □ Cliente tem política de privacidade? Sim / Não
  □ URL da política: _______________________
  □ Banner de cookies necessário? Sim / Não
```

---

## 🔒 Considerações de Privacidade (LGPD)

### O que informar ao cliente:

1. **Banner de Cookies**
   - Será necessário implementar banner de consentimento?
   - Cliente já tem política de privacidade atualizada?

2. **Modo de Consentimento**
   - Google Analytics pode funcionar em modo "consent mode" (LGPD compliant)
   - Cliente prefere implementação com ou sem banner?

3. **Dados Coletados**
   - Informar ao cliente quais dados serão coletados:
     - Endereço IP (anonimizado)
     - Páginas visitadas
     - Tempo na página
     - Dispositivo/navegador
     - Localização (cidade/estado)

---

## 🚀 Implementação Técnica

### Opção 1: Google Analytics 4 (Direto)

**O que precisamos:**
- Measurement ID: `G-XXXXXXXXXX`

**Como implementar:**
```typescript
// nuxt.config.ts
export default defineNuxtConfig({
  modules: ['@nuxtjs/google-analytics'],
  googleAnalytics: {
    id: 'G-XXXXXXXXXX' // ou via env: process.env.GA_MEASUREMENT_ID
  }
})
```

---

### Opção 2: Google Tag Manager

**O que precisamos:**
- Container ID: `GTM-XXXXXXX`

**Como implementar:**
```typescript
// nuxt.config.ts
export default defineNuxtConfig({
  modules: ['@nuxtjs/gtm'],
  gtm: {
    id: 'GTM-XXXXXXX' // ou via env: process.env.GTM_ID
  }
})
```

---

### Opção 3: Implementação Manual (Mais controle)

**O que precisamos:**
- Measurement ID ou script de instalação

**Como implementar:**
```typescript
// plugins/analytics.client.ts
export default defineNuxtPlugin(() => {
  // Script do Google Analytics
})
```

---

## 📧 Template de Email para o Cliente

```
Assunto: Informações necessárias para implementação de Analytics

Olá [Nome do Cliente],

Para implementarmos o sistema de analytics no site Monstar Games, 
precisamos das seguintes informações:

1. GOOGLE ANALYTICS 4 (GA4)
   - Measurement ID (formato: G-XXXXXXXXXX)
   - Ou acesso à conta do Google Analytics

2. OBJETIVOS DE RASTREAMENTO
   - Quais ações dos usuários são mais importantes para vocês?
   - Exemplos: cliques em "Inscrições", downloads de PDFs, etc.

3. CONFORMIDADE LGPD
   - Vocês já têm política de privacidade?
   - Preferem banner de cookies ou modo consent?

4. OUTRAS FERRAMENTAS (opcional)
   - Facebook Pixel
   - Google Tag Manager
   - Outras ferramentas de analytics

Por favor, preencha o checklist anexo e retorne o mais breve possível.

Atenciosamente,
[Seu Nome]
```

---

## ✅ Após receber as informações

### Checklist de implementação:

- [ ] Verificar se o Measurement ID está correto
- [ ] Testar em ambiente de desenvolvimento
- [ ] Configurar eventos personalizados (se necessário)
- [ ] Implementar banner de cookies (se necessário)
- [ ] Adicionar política de privacidade (se necessário)
- [ ] Testar em produção
- [ ] Validar que os dados estão sendo coletados corretamente
- [ ] Documentar eventos customizados para o cliente

---

## 📚 Recursos úteis

### Links para o cliente:

- **Criar conta Google Analytics:** https://analytics.google.com/
- **Encontrar Measurement ID:** https://support.google.com/analytics/answer/9304153
- **Google Tag Manager:** https://tagmanager.google.com/
- **LGPD e Analytics:** https://support.google.com/analytics/answer/9019185

---

## 🎯 Eventos Recomendados para Rastrear

### Eventos padrão que podemos implementar:

1. **page_view** - Visualização de página (automático)
2. **click** - Cliques em botões importantes
   - `inscricao_qualifier`
   - `inscricao_times`
   - `ver_leaderboard`
   - `ver_standards`
   - `ver_regulamento`
3. **file_download** - Downloads de PDFs
   - `download_regulamento`
   - `download_standards`
4. **scroll** - Scroll depth (opcional)
5. **outbound_click** - Cliques em links externos
   - `click_digitalscore`
   - `click_instagram`
   - `click_facebook`

---

## 💡 Dicas para o Cliente

1. **Google Analytics 4 é gratuito** e suficiente para a maioria dos casos
2. **Google Tag Manager** oferece mais flexibilidade, mas requer mais configuração
3. **Facebook Pixel** só é necessário se houverem campanhas pagas no Facebook/Instagram
4. **LGPD**: Implementar banner de cookies se coletar dados pessoais
5. **Testes**: Sempre testar em ambiente de desenvolvimento antes de produção

---

**Última atualização:** $(date)

