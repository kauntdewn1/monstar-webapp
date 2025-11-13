export const useImageError = () => {
  const imageError = ref(false)
  const fallbackImage = '/logo_oficial.png'

  const handleImageError = (event: Event, fallback?: string) => {
    const img = event.target as HTMLImageElement
    if (img && img.src !== fallback && img.src !== fallbackImage) {
      img.src = fallback || fallbackImage
      imageError.value = true
    }
  }

  const resetImageError = () => {
    imageError.value = false
  }

  return {
    imageError: readonly(imageError),
    handleImageError,
    resetImageError,
    fallbackImage
  }
}

