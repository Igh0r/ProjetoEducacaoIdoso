import { useNavigate, useParams } from "react-router";
import {
  ArrowLeft,
  CheckCircle,
  XCircle,
  Lightbulb,
  AlertTriangle,
  PlayCircle,
  Brain,
  Trophy,
  ChevronRight,
} from "lucide-react";
import { useState } from "react";
import { allLessonsMap } from "../data/lessonsData";
import { quizData } from "../data/quizData";

type Phase = "steps" | "quiz-intro" | "quiz" | "completed";

export function Lesson() {
  const navigate = useNavigate();
  const { lessonId } = useParams<{ lessonId: string }>();

  const lesson = lessonId ? allLessonsMap[lessonId] : null;
  const quiz = lessonId ? (quizData[lessonId] ?? []) : [];

  const [phase, setPhase] = useState<Phase>("steps");
  const [currentStep, setCurrentStep] = useState(0);
  const [quizStep, setQuizStep] = useState(0);
  const [selected, setSelected] = useState<number | null>(null);
  const [showFeedback, setShowFeedback] = useState(false);
  const [correctCount, setCorrectCount] = useState(0);

  if (!lesson) {
    return (
      <div className="min-h-screen bg-gray-900 text-white flex items-center justify-center p-8">
        <div className="text-center">
          <div className="text-8xl mb-6">😕</div>
          <h1 className="text-4xl font-bold mb-4">Lição não encontrada</h1>
          <button
            onClick={() => navigate("/")}
            className="bg-yellow-400 text-gray-900 px-8 py-4 rounded-xl text-2xl font-bold"
          >
            Voltar ao início
          </button>
        </div>
      </div>
    );
  }

  const totalSteps = lesson.steps.length;
  const totalQuestions = quiz.length;
  const currentQuestion = quiz[quizStep];

  const openVideo = () => {
    if (lesson.videoSearchQuery) {
      const q = encodeURIComponent(lesson.videoSearchQuery);
      window.open(`https://www.youtube.com/results?search_query=${q}`, "_blank");
    }
  };

  const handleStepNext = () => {
    if (currentStep < totalSteps - 1) {
      setCurrentStep(currentStep + 1);
    } else if (totalQuestions > 0) {
      setPhase("quiz-intro");
    } else {
      setPhase("completed");
    }
  };

  const handleOptionSelect = (idx: number) => {
    if (showFeedback) return;
    setSelected(idx);
    setShowFeedback(true);
    if (idx === currentQuestion.correctIndex) {
      setCorrectCount((c) => c + 1);
    }
  };

  const handleNextQuestion = () => {
    setSelected(null);
    setShowFeedback(false);
    if (quizStep < totalQuestions - 1) {
      setQuizStep(quizStep + 1);
    } else {
      setPhase("completed");
    }
  };

  // ── COMPLETED ──────────────────────────────────────────────────────────────
  if (phase === "completed") {
    const pct = totalQuestions > 0 ? Math.round((correctCount / totalQuestions) * 100) : 100;
    const allCorrect = pct === 100;
    const mostCorrect = pct >= 60;

    return (
      <div className="min-h-screen bg-gray-900 text-white flex flex-col items-center justify-center p-8">
        <div className="text-center w-full max-w-xl">
          <div className="text-9xl mb-4">{allCorrect ? "🏆" : mostCorrect ? "⭐" : "💪"}</div>
          <h1 className="text-5xl font-bold mb-3">
            {allCorrect ? "Perfeito!" : mostCorrect ? "Muito bem!" : "Continue assim!"}
          </h1>
          <p className="text-3xl text-gray-300 mb-2">Você completou:</p>
          <p className="text-3xl font-bold text-yellow-400 mb-6">{lesson.title}</p>

          {totalQuestions > 0 && (
            <div className="bg-gray-800 rounded-3xl p-6 mb-6">
              <p className="text-2xl font-bold mb-3">Resultado do quiz:</p>
              <div className="text-6xl font-extrabold text-yellow-400 mb-2">
                {correctCount}/{totalQuestions}
              </div>
              <div className="bg-gray-700 rounded-full h-5 overflow-hidden mb-3">
                <div
                  className="h-full transition-all duration-700"
                  style={{
                    width: `${pct}%`,
                    background: pct === 100 ? "#22c55e" : pct >= 60 ? "#eab308" : "#ef4444",
                  }}
                />
              </div>
              <p className="text-xl text-gray-300">
                {allCorrect
                  ? "Você acertou tudo — excelente memória! 🎉"
                  : mostCorrect
                  ? "Bom resultado! Revise os erros e tente novamente."
                  : "Não desanime! Releia a lição e tente o quiz novamente."}
              </p>
            </div>
          )}

          {lesson.videoSearchQuery && (
            <button
              onClick={openVideo}
              className="w-full bg-red-700 hover:bg-red-600 text-white py-5 rounded-2xl text-2xl font-bold flex items-center justify-center gap-3 mb-4 transition"
            >
              <PlayCircle size={32} />
              🎬 Ver tutorial em vídeo no YouTube
            </button>
          )}

          {totalQuestions > 0 && !allCorrect && (
            <button
              onClick={() => {
                setQuizStep(0);
                setSelected(null);
                setShowFeedback(false);
                setCorrectCount(0);
                setPhase("quiz-intro");
              }}
              className="w-full bg-blue-600 hover:bg-blue-500 text-white py-5 rounded-2xl text-2xl font-bold flex items-center justify-center gap-3 mb-4 transition"
            >
              <Brain size={32} />
              Refazer o quiz
            </button>
          )}

          <button
            onClick={() => navigate(-1)}
            className="w-full bg-green-500 hover:bg-green-600 text-white py-6 rounded-2xl text-2xl font-bold transition"
          >
            ← Voltar para as lições
          </button>
        </div>
      </div>
    );
  }

  // ── QUIZ INTRO ─────────────────────────────────────────────────────────────
  if (phase === "quiz-intro") {
    return (
      <div className="min-h-screen bg-gray-900 text-white flex flex-col items-center justify-center p-8">
        <div className="text-center w-full max-w-xl">
          <div className="text-8xl mb-5">🧠</div>
          <h1 className="text-5xl font-bold mb-3">Hora do Quiz!</h1>
          <p className="text-2xl text-gray-300 mb-2">
            Você completou todos os passos!
          </p>
          <p className="text-2xl text-gray-300 mb-8">
            Vamos testar o que você aprendeu com{" "}
            <span className="text-yellow-400 font-bold">{totalQuestions} perguntas</span>.
          </p>
          <div className="bg-gray-800 rounded-3xl p-6 mb-8 text-left space-y-3">
            <p className="text-xl text-gray-300 flex items-center gap-3">
              <span className="text-2xl">✅</span> Escolha a resposta certa tocando nela
            </p>
            <p className="text-xl text-gray-300 flex items-center gap-3">
              <span className="text-2xl">💡</span> Você vai ver a explicação após cada resposta
            </p>
            <p className="text-xl text-gray-300 flex items-center gap-3">
              <span className="text-2xl">🔄</span> Pode refazer o quiz quantas vezes quiser
            </p>
          </div>
          <button
            onClick={() => setPhase("quiz")}
            className="w-full bg-yellow-400 hover:bg-yellow-300 text-gray-900 py-6 rounded-2xl text-3xl font-extrabold flex items-center justify-center gap-3 mb-4 transition"
          >
            <Brain size={36} />
            Começar o Quiz!
          </button>
          <button
            onClick={() => setPhase("completed")}
            className="w-full bg-gray-700 hover:bg-gray-600 text-gray-300 py-4 rounded-2xl text-xl transition"
          >
            Pular quiz e concluir
          </button>
        </div>
      </div>
    );
  }

  // ── QUIZ ───────────────────────────────────────────────────────────────────
  if (phase === "quiz") {
    const isCorrect = selected === currentQuestion.correctIndex;

    return (
      <div className="min-h-screen bg-gray-900 text-white">
        {/* Header */}
        <header className="bg-gray-800 border-b-4 border-yellow-400 p-5">
          <div className="max-w-2xl mx-auto flex items-center justify-between">
            <div className="flex items-center gap-3">
              <Brain size={32} className="text-yellow-400" />
              <span className="text-2xl font-bold text-yellow-400">Quiz</span>
            </div>
            <span className="text-2xl text-gray-300 font-bold">
              {quizStep + 1} / {totalQuestions}
            </span>
          </div>
          {/* Progress */}
          <div className="max-w-2xl mx-auto mt-3 bg-gray-700 rounded-full h-4 overflow-hidden">
            <div
              className="bg-yellow-400 h-full transition-all duration-500"
              style={{ width: `${((quizStep + 1) / totalQuestions) * 100}%` }}
            />
          </div>
        </header>

        <main className="max-w-2xl mx-auto p-5 space-y-5">
          {/* Question */}
          <div className="bg-gray-800 rounded-3xl p-7">
            <p className="text-3xl font-bold leading-snug text-center">
              {currentQuestion.question}
            </p>
          </div>

          {/* Options */}
          <div className="space-y-4">
            {currentQuestion.options.map((opt, idx) => {
              let style =
                "w-full bg-gray-800 border-4 border-gray-700 hover:border-yellow-400 hover:bg-gray-700 text-left rounded-2xl p-6 text-2xl font-bold transition";

              if (showFeedback) {
                if (idx === currentQuestion.correctIndex) {
                  style =
                    "w-full bg-green-800 border-4 border-green-400 text-left rounded-2xl p-6 text-2xl font-bold";
                } else if (idx === selected && !isCorrect) {
                  style =
                    "w-full bg-red-800 border-4 border-red-500 text-left rounded-2xl p-6 text-2xl font-bold";
                } else {
                  style =
                    "w-full bg-gray-800 border-4 border-gray-700 text-left rounded-2xl p-6 text-2xl font-bold opacity-40";
                }
              }

              return (
                <button
                  key={idx}
                  onClick={() => handleOptionSelect(idx)}
                  disabled={showFeedback}
                  className={style}
                >
                  <div className="flex items-center gap-4">
                    <span
                      className={`flex-shrink-0 w-10 h-10 rounded-xl flex items-center justify-center text-xl font-extrabold ${
                        showFeedback && idx === currentQuestion.correctIndex
                          ? "bg-green-500 text-white"
                          : showFeedback && idx === selected && !isCorrect
                          ? "bg-red-500 text-white"
                          : "bg-gray-700 text-gray-300"
                      }`}
                    >
                      {String.fromCharCode(65 + idx)}
                    </span>
                    <span className="flex-1">{opt}</span>
                    {showFeedback && idx === currentQuestion.correctIndex && (
                      <CheckCircle size={28} className="text-green-400 flex-shrink-0" />
                    )}
                    {showFeedback && idx === selected && !isCorrect && (
                      <XCircle size={28} className="text-red-400 flex-shrink-0" />
                    )}
                  </div>
                </button>
              );
            })}
          </div>

          {/* Feedback box */}
          {showFeedback && (
            <div
              className={`rounded-3xl p-6 border-4 ${
                isCorrect
                  ? "bg-green-900 border-green-500"
                  : "bg-orange-900 border-orange-500"
              }`}
            >
              <p className="text-2xl font-bold mb-2">
                {isCorrect ? "✅ Correto! Muito bem!" : "❌ Quase lá!"}
              </p>
              <p className="text-xl text-gray-200 leading-relaxed">
                {currentQuestion.explanation}
              </p>
            </div>
          )}

          {/* Next button */}
          {showFeedback && (
            <button
              onClick={handleNextQuestion}
              className="w-full bg-yellow-400 hover:bg-yellow-300 text-gray-900 py-6 rounded-2xl text-2xl font-extrabold flex items-center justify-center gap-3 transition"
            >
              {quizStep < totalQuestions - 1 ? (
                <>
                  Próxima pergunta <ChevronRight size={32} />
                </>
              ) : (
                <>
                  Ver resultado <Trophy size={32} />
                </>
              )}
            </button>
          )}
        </main>
      </div>
    );
  }

  // ── STEPS ──────────────────────────────────────────────────────────────────
  const step = lesson.steps[currentStep];
  const progressPercent = ((currentStep + 1) / totalSteps) * 100;

  return (
    <div className="min-h-screen bg-gray-900 text-white">
      {/* Header */}
      <header className="bg-gray-800 p-5 border-b-4 border-blue-500">
        <div className="max-w-3xl mx-auto">
          <button
            onClick={() => navigate(-1)}
            className="bg-white bg-opacity-20 hover:bg-opacity-30 px-5 py-3 rounded-xl text-xl font-bold mb-4 flex items-center gap-3 transition"
          >
            <ArrowLeft size={28} />
            Voltar
          </button>
          <h1 className="text-3xl font-bold mb-3">{lesson.title}</h1>

          <div className="bg-gray-700 rounded-full h-5 overflow-hidden mb-2">
            <div
              className="bg-blue-500 h-full transition-all duration-500"
              style={{ width: `${progressPercent}%` }}
            />
          </div>
          <div className="flex justify-between items-center">
            <p className="text-xl text-gray-300">
              Passo {currentStep + 1} de {totalSteps}
            </p>
            <div className="flex gap-2 items-center">
              <span className="bg-gray-700 px-3 py-1 rounded-lg text-lg">
                ⏱ {lesson.duration}
              </span>
              {totalQuestions > 0 && (
                <span className="bg-yellow-700 text-yellow-200 px-3 py-1 rounded-lg text-lg flex items-center gap-1">
                  <Brain size={16} />
                  {totalQuestions} perguntas
                </span>
              )}
            </div>
          </div>
        </div>
      </header>

      {/* Step dots */}
      <div className="bg-gray-800 py-3 px-5">
        <div className="max-w-3xl mx-auto flex gap-2 justify-center flex-wrap">
          {lesson.steps.map((_, idx) => (
            <button
              key={idx}
              onClick={() => setCurrentStep(idx)}
              className={`w-5 h-5 rounded-full transition-all ${
                idx < currentStep
                  ? "bg-green-500"
                  : idx === currentStep
                  ? "bg-blue-400 scale-125"
                  : "bg-gray-600"
              }`}
            />
          ))}
        </div>
      </div>

      {/* Content */}
      <main className="max-w-3xl mx-auto p-5 space-y-4">
        <div className="bg-gray-800 rounded-3xl p-8">
          <div className="text-center mb-6">
            <div className="text-8xl mb-4">{step.image}</div>
            <h2 className="text-4xl font-bold">{step.title}</h2>
          </div>

          <div className="bg-gray-700 rounded-2xl p-6 mb-4">
            <p className="text-2xl leading-relaxed text-center">{step.content}</p>
          </div>

          {step.tip && (
            <div className="bg-blue-900 border-2 border-blue-400 rounded-2xl p-5 flex gap-4 items-start mb-3">
              <Lightbulb size={32} className="text-blue-300 flex-shrink-0 mt-1" />
              <p className="text-xl text-blue-100">{step.tip}</p>
            </div>
          )}

          {step.warning && (
            <div className="bg-red-900 border-2 border-red-500 rounded-2xl p-5 flex gap-4 items-start">
              <AlertTriangle size={32} className="text-red-300 flex-shrink-0 mt-1" />
              <p className="text-xl text-red-100 font-bold">{step.warning}</p>
            </div>
          )}
        </div>

        {/* Video button on last step */}
        {lesson.videoSearchQuery && currentStep === totalSteps - 1 && (
          <button
            onClick={openVideo}
            className="w-full bg-red-700 hover:bg-red-600 text-white py-5 rounded-2xl text-2xl font-bold flex items-center justify-center gap-3 transition"
          >
            <PlayCircle size={32} />
            🎬 Ver tutorial em vídeo no YouTube
          </button>
        )}

        {/* Navigation */}
        <div className="flex gap-4 pb-4">
          <button
            onClick={() => setCurrentStep((s) => s - 1)}
            disabled={currentStep === 0}
            className={`flex-1 py-6 rounded-2xl text-2xl font-bold transition ${
              currentStep === 0
                ? "bg-gray-700 text-gray-500 cursor-not-allowed"
                : "bg-gray-700 hover:bg-gray-600 text-white"
            }`}
          >
            ← Anterior
          </button>
          <button
            onClick={handleStepNext}
            className="flex-1 bg-green-500 hover:bg-green-600 text-white py-6 rounded-2xl text-2xl font-bold transition"
          >
            {currentStep === totalSteps - 1
              ? totalQuestions > 0
                ? "Ir para o Quiz 🧠"
                : "Concluir ✓"
              : "Próximo →"}
          </button>
        </div>
      </main>
    </div>
  );
}
