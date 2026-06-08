import { useNavigate, useLocation } from "react-router";
import { BookOpen, Grid3X3, TrendingUp, User, Search } from "lucide-react";

const tabs = [
  { path: "/", label: "Aprender", icon: BookOpen },
  { path: "/search", label: "Pesquisar", icon: Search },
  { path: "/apps", label: "Meus Apps", icon: Grid3X3 },
  { path: "/progress", label: "Progresso", icon: TrendingUp },
  { path: "/profile", label: "Perfil", icon: User },
];

export function BottomNav() {
  const navigate = useNavigate();
  const location = useLocation();

  const isActive = (path: string) => {
    if (path === "/") return location.pathname === "/";
    return location.pathname.startsWith(path);
  };

  return (
    <nav className="fixed bottom-0 left-0 right-0 bg-gray-800 border-t-4 border-yellow-400 z-50">
      <div className="flex">
        {tabs.map((tab) => {
          const Icon = tab.icon;
          const active = isActive(tab.path);
          return (
            <button
              key={tab.path}
              onClick={() => navigate(tab.path)}
              className={`flex-1 flex flex-col items-center justify-center py-3 gap-1 transition-all ${
                active ? "text-yellow-400 bg-gray-700" : "text-gray-400 hover:text-gray-200"
              }`}
            >
              <Icon size={28} strokeWidth={active ? 2.5 : 2} />
              <span className={`text-sm font-bold ${active ? "text-yellow-400" : "text-gray-400"}`}>
                {tab.label}
              </span>
            </button>
          );
        })}
      </div>
    </nav>
  );
}
