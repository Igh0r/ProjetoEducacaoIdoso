import { useNavigate } from "react-router";
import { LogOut, User, Mail, BookOpen, Star } from "lucide-react";
import { useAuth } from "../context/AuthContext";

export function ProfilePage() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate("/login");
  };

  const initials = user?.name
    ? user.name
        .split(" ")
        .map((n) => n[0])
        .slice(0, 2)
        .join("")
        .toUpperCase()
    : "?";

  return (
    <div className="min-h-screen bg-gray-900 text-white">
      {/* Header */}
      <header className="bg-gradient-to-br from-yellow-500 to-yellow-400 p-10 text-center">
        <div className="flex justify-center mb-4">
          <div className="bg-gray-900 rounded-full w-32 h-32 flex items-center justify-center text-yellow-400 text-5xl font-extrabold shadow-2xl">
            {initials}
          </div>
        </div>
        <h1 className="text-gray-900 text-4xl font-extrabold">{user?.name}</h1>
        <p className="text-gray-800 text-xl mt-1">{user?.email}</p>
      </header>

      <main className="max-w-xl mx-auto p-6 space-y-6">
        {/* Info Cards */}
        <div className="bg-gray-800 rounded-3xl p-6 space-y-5">
          <h2 className="text-3xl font-bold mb-2">Meus Dados</h2>

          <div className="flex items-center gap-5 bg-gray-700 rounded-2xl p-5">
            <div className="bg-yellow-400 rounded-xl p-3">
              <User size={36} className="text-gray-900" />
            </div>
            <div>
              <p className="text-gray-400 text-lg">Nome</p>
              <p className="text-2xl font-bold">{user?.name}</p>
            </div>
          </div>

          <div className="flex items-center gap-5 bg-gray-700 rounded-2xl p-5">
            <div className="bg-blue-500 rounded-xl p-3">
              <Mail size={36} className="text-white" />
            </div>
            <div>
              <p className="text-gray-400 text-lg">E-mail</p>
              <p className="text-2xl font-bold break-all">{user?.email}</p>
            </div>
          </div>
        </div>

        {/* Quick Stats */}
        <div className="bg-gray-800 rounded-3xl p-6">
          <h2 className="text-3xl font-bold mb-4">Resumo</h2>
          <div className="grid grid-cols-2 gap-4">
            <div className="bg-purple-700 rounded-2xl p-5 text-center">
              <BookOpen size={40} className="mx-auto mb-2 text-white" />
              <div className="text-4xl font-extrabold">1</div>
              <div className="text-lg text-purple-200">Lições feitas</div>
            </div>
            <div className="bg-yellow-600 rounded-2xl p-5 text-center">
              <Star size={40} className="mx-auto mb-2 text-white" />
              <div className="text-4xl font-extrabold">1</div>
              <div className="text-lg text-yellow-100">Conquistas</div>
            </div>
          </div>
        </div>

        {/* Logout */}
        <button
          onClick={handleLogout}
          className="w-full bg-red-600 hover:bg-red-500 text-white text-3xl font-extrabold py-6 rounded-2xl flex items-center justify-center gap-4 transition shadow-xl"
        >
          <LogOut size={36} />
          Sair da Conta
        </button>
      </main>
    </div>
  );
}
