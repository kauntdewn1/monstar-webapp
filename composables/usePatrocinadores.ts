export const usePatrocinadores = () => {
  const { getImage } = useImage()

  const patrocinadores = [
    { name: 'AUDAX', logo: getImage('logos/AUDAX-1536x244.png'), tier: 'ouro' },
    { name: 'Linq Telecom', logo: getImage('logos/linq.png'), tier: 'ouro' },
    { name: 'SESI', logo: getImage('logos/sesi.png'), tier: 'principal' },
    { name: 'Pood', logo: getImage('logos/Pood.png'), tier: 'prata' }
  ]

  return { patrocinadores }
}

