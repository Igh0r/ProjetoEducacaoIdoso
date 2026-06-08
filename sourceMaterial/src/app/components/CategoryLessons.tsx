import { useNavigate, useParams } from "react-router";
import { ArrowLeft, CheckCircle, Circle, Clock, BarChart2 } from "lucide-react";
import { categoriesData } from "../data/lessonsData";

export function CategoryLessons() {
  const navigate = useNavigate();
  const { categoryId } = useParams<{ categoryId: string }>();

  const category = categoriesData.find((c) => c.id === categoryId) ?? categoriesData[0];

  const headerBg =
    category.id === "technology"
      ? "bg-blue-700"
      : category.id === "health"
      ? "bg-red-700"
      : category.id === "hobbies"
      ? "bg-purple-700"
      : category.id === "languages"
      ? "bg-green-700"
      : category.id === "citizenship"
      ? "bg-amber-700"
      : "bg-teal-700";

  return (
    <div className="min-h-screen bg-gray-900 text-white">
      {/* Header */}
      <header className={`p-6 ${headerBg}`}>
        <div className="max-w-3xl mx-auto">
          <button
            onClick={() => navigate("/")}
            className="bg-white bg-opacity-20 hover:bg-opacity-30 px-5 py-3 rounded-xl text-2xl font-bold mb-4 flex items-center gap-3 transition"
          >
            <ArrowLeft size={28} />
            Voltar
          </button>
          <div className="flex items-center gap-4">
            <span className="text-6xl">{category.emoji}</span>
            <div>
              <h1 className="text-5xl font-bold">{category.name}</h1>
              <p className="text-xl text-white text-opacity-80 mt-1">{category.description}</p>
            </div>
          </div>
        </div>
      </header>

      {/* Lessons List */}
      <main className="max-w-3xl mx-auto p-5">
        <h2 className="text-3xl font-bold mb-6">
          {category.lessons.length} lições disponíveis
        </h2>

        <div className="space-y-4">
          {category.lessons.map((lesson, index) => (
            <button
              key={lesson.id}
              onClick={() => navigate(`/lesson/${lesson.id}`)}
              className={`w-full bg-gray-800 hover:bg-gray-700 rounded-2xl p-6 text-left transition border-4 ${
                lesson.completed ? "border-green-500" : "border-transparent hover:border-gray-600"
              }`}
            >
              <div className="flex items-start gap-5">
                {/* Step number */}
                <div
                  className={`flex-shrink-0 w-14 h-14 rounded-2xl flex items-center justify-center text-2xl font-extrabold ${
                    lesson.completed ? "bg-green-500 text-white" : "bg-gray-700 text-gray-300"
                  }`}
                >
                  {lesson.completed ? (
                    <CheckCircle size={32} className="text-white" />
                  ) : (
                    <span>{index + 1}</span>
                  )}
                </div>

                {/* Content */}
                <div className="flex-1 min-w-0">
                  <h3 className="text-2xl font-bold mb-1 leading-snug">{lesson.title}</h3>
                  <p className="text-lg text-gray-400 mb-3">{lesson.description}</p>
                  <div className="flex flex-wrap gap-2">
                    <span className="bg-gray-700 px-3 py-1 rounded-lg text-base flex items-center gap-1">
                      <Clock size={16} />
                      {lesson.duration}
                    </span>
                    <span
                      className={`px-3 py-1 rounded-lg text-base font-bold flex items-center gap-1 ${
                        lesson.difficulty === "Fácil"
                          ? "bg-green-800 text-green-200"
                          : lesson.difficulty === "Médio"
                          ? "bg-yellow-800 text-yellow-200"
                          : "bg-red-800 text-red-200"
                      }`}
                    >
                      <BarChart2 size={16} />
                      {lesson.difficulty}
                    </span>
                    {lesson.videoSearchQuery && (
                      <span className="bg-red-900 text-red-200 px-3 py-1 rounded-lg text-base">
                        🎬 Vídeo
                      </span>
                    )}
                    <span className="bg-gray-700 text-gray-300 px-3 py-1 rounded-lg text-base">
                      {lesson.steps.length} passos
                    </span>
                  </div>
                </div>

                {/* Status */}
                <div className="flex-shrink-0 mt-1">
                  {lesson.completed ? (
                    <span className="bg-green-600 text-white px-4 py-2 rounded-xl text-lg font-bold">
                      ✓ Feito
                    </span>
                  ) : (
                    <Circle size={32} className="text-gray-500" />
                  )}
                </div>
              </div>
            </button>
          ))}
        </div>
      </main>
    </div>
  );
}
