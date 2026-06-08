import { Trophy, Star, TrendingUp } from "lucide-react";

export function Progress() {
  const stats = [
    { label: "Lições completadas", value: "1", icon: Trophy, color: "bg-yellow-500" },
    { label: "Dias seguidos", value: "1", icon: Star, color: "bg-purple-500" },
    { label: "Progresso total", value: "5%", icon: TrendingUp, color: "bg-green-500" },
  ];

  const achievements = [
    { title: "Primeira lição!", description: "Completou sua primeira lição", unlocked: true, icon: "🎓" },
    { title: "Curioso", description: "Complete 5 lições", unlocked: false, icon: "🔍" },
    { title: "Dedicado", description: "7 dias seguidos estudando", unlocked: false, icon: "💪" },
    { title: "Mestre", description: "Complete todas as lições", unlocked: false, icon: "👑" },
  ];

  return (
    <div className="min-h-screen bg-gray-900 text-white">
      {/* Header */}
      <header className="bg-gradient-to-r from-blue-600 to-purple-600 p-6">
        <div className="max-w-6xl mx-auto">
          <h1 className="text-5xl font-bold">🏆 Meu Progresso</h1>
        </div>
      </header>

      <main className="max-w-6xl mx-auto p-8">
        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
          {stats.map((stat, index) => {
            const Icon = stat.icon;
            return (
              <div
                key={index}
                className={`${stat.color} rounded-2xl p-8 text-center`}
              >
                <Icon size={64} className="mx-auto mb-4" />
                <div className="text-6xl font-bold mb-2">{stat.value}</div>
                <div className="text-2xl">{stat.label}</div>
              </div>
            );
          })}
        </div>

        {/* Achievements */}
        <div className="bg-gray-800 rounded-3xl p-8">
          <h2 className="text-4xl font-bold mb-8 flex items-center gap-4">
            <Trophy size={48} className="text-yellow-400" />
            Conquistas
          </h2>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {achievements.map((achievement, index) => (
              <div
                key={index}
                className={`rounded-2xl p-6 border-4 ${
                  achievement.unlocked
                    ? "bg-gradient-to-br from-yellow-500 to-yellow-600 border-yellow-400"
                    : "bg-gray-700 border-gray-600 opacity-60"
                }`}
              >
                <div className="flex items-center gap-4">
                  <div className="text-6xl">{achievement.icon}</div>
                  <div className="flex-1">
                    <h3 className="text-3xl font-bold mb-2">
                      {achievement.title}
                    </h3>
                    <p className="text-xl">{achievement.description}</p>
                  </div>
                  {achievement.unlocked && (
                    <div className="text-4xl">✓</div>
                  )}
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Encouragement */}
        <div className="mt-12 bg-gradient-to-r from-green-500 to-blue-500 rounded-3xl p-10 text-center">
          <h3 className="text-4xl font-bold mb-4">Continue assim!</h3>
          <p className="text-2xl">
            Cada lição é um passo em direção a novos conhecimentos.
            <br />
            Você está indo muito bem!
          </p>
        </div>
      </main>
    </div>
  );
}
