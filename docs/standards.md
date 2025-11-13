// Standards Page Component
const StandardsPage = () => {
const [activeTab, setActiveTab] = useState('individual');

const individualCategories = [
{
name: 'SCALED',
description: 'Para os atletas que estão trabalhando para dominar as suas habilidades, subirem cargas e estão ansiosos para se desafiarem.',
color: 'from-pink-500 to-pink-700',
icon: '🎯',
weights: {
snatch: { male: '95lbs', female: '65lbs' },
cleanJerk: { male: '115lbs', female: '75lbs' }
},
skills: 'Push-Ups, Double Unders, Toes to Bar e Pull-Ups e serão cobrados para todos os atletas, assim como os exercícios com o peso do corpo e de sobrecarga de baixa complexidade.',
note: 'Não teremos Natação para esta categoria.'
},
{
name: 'TEENS',
description: 'Para atletas entre 15 a 17 anos que fazem alguns benchmarks com o peso recomendado.',
color: 'from-yellow-400 to-yellow-600',
icon: '⚡',
weights: {
snatch: { male: '115lbs', female: '75lbs' },
cleanJerk: { male: '155lbs', female: '115lbs' }
},
skills: {
male: 'Ring Muscle-Ups, Legless Rope Climb, Handstand Walking, Bar Muscle-Ups, Chest to Bar, Pull-Ups, Toes to Bar, Handstand Push-Ups, Rope Climb e Pistol',
female: 'Bar Muscle-Ups, Chest to Bar, Pull-Ups, Toes to Bar, Handstand Push-Ups, Rope Climb e Pistol'
},
note: 'Natação para todos os atletas desta categoria.'
},
{
name: 'AMADOR',
description: 'Para atletas que estão trabalhando para dominar suas habilidades e subirem cargas.',
color: 'from-cyan-400 to-cyan-600',
icon: '💪',
weights: {
snatch: { male: '135lbs', female: '95lbs' },
cleanJerk: { male: '165lbs', female: '115lbs' }
},
skills: {
male: 'Ring Muscle-Ups, Bar Muscle-Ups, Chest to Bar, Pull-Ups, Toes to Bar, Handstand Walking, Handstand Push-Ups, Rope Climb e Pistol',
female: 'Bar Muscle-Ups, Chest to Bar, Pull-Ups, Toes to Bar, Handstand Push-Ups, Rope Climb e Pistol'
},
note: 'Natação para todos os atletas desta categoria.'
},
{
name: 'MASTER 35-39',
description: 'Para atletas que fazem alguns benchmarks com o peso recomendado.',
color: 'from-purple-500 to-purple-700',
icon: '🏆',
weights: {
snatch: { male: '155lbs', female: '110lbs' },
cleanJerk: { male: '185lbs', female: '135lbs' }
},
skills: {
male: 'Ring Muscle-Ups, Legless Rope Climb, Handstand Walking, Bar Muscle-Ups, Chest to Bar, Pull-Ups, Toes to Bar, Handstand Push-Ups, Rope Climb e Pistol',
female: 'Bar Muscle-Ups, Chest to Bar, Pull-Ups, Toes to Bar, Handstand Push-Ups, Rope Climb e Pistol'
},
note: 'Natação para todos os atletas desta categoria.'
},
{
name: 'MASTER 40-44',
description: 'Destinada a atletas experientes que dominam suas habilidades.',
color: 'from-orange-500 to-orange-700',
icon: '🥇',
weights: {
snatch: { male: '135lbs', female: '95lbs' },
cleanJerk: { male: '165lbs', female: '115lbs' }
},
skills: {
male: 'Ring Muscle-Ups, Legless Rope Climb, Handstand Walking, Bar Muscle-Ups, Chest to Bar, Pull-Ups, Toes to Bar, Handstand Push-Ups, Rope Climb e Pistol',
female: 'Bar Muscle-Ups, Chest to Bar, Pull-Ups, Toes to Bar, Handstand Push-Ups, Rope Climb e Pistol'
},
note: 'Natação para todos os atletas desta categoria.'
},
{
name: 'MASTER 45+',
description: 'Destinada a atletas experientes focados em aumentar cargas.',
color: 'from-red-500 to-red-700',
icon: '🔥',
weights: {
snatch: { male: '115lbs', female: '85lbs' },
cleanJerk: { male: '155lbs', female: '105lbs' }
},
skills: {
male: 'Ring Muscle-Ups, Bar Muscle-Ups, Chest to Bar, Pull-Ups, Toes to Bar, Handstand Push-Ups, Rope Climb e Pistol',
female: 'Bar Muscle-Ups, Chest to Bar, Pull-Ups, Toes to Bar, Handstand Push-Ups, Rope Climb e Pistol'
},
note: 'Natação para todos os atletas desta categoria.'
},
{
name: 'ELITE / RX',
description: 'Para atletas experientes que conquistaram sua vaga através do Qualifier.',
color: 'from-yellow-400 to-amber-600',
icon: '👑',
weights: null,
skills: 'Esteja preparado para testar o seu condicionamento físico e sua mente.',
note: 'Natação para todos os atletas desta categoria.'
}
];

const teamCategories = [
{
name: 'INICIANTES',
description: 'Para atletas que estão iniciando no esporte ou participando da primeira competição.',
color: 'from-green-400 to-green-600',
icon: '🌱',
weights: {
snatch: { male: '65lbs', female: '45lbs' },
cleanJerk: { male: '95lbs', female: '65lbs' }
},
skills: 'Exercícios com o peso do corpo e de sobrecarga de baixa complexidade.'
},
{
name: 'SCALED',
description: 'Para atletas que estão trabalhando para dominar habilidades.',
color: 'from-pink-500 to-pink-700',
icon: '🎯',
weights: {
snatch: { male: '75lbs', female: '55lbs' },
cleanJerk: { male: '115lbs', female: '75lbs' }
},
skills: 'Pull-Ups e Toes to Bar apenas para os homens; Push-Ups para todos os atletas.'
},
{
name: 'AMADOR',
description: 'Para atletas que fazem alguns benchmarks com o peso recomendado.',
color: 'from-cyan-400 to-cyan-600',
icon: '💪',
weights: {
snatch: { male: '115lbs', female: '75lbs' },
cleanJerk: { male: '155lbs', female: '115lbs' }
},
skills: 'Bar Muscle-Ups apenas para os homens; Double Unders, Chest to Bar, Pull-Ups, Toes to Bar, Handstand Push-Ups e Rope Climb para todos.',
note: 'Natação para pelo menos 1 atleta do time.'
},
{
name: 'MASTER +110',
description: 'Para atletas master que fazem benchmarks com peso recomendado.',
color: 'from-purple-500 to-purple-700',
icon: '🏆',
weights: {
snatch: { male: '115lbs', female: '75lbs' },
cleanJerk: { male: '155lbs', female: '115lbs' }
},
skills: 'Bar Muscle-Ups apenas para os homens; Double Unders, Chest to Bar, Pull-Ups, Toes to Bar, Handstand Push-Ups e Rope Climb para todos.',
note: 'Natação para pelo menos 1 atleta por time.'
},
{
name: 'RX',
description: 'Para atletas que fazem benchmarks com o peso recomendado.',
color: 'from-yellow-400 to-amber-600',
icon: '👑',
weights: {
snatch: { male: '135lbs', female: '105lbs' },
cleanJerk: { male: '185lbs', female: '135lbs' }
},
skills: 'Double-Unders, Natação, Ring Muscle-Ups, Bar Muscle-Ups, Chest to Bar, Handstand Push-Ups, Handstand Walk, Legless, Rope Climb para todos.',
note: 'Natação para todos os atletas desta categoria.'
}
];

const CategoryCard = ({ category }) => (
<div className="bg-gradient-to-br from-gray-800 to-gray-900 rounded-xl overflow-hidden border border-gray-700 hover:border-yellow-500 transition-all hover:shadow-xl hover:shadow-yellow-500/20">
{/* Header */}
<div className={`bg-gradient-to-r ${category.color} p-6 text-white`}>
<div className="flex items-center gap-3 mb-2">
<span className="text-4xl">{category.icon}</span>
<h3 className="text-3xl font-black">{[category.name](http://category.name/)}</h3>
</div>
<p className="text-sm opacity-90">{category.description}</p>
</div>

```
  {/* Content */}
  <div className="p-6 space-y-6">
    {/* Weights */}
    {category.weights && (
      <div>
        <h4 className="text-lg font-bold text-yellow-400 mb-3 flex items-center gap-2">
          <Dumbbell size={20} />
          Cargas de Trabalho
        </h4>
        <div className="grid grid-cols-2 gap-4">
          <div className="bg-gray-800/50 rounded-lg p-4">
            <div className="text-sm text-gray-400 mb-1">Snatch</div>
            <div className="text-white font-bold">
              <div>♂️ {category.weights.snatch.male}</div>
              <div>♀️ {category.weights.snatch.female}</div>
            </div>
          </div>
          <div className="bg-gray-800/50 rounded-lg p-4">
            <div className="text-sm text-gray-400 mb-1">Clean & Jerk</div>
            <div className="text-white font-bold">
              <div>♂️ {category.weights.cleanJerk.male}</div>
              <div>♀️ {category.weights.cleanJerk.female}</div>
            </div>
          </div>
        </div>
      </div>
    )}

    {/* Skills */}
    <div>
      <h4 className="text-lg font-bold text-yellow-400 mb-3 flex items-center gap-2">
        <Trophy size={20} />
        Habilidades Exigidas
      </h4>
      <div className="bg-gray-800/50 rounded-lg p-4 text-sm text-gray-300 leading-relaxed">
        {typeof category.skills === 'string' ? (
          <p>{category.skills}</p>
        ) : (
          <>
            <p className="mb-3"><strong className="text-white">Masculino:</strong> {category.skills.male}</p>
            <p><strong className="text-white">Feminino:</strong> {category.skills.female}</p>
          </>
        )}
      </div>
    </div>

    {/* Note */}
    {category.note && (
      <div className="bg-yellow-500/10 border border-yellow-500/30 rounded-lg p-4">
        <p className="text-sm text-yellow-300 flex items-start gap-2">
          <span className="text-lg">⚠️</span>
          <span><strong>Observação:</strong> {category.note}</span>
        </p>
      </div>
    )}

    {/* Footer Note */}
    <div className="text-xs text-gray-500 italic border-t border-gray-700 pt-4">
      * Todos os pesos indicados devem ser considerados para a execução de um workout e não para 1-RM (Repetição Máxima).
    </div>
  </div>
</div>

```

);

return (
<div className="bg-black min-h-screen">
<Header />

```
  {/* Hero Section */}
  <div className="relative bg-gradient-to-br from-gray-900 via-black to-gray-900 py-20 overflow-hidden">
    <div className="absolute inset-0 opacity-10">
      <div className="absolute inset-0" style={{
        backgroundImage: 'repeating-linear-gradient(45deg, transparent, transparent 40px, rgba(255,215,0,0.1) 40px, rgba(255,215,0,0.1) 80px)'
      }} />
    </div>

    <div className="relative max-w-7xl mx-auto px-4 text-center">
      <div className="inline-block bg-yellow-500/20 border border-yellow-500 rounded-full px-6 py-2 mb-6">
        <span className="text-yellow-400 font-bold text-sm">TEMPORADA 2025/26</span>
      </div>

      <h1 className="text-6xl md:text-8xl font-black text-white mb-6">
        STANDARDS
      </h1>

      <p className="text-xl text-gray-300 max-w-3xl mx-auto leading-relaxed">
        Os padrões descritos abaixo devem ser considerados um guia específico para competir no Monstar Games.
        São considerados "pesos de trabalho" e movimentos que podem ser realizados para múltiplas repetições.
      </p>

      <div className="mt-8 inline-flex items-center gap-2 text-yellow-400 text-sm">
        <FileText size={18} />
        <span>Reservamo-nos o direito de fazer alterações nas habilidades e cargas dentro do razoável.</span>
      </div>
    </div>
  </div>

  {/* Tabs */}
  <div className="bg-gray-900 border-b border-gray-800 sticky top-20 z-40">
    <div className="max-w-7xl mx-auto px-4">
      <div className="flex gap-4">
        <button
          onClick={() => setActiveTab('individual')}
          className={`flex items-center gap-2 px-6 py-4 font-bold transition-all border-b-4 ${
            activeTab === 'individual'
              ? 'text-yellow-400 border-yellow-400'
              : 'text-gray-400 border-transparent hover:text-white'
          }`}
        >
          <Trophy size={20} />
          INDIVIDUAL QUALIFIER
        </button>
        <button
          onClick={() => setActiveTab('teams')}
          className={`flex items-center gap-2 px-6 py-4 font-bold transition-all border-b-4 ${
            activeTab === 'teams'
              ? 'text-yellow-400 border-yellow-400'
              : 'text-gray-400 border-transparent hover:text-white'
          }`}
        >
          <Users size={20} />
          TIMES
        </button>
      </div>
    </div>
  </div>

  {/* Content */}
  <div className="max-w-7xl mx-auto px-4 py-16">
    <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
      {activeTab === 'individual'
        ? individualCategories.map((cat, idx) => (
            <CategoryCard key={idx} category={cat} />
          ))
        : teamCategories.map((cat, idx) => (
            <CategoryCard key={idx} category={cat} />
          ))
      }
    </div>
  </div>

  {/* CTA Section */}
  <div className="bg-gradient-to-r from-cyan-600 to-blue-700 py-16 px-4">
    <div className="max-w-4xl mx-auto text-center text-white">
      <h2 className="text-4xl font-black mb-4">PRONTO PARA COMPETIR?</h2>
      <p className="text-xl mb-8 opacity-90">
        Confira se você atende aos standards da sua categoria e garanta sua vaga!
      </p>
      <div className="flex flex-col sm:flex-row gap-4 justify-center">
        <a
          href="<https://registration.digitalscore.com.br/qualifier2026/home>"
          target="_blank"
          rel="noopener noreferrer"
          className="bg-white text-blue-700 px-8 py-4 rounded-lg font-bold text-lg hover:bg-opacity-90 transition flex items-center justify-center gap-2"
        >
          INSCREVER-SE AGORA
          <ExternalLink size={20} />
        </a>
        <a
          href="/pre-requisitos"
          className="bg-transparent border-2 border-white text-white px-8 py-4 rounded-lg font-bold text-lg hover:bg-white hover:text-blue-700 transition"
        >
          VER PRÉ-REQUISITOS
        </a>
      </div>
    </div>
  </div>

  {/* Footer */}
  <footer className="bg-black text-white py-12 px-4 border-t border-gray-800">
    <div className="max-w-7xl mx-auto text-center">
      <div className="mb-6">
        <svg viewBox="0 0 60 60" className="w-16 h-16 mx-auto mb-4">
          <polygon
            points="30,5 36,24 54,24 39,36 45,54 30,42 15,54 21,36 6,24 24,24"
            fill="#FFD700"
          />
        </svg>
        <p className="text-2xl font-bold">MONSTAR GAMES</p>
      </div>

      <p className="text-gray-400 mb-4">
        © 2025 Monstar Games. Todos os direitos reservados.
      </p>

      <div className="flex justify-center gap-6">
        <a href="#" className="text-gray-400 hover:text-yellow-400 transition">Instagram</a>
        <a href="#" className="text-gray-400 hover:text-yellow-400 transition">Facebook</a>
        <a href="/contato" className="text-gray-400 hover:text-yellow-400 transition">Contato</a>
      </div>
    </div>
  </footer>
</div>

```

);
};

export default StandardsPage;