export const useModalidades = () => {
  const { getImage } = useImage()
  const { qualifier } = useExternalLinks()

  const modalidades = [
    {
      id: 1,
      title: 'WORKOUTS\nQUALIFIER',
      subtitle: 'Monstar Games',
      image: getImage('backgrounds/BG-01.png'),
      color: 'from-lime-400 to-lime-600',
      status: 'CLIQUE AQUI!',
      link: qualifier,
      available: true
    },
    {
      id: 2,
      title: 'INSCRIÇÕES\nTIMES',
      subtitle: 'Monstar Games',
      image: getImage('produtos/INICIANTES.png'),
      color: 'from-yellow-400 to-yellow-600',
      status: 'CLIQUE AQUI!',
      link: '/times',
      available: true
    },
    {
      id: 3,
      title: 'LEADERBOARD\nQUALIFIER',
      subtitle: 'Ranking Oficial',
      image: getImage('produtos/ELITE.png'),
      color: 'from-pink-500 to-pink-700',
      status: 'EM BREVE!',
      link: '/qualifier/leaderboard',
      available: false
    },
    {
      id: 4,
      title: 'HEAD COACH\nSOLIDÁRIO',
      subtitle: 'Monstar Affiliate',
      image: getImage('backgrounds/WEST.png'),
      color: 'from-orange-400 to-orange-600',
      status: 'EM BREVE!',
      link: '#',
      available: false
    }
  ]

  return { modalidades }
}

