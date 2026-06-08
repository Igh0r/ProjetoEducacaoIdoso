import { useNavigate } from "react-router";
import { Smartphone, Heart, Palette, Languages, Landmark, Coins } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { categoriesData } from "../data/lessonsData";

const categoryIcons: Record<string, React.ElementType> = {
  technology: Smartphone,
  health: Heart,
  hobbies: Palette,
  languages: Languages,
  citizenship: Landmark,
  finance: Coins,
};

export function Home() {
  const navigate = useNavigate();
  const { user } = useAuth();

  const firstName = user?.name?.split(" ")[0] ?? "Bem-vindo";

  return (
    <div className="min-h-screen bg-gray-900 text-white">
      {/* Header */}
      <header className="bg-gray-800 border-b-4 border-yellow-400 p-6">
        <div className="max-w-4xl mx-auto">
          <h1 className="text-4xl font-bold">📚 Aprender é Viver</h1>
          <p className="text-yellow-400 text-2xl mt-1">
            Olá, {firstName}! 👋
          </p>
        </div>
      </header>

      {/* Main Content */}
      <main className="max-w-4xl mx-auto p-5">
        <div className="text-center mb-8">
          <h2 className="text-4xl font-bold mb-2">O que você quer aprender?</h2>
          <p className="text-xl text-gray-400">
            {categoriesData.reduce((t, c) => t + c.lessons.length, 0)} lições disponíveis
          </p>
        </div>

        {/* Categories Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
          {categoriesData.map((category) => {
            const Icon = categoryIcons[category.id] ?? Smartphone;
            return (
              <button
                key={category.id}
                onClick={() => navigate(`/category/${category.id}`)}
                className={`${category.color} rounded-3xl p-7 text-left transition transform hover:scale-105 shadow-2xl border-4 ${category.borderColor} border-opacity-50`}
              >
                <div className="flex items-start gap-4">
                  <div className="bg-white bg-opacity-20 rounded-2xl p-4 flex flex-col items-center gap-1 flex-shrink-0">
                    <span className="text-4xl">{category.emoji}</span>
                    <Icon size={32} strokeWidth={2.5} />
                  </div>
                  <div className="flex-1 min-w-0">
                    <h3 className="text-3xl font-bold mb-1">{category.name}</h3>
                    <p className="text-lg text-white text-opacity-90 mb-2">{category.description}</p>
                    <span className="bg-white bg-opacity-20 px-3 py-1 rounded-lg text-base font-bold">
                      {category.lessons.length} lições
                    </span>
                  </div>
                </div>
              </button>
            );
          })}
        </div>

        {/* Help Section */}
        <div className="mt-8 bg-yellow-400 text-gray-900 rounded-3xl p-7 text-center">
          <h3 className="text-3xl font-bold mb-2">💡 Tem uma dúvida?</h3>
          <p className="text-xl mb-5">
            Use o Assistente Digital para perguntar qualquer coisa!
          </p>
          <button
            onClick={() => navigate("/search")}
            className="bg-gray-900 text-white px-8 py-4 rounded-xl text-2xl font-bold hover:bg-gray-800 transition"
          >
            🤖 Perguntar ao Assistente
          </button>
        </div>
      </main>
    </div>
  );
}
