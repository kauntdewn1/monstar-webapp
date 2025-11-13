export const useNavigation = () => {
  const { qualifier, leaderboard, judges, staffForm } = useExternalLinks()

  const menuItems = [
    {
      label: 'QUALIFIER',
      items: [
        { name: 'Inscrições', href: qualifier, external: true },
        { name: 'Leaderboard', href: '/qualifier/leaderboard' },
        { name: 'Painel do Atleta', href: leaderboard, external: true },
        { name: 'Workouts', href: '/workouts' }
      ]
    },
    {
      label: 'MODALIDADES',
      items: [
        { name: 'Fitness Race', href: '/modalidades/fitness-race' },
        { name: 'Monstar Run', href: '/modalidades/run' },
        { name: 'Weightlifting', href: '/modalidades/weightlifting' }
      ]
    },
    {
      label: 'PATROCINADORES',
      href: '#patrocinadores'
    },
    {
      label: 'REGULAMENTO',
      items: [
        { name: 'Regulamento Geral', href: '/regulamento' },
        { name: 'Pré-requisitos', href: '/pre-requisitos' },
        { name: 'Standards', href: '/standards' }
      ]
    },
    {
      label: 'PRÉ-REQUISITOS',
      href: '/pre-requisitos'
    },
    {
      label: 'STAFF',
      items: [
        { name: 'Formulário Staff', href: staffForm, external: true },
        { name: 'Judges', href: judges, external: true }
      ]
    }
  ]

  return { menuItems }
}

