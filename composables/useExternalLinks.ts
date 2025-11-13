interface ExternalLink {
  url: string
  fallback?: string
  isValid: boolean
}

/**
 * Valida se uma URL tem formato válido
 */
const isValidUrl = (url: string): boolean => {
  if (!url || typeof url !== 'string') return false
  try {
    const urlObj = new URL(url)
    return urlObj.protocol === 'http:' || urlObj.protocol === 'https:'
  } catch {
    return false
  }
}

/**
 * Obtém uma URL válida ou retorna fallback
 */
const getValidUrl = (link: ExternalLink): string => {
  if (link.isValid && isValidUrl(link.url)) {
    return link.url
  }
  // Se houver fallback, tenta usar
  if (link.fallback && isValidUrl(link.fallback)) {
    return link.fallback
  }
  // Se não houver URL válida, retorna página de contato
  return '/contato'
}

// Links externos com validação e fallbacks
const externalLinks = {
  qualifier: {
    url: 'https://registration.digitalscore.com.br/qualifier2026/home',
    fallback: 'https://registration.digitalscore.com.br/',
    isValid: true
  },
  leaderboard: {
    url: 'https://panel.digitalscore.com.br/',
    fallback: undefined,
    isValid: true
  },
  judges: {
    url: 'https://www.e-inscricao.com/arbitrosdigitalscore/monstargames2023',
    fallback: undefined,
    isValid: true
  },
  staffForm: {
    url: 'https://docs.google.com/forms/d/e/1FAIpQLSceP-CIW9lY24rUg-Dsd11WJk0vdSBnsBMWgE8TdBtPlJ47ug/viewform',
    fallback: undefined,
    isValid: true
  }
} as const

export const useExternalLinks = () => {
  // Valida todos os links na inicialização
  const validatedLinks = Object.entries(externalLinks).reduce((acc, [key, link]) => {
    const isValid = isValidUrl(link.url)
    acc[key] = {
      ...link,
      isValid
    }
    return acc
  }, {} as Record<string, ExternalLink>)

  // Retorna getters que sempre retornam URLs válidas
  return {
    get qualifier() {
      return getValidUrl(validatedLinks.qualifier)
    },
    get leaderboard() {
      return getValidUrl(validatedLinks.leaderboard)
    },
    get judges() {
      return getValidUrl(validatedLinks.judges)
    },
    get staffForm() {
      return getValidUrl(validatedLinks.staffForm)
    },
    // Método para verificar se um link específico é válido
    isLinkValid(key: keyof typeof externalLinks): boolean {
      return validatedLinks[key]?.isValid ?? false
    },
    // Método para obter URL bruta (para debug)
    getRawUrl(key: keyof typeof externalLinks): string | undefined {
      return validatedLinks[key]?.url
    }
  }
}

