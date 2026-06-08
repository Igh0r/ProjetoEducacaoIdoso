import { useState, useRef, useEffect } from "react";
import { Search, Send, Mic, Bot, User, X } from "lucide-react";

interface Message {
  id: number;
  from: "user" | "ai";
  text: string;
}

const aiKnowledge: { keywords: string[]; answer: string }[] = [
  {
    keywords: ["gov.br", "governo", "govbr", "conta gov"],
    answer:
      "Para criar uma conta no gov.br:\n1️⃣ Acesse www.gov.br pelo celular ou computador\n2️⃣ Clique em 'Entrar com gov.br' e depois 'Criar conta'\n3️⃣ Digite seu CPF (só números, sem ponto ou traço)\n4️⃣ Confirme sua identidade pelo banco digital (Nubank, BB, Caixa etc.) ou por reconhecimento facial\n\n✅ Com a conta gov.br você acessa INSS, Carteira de Trabalho, Receita Federal e muito mais, tudo num só lugar!",
  },
  {
    keywords: ["inss", "aposentadoria", "benefício", "meu inss", "extrato inss", "previdência"],
    answer:
      "Para consultar seu INSS pelo celular:\n1️⃣ Baixe o app 'Meu INSS' gratuitamente na loja do celular\n2️⃣ Entre com seu CPF e senha do gov.br\n3️⃣ Toque em 'Extrato de Pagamento' para ver os últimos pagamentos\n\n📋 Pelo Meu INSS você também pode:\n• Ver extrato da aposentadoria\n• Fazer prova de vida digital (sem sair de casa!)\n• Agendar perícias\n• Pedir revisão de benefício\n\nDúvidas? Ligue para o INSS: ☎️ 135 (gratuito, 24h)",
  },
  {
    keywords: ["pix", "transferir dinheiro", "transferência"],
    answer:
      "O PIX é gratuito para pessoas físicas e o dinheiro chega na hora!\n\n📱 Para fazer um PIX:\n1️⃣ Abra o app do seu banco e procure 'PIX'\n2️⃣ Toque em 'Transferir' ou 'Pagar'\n3️⃣ Digite a chave PIX do destinatário (CPF, celular ou e-mail)\n4️⃣ CONFIRA o nome de quem vai receber antes de confirmar\n5️⃣ Digite o valor e confirme com sua senha\n\n🚨 CUIDADO: Nunca faça PIX para número desconhecido, mesmo que diga ser familiar. Sempre ligue antes para confirmar!",
  },
  {
    keywords: ["whatsapp", "mensagem", "zap", "zap zap"],
    answer:
      "Para usar o WhatsApp:\n📱 Enviar mensagem: Toque no balãozinho ✏️ → escolha o contato → escreva e aperte a seta verde\n\n🎙️ Enviar áudio: Pressione e segure o microfone → fale → solte para enviar\n\n📷 Enviar foto: Toque no clipe 📎 → Galeria → escolha a foto\n\n📹 Videochamada: Abra a conversa → toque na câmera no topo → confirme\n\n💡 Dica: Muitos idosos preferem mandar áudio a digitar — é muito mais fácil!",
  },
  {
    keywords: ["youtube", "vídeo", "assistir", "filme", "música no celular"],
    answer:
      "Para usar o YouTube no celular:\n1️⃣ Toque no ícone vermelho do YouTube (▶️)\n2️⃣ Toque na lupa 🔍 e escreva o que quer ver\n3️⃣ Exemplos: 'missa hoje', 'Roberto Carlos', 'receita de bolo', 'forró'\n4️⃣ Toque no vídeo para assistir\n5️⃣ Vire o celular de lado para ver em tela cheia\n\n💡 Dica: Toque no microfone 🎙️ para FALAR o que quer pesquisar, sem precisar digitar!",
  },
  {
    keywords: ["golpe", "fraude", "scam", "roubo", "enganar", "cuidado", "suspeito", "falso"],
    answer:
      "Os golpes mais comuns contra idosos:\n\n⚠️ Golpe do falso parente: mensagem dizendo ser filho/neto pedindo PIX urgente. SOLUÇÃO: Ligue para o número que você já conhece.\n\n⚠️ Falsa central bancária: ligam dizendo ser do banco pedindo senha. SOLUÇÃO: Bancos NUNCA pedem senha por telefone. Desligue.\n\n⚠️ Link suspeito: link de 'benefício' ou 'prêmio' por WhatsApp/SMS. SOLUÇÃO: NUNCA clique.\n\n🚨 Se cair em golpe: ligue imediatamente para o banco e registre BO pelo 190 ou delegaciavirtual.pc.",
  },
  {
    keywords: ["remédio", "medicamento", "comprimido", "esquecer remédio", "horário remédio"],
    answer:
      "Dicas para não esquecer os remédios:\n\n⏰ Configurar alarme: Abra o Relógio do celular → Alarme → + → Coloque o horário → Nomeie como 'Remédio manhã' → Ative repetição diária\n\n📦 Organizador semanal: Compre um organizador por dias da semana (R$10 na farmácia). Encha no início da semana.\n\n📱 App Medisafe: Gratuito, lembra dos remédios e até avisa quando está acabando\n\n📋 Lista na geladeira: Escreva nome, horário e dose de cada remédio e cole na geladeira.",
  },
  {
    keywords: ["samu", "emergência", "urgência", "ambulância", "socorrer", "socorro"],
    answer:
      "Em caso de emergência:\n\n🚨 SAMU: 192 (ambulância, gratuito 24h)\n🔥 Bombeiros: 193\n👮 Polícia: 190\n💙 CVV (apoio emocional): 188\n\n📞 Ao ligar para o SAMU:\n• Diga seu nome\n• Fale o endereço completo (rua, número, bairro)\n• Explique o que está acontecendo\n• NÃO desligue até eles pedirem\n\n⚠️ Sinais de AVC (derrame): sorriso torto, braço caído, fala difícil → SAMU imediatamente!",
  },
  {
    keywords: ["sus", "consulta sus", "agendamento sus", "posto de saúde", "ubs"],
    answer:
      "Para agendar consulta pelo SUS:\n\n📱 App Meu SUS Digital:\n1️⃣ Baixe o app gratuito 'Meu SUS Digital'\n2️⃣ Entre com seu CPF e senha do gov.br\n3️⃣ Toque em 'Agendamentos'\n4️⃣ Escolha o serviço e o horário\n\n🏥 Presencialmente: Vá à UBS (Unidade Básica de Saúde) mais próxima com RG, CPF e cartão do SUS\n\n📞 Central de agendamento SUS: varia por cidade. Pesquise 'agendar consulta SUS [sua cidade]' no Google.",
  },
  {
    keywords: ["senha", "esqueci senha", "trocar senha", "senha celular"],
    answer:
      "Para recuperar ou trocar senhas:\n\n📱 Senha do celular: Vá em Configurações → Segurança → Bloqueio de tela\n\n📧 Senha do e-mail: Na tela de login, toque em 'Esqueci minha senha' e siga as instruções\n\n🏦 Senha do banco: Use a opção 'Esqueci minha senha' no app do banco, ou ligue para a central do seu banco (número no verso do cartão)\n\n🏛️ Senha do gov.br: Acesse gov.br → 'Esqueci minha senha' → verificação por CPF e celular\n\n💡 Dica: Use senhas fáceis de lembrar mas difíceis de adivinhar. Evite datas de aniversário.",
  },
  {
    keywords: ["exercício", "exercicios", "atividade física", "academia", "caminhar", "caminhada"],
    answer:
      "Exercícios recomendados para idosos:\n\n🚶 Caminhada: 20-30 minutos por dia, em passo tranquilo. É o melhor exercício!\n\n🪑 Levanta e senta: Sente e levante de uma cadeira 10 vezes. Fortalece as pernas e previne quedas.\n\n💧 Hidratação: Beba água antes, durante e depois do exercício.\n\n⚠️ Antes de começar uma atividade nova, consulte seu médico, especialmente se tiver pressão alta, diabetes ou problemas no coração.",
  },
  {
    keywords: ["imposto de renda", "declaração", "ir", "receita federal", "malha fina"],
    answer:
      "Sobre o Imposto de Renda:\n\n📋 Quem declara? Quem recebeu mais de R$30.639,90 em 2024 (trabalho, aposentadoria, aluguel etc.)\n\n📅 Prazo 2025: até 30 de maio de 2025\n\n📱 App: Baixe 'Meu Imposto de Renda' da Receita Federal. Use a Declaração Pré-preenchida — muito mais fácil!\n\n🤝 Precisa de ajuda? O CRAS da sua cidade oferece auxílio gratuito. Ligue: 08006441407",
  },
  {
    keywords: ["internet", "wi-fi", "wifi", "dados", "4g", "sem internet", "conexão"],
    answer:
      "Para resolver problemas de internet:\n\n📶 Wi-Fi fraco:\n• Fique mais perto do roteador (aparelho que dá internet)\n• Reinicie o roteador: desligue, aguarde 10 segundos e ligue novamente\n\n📱 Dados móveis:\n• Vá em Configurações → Rede Móvel → Ative 'Dados Móveis'\n• Verifique se seu plano tem dados disponíveis\n\n🔄 Reiniciar o celular resolve muitos problemas de conexão!",
  },
  {
    keywords: ["foto", "tirar foto", "câmera", "selfie", "fotografia"],
    answer:
      "Dicas para fotos melhores com o celular:\n\n☀️ Luz natural: Fique de frente para a janela — a foto fica muito melhor!\n\n🤳 Foto firme: Segure com as duas mãos e encoste os cotovelos no corpo.\n\n👤 Selfie: Use a câmera frontal (ícone de câmera com seta circular). Estenda o braço e sorria!\n\n📸 Zoom: Para dar zoom, junte dois dedos na tela e abra devagar (como abrindo uma tesoura).\n\n💾 Guardar fotos: No app Google Fotos você guarda todas as fotos na nuvem, de graça!",
  },
];

