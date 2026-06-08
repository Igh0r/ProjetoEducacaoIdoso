import { useState } from "react";

interface AppItem {
  name: string;
  emoji: string;
  bg: string;
  label: string;
}

const appGroups: { title: string; apps: AppItem[] }[] = [
  {
    title: "📞 Comunicação",
    apps: [
      { name: "WhatsApp", emoji: "💬", bg: "bg-green-600", label: "WhatsApp" },
      { name: "Ligações", emoji: "📞", bg: "bg-green-500", label: "Ligar" },
      { name: "SMS", emoji: "✉️", bg: "bg-blue-500", label: "Mensagens" },
      { name: "E-mail", emoji: "📧", bg: "bg-blue-700", label: "E-mail" },
      { name: "Videochamada", emoji: "📹", bg: "bg-purple-600", label: "Vídeo" },
      { name: "Facebook", emoji: "👥", bg: "bg-blue-800", label: "Facebook" },
      { name: "Instagram", emoji: "📸", bg: "bg-pink-600", label: "Instagram" },
    ],
  },
  {
    title: "🎬 Entretenimento",
    apps: [
      { name: "YouTube", emoji: "▶️", bg: "bg-red-600", label: "YouTube" },
      { name: "Música", emoji: "🎵", bg: "bg-orange-600", label: "Música" },
      { name: "Rádio", emoji: "📻", bg: "bg-amber-600", label: "Rádio" },
      { name: "Fotos", emoji: "🖼️", bg: "bg-purple-500", label: "Fotos" },
      { name: "Câmera", emoji: "📷", bg: "bg-gray-600", label: "Câmera" },
    ],
  },
  {
    title: "🏦 Serviços",
    apps: [
      { name: "Banco", emoji: "🏦", bg: "bg-emerald-700", label: "Banco" },
      { name: "PIX", emoji: "⚡", bg: "bg-teal-600", label: "PIX" },
      { name: "Gov.br", emoji: "🏛️", bg: "bg-amber-700", label: "Gov.br" },
      { name: "INSS", emoji: "📋", bg: "bg-blue-700", label: "Meu INSS" },
      { name: "Correios", emoji: "📮", bg: "bg-yellow-600", label: "Correios" },
      { name: "Farmácia", emoji: "💊", bg: "bg-red-700", label: "Farmácia" },
    ],
  },
  {
    title: "🛠️ Utilitários",
    apps: [
      { name: "Mapas", emoji: "🗺️", bg: "bg-blue-500", label: "Mapas" },
      { name: "Calendário", emoji: "📅", bg: "bg-red-500", label: "Calendário" },
      { name: "Clima", emoji: "⛅", bg: "bg-sky-500", label: "Clima" },
      { name: "Calculadora", emoji: "🔢", bg: "bg-gray-700", label: "Calculadora" },
      { name: "Relógio", emoji: "⏰", bg: "bg-indigo-600", label: "Relógio" },
      { name: "Lanterna", emoji: "🔦", bg: "bg-yellow-500", label: "Lanterna" },
      { name: "Configurações", emoji: "⚙️", bg: "bg-gray-500", label: "Config." },
    ],
  },
  {
    title: "🚨 Emergência",
    apps: [
      { name: "SAMU 192", emoji: "🚑", bg: "bg-red-700", label: "SAMU 192" },
      { name: "Bombeiros 193", emoji: "🚒", bg: "bg-orange-700", label: "Bombeiros" },
      { name: "Polícia 190", emoji: "🚔", bg: "bg-blue-900", label: "Polícia 190" },
      { name: "CVV 188", emoji: "💙", bg: "bg-indigo-700", label: "CVV 188" },
    ],
  },
];

export function AppLauncher() {
  const [toast, setToast] = useState<string | null>(null);

  const handleAppPress = (app: AppItem) => {
    if (app.name === "SAMU 192") {
      setToast("📞 Ligue agora: 192 (SAMU)");
    } else if (app.name === "Bombeiros 193") {
      setToast("📞 Ligue agora: 193 (Bombeiros)");
    } else if (app.name === "Polícia 190") {
      setToast("📞 Ligue agora: 190 (Polícia)");
    } else if (app.name === "CVV 188") {
      setToast("📞 Ligue agora: 188 (CVV)");
    } else {
      setToast(`Abrindo ${app.name}...`);
    }
    setTimeout(() => setToast(null), 3000);
  };

  return (
    <div className="min-h-screen bg-gray-900 text-white">
      {/* Header */}
      <header className="bg-gray-800 border-b-4 border-yellow-400 p-6">
        <h1 className="text-4xl font-bold text-center">📱 Meus Aplicativos</h1>
        <p className="text-gray-400 text-xl text-center mt-1">
          Toque em um ícone para abrir
        </p>
      </header>

      {/* Toast */}
      {toast && (
        <div className="fixed top-6 left-1/2 -translate-x-1/2 z-50 bg-yellow-400 text-gray-900 px-8 py-4 rounded-2xl text-2xl font-bold shadow-2xl animate-bounce whitespace-nowrap">
          {toast}
        </div>
      )}

      <main className="p-5 space-y-8 pb-10">
        {appGroups.map((group) => (
          <section key={group.title}>
            {/* Group title */}
            <h2 className="text-2xl font-bold text-gray-300 mb-4 border-b-2 border-gray-700 pb-2">
              {group.title}
            </h2>

            {/* Apps grid */}
            <div className="grid grid-cols-4 sm:grid-cols-5 gap-4">
              {group.apps.map((app) => (
                <button
                  key={app.name}
                  onClick={() => handleAppPress(app)}
                  className="flex flex-col items-center gap-2 group"
                >
                  {/* Icon box */}
                  <div
                    className={`${app.bg} w-full aspect-square rounded-3xl flex items-center justify-center shadow-lg transition-all active:scale-95 group-hover:scale-105 group-hover:shadow-xl`}
                  >
                    <span
                      className="select-none leading-none"
                      style={{ fontSize: "clamp(2rem, 10vw, 3rem)" }}
                    >
                      {app.emoji}
                    </span>
                  </div>
                  {/* Label */}
                  <span className="text-white text-center leading-tight font-bold"
                    style={{ fontSize: "clamp(0.7rem, 3vw, 0.9rem)" }}
                  >
                    {app.label}
                  </span>
                </button>
              ))}
            </div>
          </section>
        ))}

        {/* Emergency tip */}
        <div className="bg-red-900 border-2 border-red-500 rounded-3xl p-6 text-center">
          <p className="text-2xl font-bold text-red-300 mb-2">🚨 Emergências</p>
          <div className="grid grid-cols-2 gap-3 text-xl font-bold">
            <div className="bg-red-800 rounded-xl py-3">🚑 SAMU: 192</div>
            <div className="bg-orange-800 rounded-xl py-3">🚒 Bombeiros: 193</div>
            <div className="bg-blue-900 rounded-xl py-3">👮 Polícia: 190</div>
            <div className="bg-indigo-900 rounded-xl py-3">💙 CVV: 188</div>
          </div>
          <p className="text-lg text-gray-300 mt-3">Todos gratuitos e disponíveis 24 horas</p>
        </div>
      </main>
    </div>
  );
}
