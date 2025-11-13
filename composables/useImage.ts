export const useImage = () => {
  const config = useRuntimeConfig()
  const useCloudinary = config.public.useCloudinary || false

  const getImage = (path: string, transforms?: string) => {
    if (useCloudinary) {
      return `https://res.cloudinary.com/${config.public.cloudName}/image/upload/${transforms || ''}/${path}`
    }
    return `/assets/images/${path}`
  }

  return { getImage }
}

