import { useState } from "react";
import { useNavigate } from "react-router";
import { Eye, EyeOff, BookOpen, UserPlus, LogIn } from "lucide-react";
import { useAuth } from "../context/AuthContext";

type Tab = "login" | "register";

export function Login() {
  const navigate = useNavigate();
  const { login } = useAuth();
  const [tab, setTab] = useState<Tab>("login");

  // Login fields
  const [loginEmail, setLoginEmail] = useState("");
  const [loginPassword, setLoginPassword] = useState("");
  const [showLoginPass, setShowLoginPass] = useState(false);
  const [loginError, setLoginError] = useState("");

  // Register fields
  const [regName, setRegName] = useState("");
  const [regEmail, setRegEmail] = useState("");
  const [regPassword, setRegPassword] = useState("");
  const [regConfirm, setRegConfirm] = useState("");
  const [showRegPass, setShowRegPass] = useState(false);
  const [regError, setRegError] = useState("");

  const handleLogin = () => {
    setLoginError("");
    if (!loginEmail.trim() || !loginPassword.trim()) {
      setLoginError("Por favor, preencha todos os campos.");
      return;
    }
    const stored = localStorage.getItem("aprender_accounts");
    const accounts: { name: string; email: string; password: string }[] = stored
      ? JSON.parse(stored)
      : [];
    const found = accounts.find(
      (a) => a.email.toLowerCase() === loginEmail.toLowerCase().trim() && a.password === loginPassword
    );
    if (!found) {
      setLoginError("E-mail ou senha incorretos. Verifique e tente novamente.");
      return;
    }
    login({ name: found.name, email: found.email });
    navigate("/");
  };

  const handleRegister = () => {
    setRegError("");
    if (!regName.trim() || !regEmail.trim() || !regPassword.trim() || !regConfirm.trim()) {
      setRegError("Por favor, preencha todos os campos.");
      return;
    }
    if (regPassword !== regConfirm) {
      setRegError("As senhas não são iguais. Tente novamente.");
      return;
    }
    if (regPassword.length < 4) {
      setRegError("A senha deve ter pelo menos 4 caracteres.");
      return;
    }
    const stored = localStorage.getItem("aprender_accounts");
    const accounts: { name: string; email: string; password: string }[] = stored
      ? JSON.parse(stored)
      : [];
    if (accounts.find((a) => a.email.toLowerCase() === regEmail.toLowerCase().trim())) {
      setRegError("Este e-mail já está cadastrado. Faça login.");
      return;
    }
    accounts.push({ name: regName.trim(), email: regEmail.toLowerCase().trim(), password: regPassword });
    localStorage.setItem("aprender_accounts", JSON.stringify(accounts));
    login({ name: regName.trim(), email: regEmail.toLowerCase().trim() });
    navigate("/");
  };

  return (
    <div className="min-h-screen bg-gray-900 text-white flex flex-col">
      {/* Hero Header */}
      <div className="bg-gradient-to-br from-yellow-500 to-yellow-400 py-12 px-6 text-center">
        <div className="flex justify-center mb-4">
          <div className="bg-gray-900 rounded-3xl p-6 shadow-2xl">
            <BookOpen size={72} className="text-yellow-400" strokeWidth={2} />
          </div>
        </div>
        <h1 className="text-gray-900 text-5xl font-extrabold mb-2">Aprender é Viver</h1>
        <p className="text-gray-800 text-2xl">Seu companheiro de aprendizado</p>
      </div>

      {/* Tab Switcher */}
      <div className="flex mx-6 mt-8 bg-gray-800 rounded-2xl p-2 gap-2">
        <button
          onClick={() => { setTab("login"); setLoginError(""); }}
          className={`flex-1 flex items-center justify-center gap-3 py-5 rounded-xl text-2xl font-bold transition-all ${
            tab === "login"
              ? "bg-yellow-400 text-gray-900 shadow-lg"
              : "text-gray-300 hover:text-white"
          }`}
        >
          <LogIn size={28} />
          Entrar
        </button>
        <button
          onClick={() => { setTab("register"); setRegError(""); }}
          className={`flex-1 flex items-center justify-center gap-3 py-5 rounded-xl text-2xl font-bold transition-all ${
            tab === "register"
              ? "bg-yellow-400 text-gray-900 shadow-lg"
              : "text-gray-300 hover:text-white"
          }`}
        >
          <UserPlus size={28} />
          Cadastrar
        </button>
      </div>

      {/* Forms */}
      <div className="flex-1 mx-6 mt-6 mb-8">
        {tab === "login" ? (
          <div className="bg-gray-800 rounded-3xl p-8 space-y-6">
            <h2 className="text-4xl font-bold text-center mb-2">Bem-vindo de volta!</h2>
            <p className="text-gray-300 text-xl text-center mb-6">Digite seus dados para entrar</p>

            <div>
              <label className="block text-2xl font-bold mb-3">✉️ Seu E-mail</label>
              <input
                type="email"
                value={loginEmail}
                onChange={(e) => setLoginEmail(e.target.value)}
                placeholder="exemplo@email.com"
                className="w-full bg-gray-700 text-white text-2xl p-5 rounded-2xl border-2 border-gray-600 focus:border-yellow-400 focus:outline-none placeholder-gray-400"
              />
            </div>

            <div>
              <label className="block text-2xl font-bold mb-3">🔒 Senha</label>
              <div className="relative">
                <input
                  type={showLoginPass ? "text" : "password"}
                  value={loginPassword}
                  onChange={(e) => setLoginPassword(e.target.value)}
                  placeholder="Sua senha"
                  className="w-full bg-gray-700 text-white text-2xl p-5 rounded-2xl border-2 border-gray-600 focus:border-yellow-400 focus:outline-none placeholder-gray-400 pr-20"
                />
                <button
                  onClick={() => setShowLoginPass(!showLoginPass)}
                  className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-300 hover:text-white p-2"
                >
                  {showLoginPass ? <EyeOff size={32} /> : <Eye size={32} />}
                </button>
              </div>
            </div>

            {loginError && (
              <div className="bg-red-900 border-2 border-red-500 rounded-2xl p-4 text-xl text-center">
                ⚠️ {loginError}
              </div>
            )}

            <button
              onClick={handleLogin}
              className="w-full bg-yellow-400 hover:bg-yellow-300 text-gray-900 text-3xl font-extrabold py-6 rounded-2xl transition shadow-xl mt-4"
            >
              Entrar →
            </button>

            <p className="text-center text-xl text-gray-400 mt-4">
              Ainda não tem conta?{" "}
              <button
                onClick={() => setTab("register")}
                className="text-yellow-400 font-bold underline"
              >
                Cadastre-se aqui
              </button>
            </p>
          </div>
        ) : (
          <div className="bg-gray-800 rounded-3xl p-8 space-y-6">
            <h2 className="text-4xl font-bold text-center mb-2">Criar nova conta</h2>
            <p className="text-gray-300 text-xl text-center mb-6">É rápido e gratuito!</p>

            <div>
              <label className="block text-2xl font-bold mb-3">👤 Seu Nome</label>
              <input
                type="text"
                value={regName}
                onChange={(e) => setRegName(e.target.value)}
                placeholder="Como podemos te chamar?"
                className="w-full bg-gray-700 text-white text-2xl p-5 rounded-2xl border-2 border-gray-600 focus:border-yellow-400 focus:outline-none placeholder-gray-400"
              />
            </div>

            <div>
              <label className="block text-2xl font-bold mb-3">✉️ Seu E-mail</label>
              <input
                type="email"
                value={regEmail}
                onChange={(e) => setRegEmail(e.target.value)}
                placeholder="exemplo@email.com"
                className="w-full bg-gray-700 text-white text-2xl p-5 rounded-2xl border-2 border-gray-600 focus:border-yellow-400 focus:outline-none placeholder-gray-400"
              />
            </div>

            <div>
              <label className="block text-2xl font-bold mb-3">🔒 Criar Senha</label>
              <div className="relative">
                <input
                  type={showRegPass ? "text" : "password"}
                  value={regPassword}
                  onChange={(e) => setRegPassword(e.target.value)}
                  placeholder="Mínimo 4 caracteres"
                  className="w-full bg-gray-700 text-white text-2xl p-5 rounded-2xl border-2 border-gray-600 focus:border-yellow-400 focus:outline-none placeholder-gray-400 pr-20"
                />
                <button
                  onClick={() => setShowRegPass(!showRegPass)}
                  className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-300 hover:text-white p-2"
                >
                  {showRegPass ? <EyeOff size={32} /> : <Eye size={32} />}
                </button>
              </div>
            </div>

            <div>
              <label className="block text-2xl font-bold mb-3">🔒 Confirmar Senha</label>
              <input
                type="password"
                value={regConfirm}
                onChange={(e) => setRegConfirm(e.target.value)}
                placeholder="Repita a senha"
                className="w-full bg-gray-700 text-white text-2xl p-5 rounded-2xl border-2 border-gray-600 focus:border-yellow-400 focus:outline-none placeholder-gray-400"
              />
            </div>

            {regError && (
              <div className="bg-red-900 border-2 border-red-500 rounded-2xl p-4 text-xl text-center">
                ⚠️ {regError}
              </div>
            )}

            <button
              onClick={handleRegister}
              className="w-full bg-yellow-400 hover:bg-yellow-300 text-gray-900 text-3xl font-extrabold py-6 rounded-2xl transition shadow-xl mt-4"
            >
              Criar Minha Conta →
            </button>

            <p className="text-center text-xl text-gray-400 mt-4">
              Já tem conta?{" "}
              <button
                onClick={() => setTab("login")}
                className="text-yellow-400 font-bold underline"
              >
                Entrar aqui
              </button>
            </p>
          </div>
        )}
      </div>
    </div>
  );
}
