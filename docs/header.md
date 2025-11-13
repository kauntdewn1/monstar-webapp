import React, { useState } from 'react';
import { Menu, X, ChevronDown, Dumbbell, Users, Trophy, FileText, MapPin, Calendar, ExternalLink } from 'lucide-react';

// Header Component
const Header = () => {
const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
const [activeDropdown, setActiveDropdown] = useState(null);

const menuItems = [
{
label: 'QUALIFIER',
items: [
{ name: 'Inscrições', href: 'https://registration.digitalscore.com.br/qualifier2026/home', external: true },
{ name: 'Leaderboard', href: '/leaderboard' },
{ name: 'Painel do Atleta', href: 'https://panel.digitalscore.com.br/', external: true },
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
{ name: 'Formulário Staff', href: 'https://docs.google.com/forms/d/e/1FAIpQLSceP-CIW9lY24rUg-Dsd11WJk0vdSBnsBMWgE8TdBtPlJ47ug/viewform', external: true },
{ name: 'Judges', href: 'https://www.e-inscricao.com/arbitrosdigitalscore/monstargames2023', external: true }
]
}
];

return (
<>
{/* Top Bar */}
<div className="bg-gradient-to-r from-pink-600 to-purple-700 text-white py-2 text-center text-sm font-medium">
<span className="animate-pulse">🔥 INSCRIÇÕES ABERTAS • QUALIFIER 2025/26</span>
</div>

```
  {/* Main Header */}
  <header className="bg-black/95 backdrop-blur-sm sticky top-0 z-50 border-b border-gray-800">
    <div className="max-w-7xl mx-auto px-4">
      <div className="flex items-center justify-between h-20">
        {/* Logo */}
        <a href="/" className="flex items-center gap-3 group">
          <svg viewBox="0 0 50 50" className="w-12 h-12 group-hover:scale-110 transition-transform">
            <polygon
              points="25,5 30,20 45,20 32,30 37,45 25,35 13,45 18,30 5,20 20,20"
              fill="#FFD700"
              stroke="#000"
              strokeWidth="2"
            />
            <text x="25" y="30" textAnchor="middle" fill="#000" fontSize="14" fontWeight="bold">M</text>
          </svg>
          <div className="text-white">
            <div className="text-2xl font-black tracking-wider">MONSTAR</div>
            <div className="text-xs tracking-widest text-yellow-400">GAMES</div>
          </div>
        </a>

        {/* Desktop Menu */}
        <nav className="hidden lg:flex items-center gap-1">
          {menuItems.map((item, idx) => (
            <div
              key={idx}
              className="relative group"
              onMouseEnter={() => setActiveDropdown(idx)}
              onMouseLeave={() => setActiveDropdown(null)}
            >
              {item.items ? (
                <>
                  <button className="px-4 py-2 text-white text-sm font-bold hover:text-yellow-400 transition flex items-center gap-1">
                    {item.label}
                    <ChevronDown size={16} />
                  </button>

                  {/* Dropdown */}
                  <div className={`absolute top-full left-0 bg-gray-900 border border-gray-700 rounded-lg shadow-2xl min-w-[220px] transition-all ${activeDropdown === idx ? 'opacity-100 visible translate-y-0' : 'opacity-0 invisible -translate-y-2'}`}>
                    {item.items.map((subItem, subIdx) => (
                      <a
                        key={subIdx}
                        href={subItem.href}
                        target={subItem.external ? '_blank' : '_self'}
                        rel={subItem.external ? 'noopener noreferrer' : ''}
                        className="block px-4 py-3 text-white text-sm hover:bg-yellow-500 hover:text-black transition first:rounded-t-lg last:rounded-b-lg flex items-center justify-between"
                      >
                        {subItem.name}
                        {subItem.external && <ExternalLink size={14} />}
                      </a>
                    ))}
                  </div>
                </>
              ) : (
                <a
                  href={item.href}
                  className="px-4 py-2 text-white text-sm font-bold hover:text-yellow-400 transition"
                >
                  {item.label}
                </a>
              )}
            </div>
          ))}
        </nav>

        {/* CTA Button */}
        <a
          href="<https://registration.digitalscore.com.br/qualifier2026/home>"
          target="_blank"
          rel="noopener noreferrer"
          className="hidden lg:block bg-gradient-to-r from-cyan-500 to-blue-600 text-white px-6 py-2 rounded-lg font-bold hover:shadow-lg hover:shadow-cyan-500/50 transition"
        >
          INSCREVER-SE
        </a>

        {/* Mobile Menu Button */}
        <button
          onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
          className="lg:hidden text-white p-2"
        >
          {mobileMenuOpen ? <X size={28} /> : <Menu size={28} />}
        </button>
      </div>
    </div>

    {/* Mobile Menu */}
    {mobileMenuOpen && (
      <div className="lg:hidden bg-gray-900 border-t border-gray-800">
        <nav className="px-4 py-4 space-y-1">
          {menuItems.map((item, idx) => (
            <div key={idx}>
              {item.items ? (
                <>
                  <button
                    onClick={() => setActiveDropdown(activeDropdown === idx ? null : idx)}
                    className="w-full text-left px-4 py-3 text-white font-bold hover:bg-gray-800 rounded flex items-center justify-between"
                  >
                    {item.label}
                    <ChevronDown size={18} className={`transition-transform ${activeDropdown === idx ? 'rotate-180' : ''}`} />
                  </button>

                  {activeDropdown === idx && (
                    <div className="ml-4 mt-1 space-y-1">
                      {item.items.map((subItem, subIdx) => (
                        <a
                          key={subIdx}
                          href={subItem.href}
                          target={subItem.external ? '_blank' : '_self'}
                          className="block px-4 py-2 text-gray-300 text-sm hover:text-yellow-400 hover:bg-gray-800 rounded"
                        >
                          {subItem.name}
                        </a>
                      ))}
                    </div>
                  )}
                </>
              ) : (
                <a
                  href={item.href}
                  className="block px-4 py-3 text-white font-bold hover:bg-gray-800 rounded"
                >
                  {item.label}
                </a>
              )}
            </div>
          ))}

          <a
            href="<https://registration.digitalscore.com.br/qualifier2026/home>"
            target="_blank"
            rel="noopener noreferrer"
            className="block mt-4 bg-cyan-500 text-white text-center px-6 py-3 rounded-lg font-bold"
          >
            INSCREVER-SE
          </a>
        </nav>
      </div>
    )}
  </header>
</>

```

);
};