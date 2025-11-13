export const useCategories = () => {
  const { getImage } = useImage()

  const categorias = [
    {
      id: 1,
      name: 'TEENS',
      subtitle: 'CATEGORIA',
      ageRange: '-17',
      gender: 'MASCULINO | FEMININO',
      image: getImage('produtos/TEENS.png'),
      color: 'yellow'
    },
    {
      id: 2,
      name: 'AMADOR',
      subtitle: 'CATEGORIA',
      ageRange: '',
      gender: 'MASCULINO | FEMININO',
      image: getImage('produtos/AMADOR.png'),
      color: 'cyan'
    },
    {
      id: 3,
      name: 'SCALED',
      subtitle: 'CATEGORIA',
      ageRange: '',
      gender: 'MASCULINO | FEMININO',
      image: getImage('backgrounds/SCALED.png'),
      color: 'pink'
    },
    {
      id: 4,
      name: 'ELITE',
      subtitle: 'CATEGORIA',
      ageRange: '',
      gender: 'MASCULINO | FEMININO',
      image: getImage('produtos/ELITE.png'),
      color: 'yellow'
    }
  ]

  return { categorias }
}