function getAIResponse(question: string): string {
  const q = question.toLowerCase();
  const match = aiKnowledge.find((item) =>
    item.keywords.some((kw) => q.includes(kw))
  );
  if (match) return match.answer;

  // Google fallback
  return `Não tenho uma resposta exata para isso, mas posso sugerir:\n\n🔍 Pesquise no Google: "${question}"\n\nPara pesquisar no Google:\n1️⃣ Abra o Chrome ou Safari no celular\n2️⃣ Toque na barra de endereços no topo\n3️⃣ Digite sua pergunta\n4️⃣ Toque em Pesquisar\n\nVocê também pode falar: toque no microfone 🎙️ e diga sua pergunta em voz alta!`;
}

const suggestions = [
  "Como acessar o gov.br?",
  "Como consultar meu INSS?",
  "Como fazer um PIX?",
  "Como não esquecer os remédios?",
  "Quais os números de emergência?",
  "Como usar o YouTube?",
  "Como me proteger de golpes?",
  "Como agendar consulta no SUS?",
];

export function AISearch() {
  const [messages, setMessages] = useState<Message[]>([
    {
      id: 0,
      from: "ai",
      text: "Olá! 😊 Sou seu Assistente Digital. Pode me perguntar sobre WhatsApp, gov.br, INSS, PIX, remédios, SUS, segurança e muito mais!\n\nDigite sua dúvida ou escolha uma das perguntas sugeridas abaixo.",
    },
  ]);
  const [input, setInput] = useState("");
  const [isTyping, setIsTyping] = useState(false);
  const bottomRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages, isTyping]);

  const sendMessage = (text: string) => {
    if (!text.trim()) return;
    const userMsg: Message = { id: Date.now(), from: "user", text: text.trim() };
    setMessages((prev) => [...prev, userMsg]);
    setInput("");
    setIsTyping(true);

    setTimeout(() => {
      const answer = getAIResponse(text);
      const aiMsg: Message = { id: Date.now() + 1, from: "ai", text: answer };
      setMessages((prev) => [...prev, aiMsg]);
      setIsTyping(false);
    }, 1000);
  };

  const clearChat = () => {
    setMessages([
      {
        id: Date.now(),
        from: "ai",
        text: "Conversa reiniciada! 😊 O que posso ajudar?",
      },
    ]);
  };

  return (
    <div className="flex flex-col bg-gray-900 text-white" style={{ height: "calc(100vh - 7rem)" }}>
      {/* Header */}
      <header className="bg-gray-800 border-b-4 border-yellow-400 p-5 flex items-center justify-between flex-shrink-0">
        <div className="flex items-center gap-4">
          <div className="bg-yellow-400 rounded-2xl p-3">
            <Bot size={32} className="text-gray-900" />
          </div>
          <div>
            <h1 className="text-3xl font-bold">Assistente Digital</h1>
            <p className="text-gray-400 text-lg">Pergunte qualquer coisa</p>
          </div>
        </div>
        <button
          onClick={clearChat}
          className="bg-gray-700 hover:bg-gray-600 p-3 rounded-xl transition"
          title="Limpar conversa"
        >
          <X size={28} className="text-gray-300" />
        </button>
      </header>

      {/* Messages */}
      <div className="flex-1 overflow-y-auto p-4 space-y-4">
        {messages.map((msg) => (
          <div
            key={msg.id}
            className={`flex gap-3 ${msg.from === "user" ? "flex-row-reverse" : "flex-row"}`}
          >
            {/* Avatar */}
            <div
              className={`flex-shrink-0 w-12 h-12 rounded-2xl flex items-center justify-center ${
                msg.from === "ai" ? "bg-yellow-400" : "bg-blue-600"
              }`}
            >
              {msg.from === "ai" ? (
                <Bot size={24} className="text-gray-900" />
              ) : (
                <User size={24} className="text-white" />
              )}
            </div>

            {/* Bubble */}
            <div
              className={`max-w-[82%] rounded-3xl p-5 ${
                msg.from === "ai"
                  ? "bg-gray-800 rounded-tl-sm"
                  : "bg-blue-700 rounded-tr-sm"
              }`}
            >
              <p className="text-xl leading-relaxed whitespace-pre-line">{msg.text}</p>
            </div>
          </div>
        ))}

        {/* Typing indicator */}
        {isTyping && (
          <div className="flex gap-3">
            <div className="w-12 h-12 bg-yellow-400 rounded-2xl flex items-center justify-center flex-shrink-0">
              <Bot size={24} className="text-gray-900" />
            </div>
            <div className="bg-gray-800 rounded-3xl rounded-tl-sm px-6 py-5 flex items-center gap-2">
              <span className="w-3 h-3 bg-gray-400 rounded-full animate-bounce" style={{ animationDelay: "0ms" }} />
              <span className="w-3 h-3 bg-gray-400 rounded-full animate-bounce" style={{ animationDelay: "150ms" }} />
              <span className="w-3 h-3 bg-gray-400 rounded-full animate-bounce" style={{ animationDelay: "300ms" }} />
            </div>
          </div>
        )}

        <div ref={bottomRef} />
      </div>

      {/* Suggestions */}
      {messages.length <= 2 && (
        <div className="px-4 pb-2 flex-shrink-0">
          <p className="text-gray-400 text-lg mb-3">Perguntas frequentes:</p>
          <div className="flex flex-wrap gap-2">
            {suggestions.map((s) => (
              <button
                key={s}
                onClick={() => sendMessage(s)}
                className="bg-gray-700 hover:bg-gray-600 border border-gray-600 px-4 py-2 rounded-2xl text-lg transition"
              >
                {s}
              </button>
            ))}
          </div>
        </div>
      )}

      {/* Input area */}
      <div className="bg-gray-800 border-t-2 border-gray-700 p-4 flex-shrink-0">
        <div className="flex gap-3 items-end">
          <div className="flex-1 bg-gray-700 rounded-2xl flex items-center gap-2 px-4 py-3">
            <Search size={24} className="text-gray-400 flex-shrink-0" />
            <input
              type="text"
              value={input}
              onChange={(e) => setInput(e.target.value)}
              onKeyDown={(e) => e.key === "Enter" && sendMessage(input)}
              placeholder="Digite sua dúvida aqui..."
              className="flex-1 bg-transparent text-white text-xl focus:outline-none placeholder-gray-400"
            />
          </div>
          <button
            onClick={() => sendMessage(input)}
            disabled={!input.trim() || isTyping}
            className="bg-yellow-400 hover:bg-yellow-300 disabled:opacity-40 text-gray-900 p-4 rounded-2xl transition flex-shrink-0"
          >
            <Send size={28} />
          </button>
        </div>
        <p className="text-center text-gray-500 text-base mt-3">
          🤖 Assistente com respostas para as dúvidas mais comuns
        </p>
      </div>
    </div>
  );
}
