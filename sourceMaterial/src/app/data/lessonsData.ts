export interface LessonStep {
  title: string;
  content: string;
  image: string;
  tip?: string;
  warning?: string;
}

export interface LessonItem {
  id: string;
  title: string;
  description: string;
  completed: boolean;
  locked: boolean;
  duration: string;
  difficulty: "Fácil" | "Médio" | "Difícil";
  videoSearchQuery?: string;
  steps: LessonStep[];
}

export interface CategoryData {
  id: string;
  name: string;
  emoji: string;
  color: string;
  borderColor: string;
  description: string;
  lessons: LessonItem[];
}

export const categoriesData: CategoryData[] = [
  {
    id: "technology",
    name: "Tecnologia",
    emoji: "💻",
    color: "bg-blue-600 hover:bg-blue-700",
    borderColor: "border-blue-400",
    description: "Aprenda a usar celular, WhatsApp e internet",
    lessons: [
      {
        id: "tech-1",
        title: "Como usar o WhatsApp",
        description: "Envie mensagens, fotos e áudios",
        completed: false,
        locked: false,
        duration: "8 min",
        difficulty: "Fácil",
        videoSearchQuery: "como usar whatsapp tutorial idosos",
        steps: [
          {
            title: "O que é o WhatsApp?",
            content:
              "O WhatsApp é um aplicativo gratuito para enviar mensagens, fotos e fazer chamadas pelo celular. Você usa a internet, então não gasta créditos de ligação.",
            image: "💬",
            tip: "O WhatsApp é gratuito! Você só precisa de internet (Wi-Fi ou dados móveis).",
          },
          {
            title: "Passo 1: Abrir o WhatsApp",
            content:
              "Procure o ícone verde com um telefone branco na tela do seu celular. Toque nele uma vez para abrir. Se não encontrar, deslize a tela para o lado procurando por ele.",
            image: "📱",
            tip: "O ícone do WhatsApp é verde com um telefone branco dentro.",
          },
          {
            title: "Passo 2: Escolher um contato",
            content:
              "Toque no ícone de conversa no canto inferior direito (parece um balãozinho com um lápis). Uma lista de contatos vai aparecer. Toque no nome da pessoa com quem quer conversar.",
            image: "👥",
            tip: "Você só consegue conversar com pessoas que também têm WhatsApp.",
          },
          {
            title: "Passo 3: Digitar e enviar mensagem",
            content:
              "Toque no campo escuro na parte de baixo onde está escrito 'Mensagem'. Escreva o que deseja. Quando terminar, toque na seta verde para enviar.",
            image: "⌨️",
            tip: "Se errar uma letra, use a tecla com uma setinha ← para apagar.",
          },
          {
            title: "Passo 4: Enviar uma foto",
            content:
              "Toque no ícone de clipe (📎) ao lado do campo de mensagem. Escolha 'Galeria' para enviar uma foto já tirada, ou 'Câmera' para tirar uma foto nova.",
            image: "📷",
            tip: "Você pode ver as fotos que enviou rolando a tela da conversa para cima.",
          },
          {
            title: "Passo 5: Enviar mensagem de voz",
            content:
              "Em vez de digitar, toque e segure o ícone de microfone 🎙️ (à direita do campo de mensagem). Fale o que deseja e solte o dedo para enviar.",
            image: "🎙️",
            tip: "Muitos idosos preferem áudios a digitar — é muito mais fácil!",
          },
        ],
      },
      {
        id: "tech-2",
        title: "Fazendo videochamadas",
        description: "Veja a família de qualquer lugar",
        completed: false,
        locked: false,
        duration: "6 min",
        difficulty: "Fácil",
        videoSearchQuery: "como fazer videochamada whatsapp tutorial",
        steps: [
          {
            title: "O que é uma videochamada?",
            content:
              "Na videochamada você consegue ver e ouvir a pessoa ao mesmo tempo, como se estivesse na mesma sala. É ótimo para falar com filhos e netos que moram longe!",
            image: "📹",
            tip: "Videochamadas pelo WhatsApp são gratuitas quando você usa Wi-Fi.",
          },
          {
            title: "Passo 1: Abrir a conversa",
            content:
              "Abra o WhatsApp e toque na conversa da pessoa com quem quer fazer a videochamada.",
            image: "💬",
          },
          {
            title: "Passo 2: Iniciar a videochamada",
            content:
              "No topo da conversa, toque no ícone de câmera de vídeo (📹). Uma mensagem vai aparecer confirmando. Toque em 'Chamada de vídeo' para confirmar.",
            image: "📞",
            tip: "O ícone de câmera fica no canto superior direito da conversa.",
          },
          {
            title: "Passo 3: Durante a chamada",
            content:
              "Você vai ver a outra pessoa na tela grande e você mesmo numa tela pequena no canto. Para que te vejam bem, segure o celular na frente do seu rosto, com boa iluminação.",
            image: "🤳",
            tip: "Fique perto de uma janela ou luz acesa para aparecer melhor na câmera.",
          },
          {
            title: "Passo 4: Encerrar a chamada",
            content:
              "Quando quiser terminar, toque no botão vermelho com um telefone (🔴). A chamada será encerrada.",
            image: "👋",
            warning: "Não esqueça de encerrar a chamada — ela não desliga sozinha!",
          },
        ],
      },
      {
        id: "tech-3",
        title: "Como acessar o gov.br",
        description: "Acesse serviços do governo pelo celular",
        completed: false,
        locked: false,
        duration: "12 min",
        difficulty: "Médio",
        videoSearchQuery: "como criar conta govbr tutorial passo a passo",
        steps: [
          {
            title: "O que é o gov.br?",
            content:
              "O gov.br é o site oficial do governo federal brasileiro. Por ele você acessa: INSS (extrato e benefícios), Carteira de Trabalho Digital, Receita Federal, e mais de 4.000 outros serviços.",
            image: "🏛️",
            tip: "Com uma única conta gov.br você acessa todos os serviços do governo!",
          },
          {
            title: "Passo 1: Abrir o site",
            content:
              "Abra o navegador do seu celular (Chrome, Safari ou outro). Na barra de endereços no topo, apague o que está escrito e digite: www.gov.br — depois toque em 'Ir' ou 'Enter'.",
            image: "🌐",
            warning: "Cuidado! O endereço correto é www.gov.br — desconfie de sites parecidos com nomes diferentes.",
          },
          {
            title: "Passo 2: Toque em 'Entrar'",
            content:
              "Na página inicial do gov.br, toque no botão azul 'Entrar'. Se ainda não tem conta, toque em 'Criar conta'. Para criar, você vai precisar do seu CPF e de um celular cadastrado.",
            image: "🔑",
            tip: "Se tiver conta em banco digital (Nubank, Inter, BB etc.), pode entrar usando o app do banco — é mais fácil!",
          },
          {
            title: "Passo 3: Digitar o CPF",
            content:
              "Na tela de login, escreva somente os 11 números do seu CPF, sem pontos ou traços. Exemplo: se seu CPF é 123.456.789-00, digite apenas 12345678900.",
            image: "🪪",
            tip: "O CPF tem 11 números. Você encontra ele no seu cartão do CPF ou na carteira de identidade.",
          },
          {
            title: "Passo 4: Confirmar a identidade",
            content:
              "O gov.br vai pedir para confirmar quem você é. As formas mais fáceis são: pelo app do seu banco (se for parceiro), por reconhecimento facial (selfie), ou por um código enviado por SMS no seu celular.",
            image: "✅",
            tip: "A forma mais rápida é usar o app do banco. Bancos parceiros: Banco do Brasil, Caixa, Itaú, Bradesco, Santander, Nubank e outros.",
          },
          {
            title: "Passo 5: Acessar o INSS",
            content:
              "Após entrar, toque na barra de pesquisa e escreva 'INSS'. Toque em 'Meu INSS' nos resultados. Você pode ver seu extrato de benefícios, consultar aposentadoria e muito mais.",
            image: "💰",
            tip: "Salve o site gov.br nos favoritos do seu navegador para encontrar fácil da próxima vez!",
          },
        ],
      },
      {
        id: "tech-4",
        title: "Usando o PIX",
        description: "Transfira dinheiro de forma rápida e gratuita",
        completed: false,
        locked: false,
        duration: "10 min",
        difficulty: "Médio",
        videoSearchQuery: "como usar pix tutorial iniciante",
        steps: [
          {
            title: "O que é o PIX?",
            content:
              "PIX é uma forma de transferir dinheiro pela internet, criada pelo Banco Central. Funciona 24 horas por dia, 7 dias por semana, incluindo feriados. E é de graça para pessoas físicas!",
            image: "⚡",
            tip: "PIX é muito mais rápido que TED e DOC — o dinheiro chega na hora!",
          },
          {
            title: "Passo 1: Abrir o app do banco",
            content:
              "Abra o aplicativo do seu banco no celular. Procure o menu ou botão com o nome 'PIX'. Pode estar na tela principal ou dentro do menu de opções.",
            image: "🏦",
          },
          {
            title: "Passo 2: Cadastrar sua chave PIX",
            content:
              "Na primeira vez, você precisa cadastrar uma 'chave PIX' para receber dinheiro. Toque em 'Minhas Chaves' e depois 'Cadastrar'. Recomendamos usar o CPF como chave — é mais fácil!",
            image: "🔑",
            tip: "Sua chave PIX é como seu 'endereço' para receber dinheiro. Você pode ter até 5 chaves.",
          },
          {
            title: "Passo 3: Fazer um PIX",
            content:
              "Para enviar dinheiro, toque em 'Pagar' ou 'Transferir via PIX'. Digite a chave PIX de quem vai receber (CPF, celular ou e-mail). ANTES de confirmar, verifique o nome da pessoa.",
            image: "💸",
            warning: "ATENÇÃO: Sempre confira o nome do destinatário antes de confirmar o PIX. Se o nome não bater com quem você quer pagar, cancele imediatamente!",
          },
          {
            title: "Passo 4: Confirmar e enviar",
            content:
              "Digite o valor que deseja transferir. Revise tudo: nome, valor e chave. Se estiver tudo certo, toque em 'Confirmar' e use sua senha ou digital para autorizar.",
            image: "✅",
            tip: "Guarde o comprovante do PIX. Toque em 'Compartilhar' ou 'Salvar' para ter o recibo.",
          },
          {
            title: "Cuidado com golpes do PIX",
            content:
              "Nunca faça PIX para números de WhatsApp que dizem ser seu filho ou parente pedindo dinheiro urgente. Sempre ligue para a pessoa antes de transferir qualquer valor.",
            image: "🚨",
            warning: "Golpe do falso parente: se receber mensagem de número desconhecido dizendo ser filho, irmão ou neto pedindo PIX urgente, DESCONFIE! Ligue para a pessoa no número que você já conhece para confirmar.",
          },
        ],
      },
      {
        id: "tech-5",
        title: "Usando o YouTube",
        description: "Assista vídeos, receitas e novelas",
        completed: false,
        locked: false,
        duration: "8 min",
        difficulty: "Fácil",
        videoSearchQuery: "como usar youtube tutorial idosos",
        steps: [
          {
            title: "O que é o YouTube?",
            content:
              "O YouTube é um site e aplicativo onde você encontra milhões de vídeos gratuitos: receitas, música, notícias, filmes, tutoriais e muito mais. Tudo de graça!",
            image: "▶️",
            tip: "No YouTube você encontra missa ao vivo, forró, novelas antigas e até receitas de comida!",
          },
          {
            title: "Passo 1: Abrir o YouTube",
            content:
              "Toque no ícone vermelho do YouTube no seu celular. Ele parece um retângulo vermelho com um triângulo branco no meio. Se não tiver, abra o Google e pesquise 'YouTube'.",
            image: "📱",
          },
          {
            title: "Passo 2: Pesquisar um vídeo",
            content:
              "Toque na lupa 🔍 no topo da tela. Digite o que quer ver. Exemplos: 'missa hoje', 'receita de bolo simples', 'Roberto Carlos', 'exercícios para terceira idade'.",
            image: "🔍",
            tip: "Você também pode falar em vez de digitar — toque no ícone do microfone 🎙️ e diga o que quer ver.",
          },
          {
            title: "Passo 3: Escolher e assistir",
            content:
              "Toque no vídeo que quiser ver. Para pausar, toque na tela. Toque novamente para continuar. Use os botões 10 e 10 para avançar ou voltar 10 segundos.",
            image: "🎬",
          },
          {
            title: "Passo 4: Aumentar o tamanho",
            content:
              "Para ver em tela cheia, vire o celular de lado e toque no ícone de tela cheia (dois quadradinhos) no canto inferior direito do vídeo.",
            image: "📺",
            tip: "Para aumentar a letra das legendas, toque nos três pontinhos (...) e vá em 'Legendas'.",
          },
        ],
      },
      {
        id: "tech-6",
        title: "Usando o Google Maps",
        description: "Encontre endereços e trace rotas",
        completed: false,
        locked: false,
        duration: "8 min",
        difficulty: "Fácil",
        videoSearchQuery: "como usar google maps tutorial iniciante",
        steps: [
          {
            title: "O que é o Google Maps?",
            content:
              "O Google Maps é um mapa no seu celular. Com ele você encontra qualquer endereço, sabe como chegar lá (de carro, ônibus ou a pé) e ainda vê quanto tempo vai levar.",
            image: "🗺️",
            tip: "O Google Maps funciona como um GPS que fala o caminho para você!",
          },
          {
            title: "Passo 1: Abrir o Maps",
            content:
              "Procure o ícone colorido do Google Maps (parece um pino de localização vermelho). Se não encontrar, abra o Google e pesquise 'Google Maps'.",
            image: "📍",
          },
          {
            title: "Passo 2: Pesquisar um lugar",
            content:
              "Toque na barra de pesquisa no topo. Digite o endereço ou o nome do lugar. Exemplos: 'UBS mais perto', 'farmácia próxima', ou o endereço completo.",
            image: "🔍",
            tip: "Você pode falar o endereço — toque no microfone e diga o local.",
          },
          {
            title: "Passo 3: Obter rotas",
            content:
              "Quando encontrar o lugar, toque no botão azul 'Rotas' ou 'Como chegar'. Escolha como vai se locomover: carro 🚗, ônibus 🚌, a pé 🚶 ou mototáxi 🛵.",
            image: "🧭",
          },
          {
            title: "Passo 4: Iniciar a navegação",
            content:
              "Toque em 'Iniciar' para o Maps falar o caminho enquanto você anda. Ele vai dizer 'Vire à esquerda', 'Continue reto' etc., igual a um GPS.",
            image: "🗣️",
            tip: "Deixe o celular com o volume no máximo para ouvir bem as instruções de rota.",
          },
        ],
      },
    ],
  },
  {
    id: "health",
    name: "Saúde",
    emoji: "❤️",
    color: "bg-red-600 hover:bg-red-700",
    borderColor: "border-red-400",
    description: "Cuide melhor da sua saúde e bem-estar",
    lessons: [
      {
        id: "health-1",
        title: "Exercícios para o dia a dia",
        description: "Atividades leves que você pode fazer em casa",
        completed: false,
        locked: false,
        duration: "10 min",
        difficulty: "Fácil",
        videoSearchQuery: "exercicios leves para idosos em casa",
        steps: [
          {
            title: "Por que se exercitar?",
            content:
              "Exercícios leves todos os dias ajudam a manter o equilíbrio (evitando quedas), fortalecem os músculos, melhoram o humor e ajudam a dormir melhor.",
            image: "💪",
            tip: "Você não precisa ir à academia! Exercícios simples em casa já fazem muita diferença.",
          },
          {
            title: "Exercício 1: Caminhada",
            content:
              "Caminhe por pelo menos 20 minutos por dia, mesmo que seja dentro de casa ou num quintal. Use calçados confortáveis e caminhe em passo tranquilo.",
            image: "🚶",
            tip: "Se não consegue 20 minutos seguidos, faça 4 caminhadas de 5 minutos ao longo do dia.",
          },
          {
            title: "Exercício 2: Levanta e senta",
            content:
              "Sente numa cadeira firme e levante sem usar as mãos. Faça isso 10 vezes devagar. Este exercício fortalece as pernas e ajuda a evitar quedas.",
            image: "🪑",
            warning: "Tenha uma pessoa por perto nas primeiras vezes ou segure em algo firme para não cair.",
          },
          {
            title: "Exercício 3: Alongamento dos braços",
            content:
              "Em pé ou sentado, estique os dois braços para cima o máximo que conseguir. Segure por 10 segundos e abaixe devagar. Repita 5 vezes.",
            image: "🙆",
            tip: "Alongamentos pela manhã ajudam a aliviar as dores e a começar o dia com mais disposição.",
          },
          {
            title: "Exercício 4: Girar o pescoço",
            content:
              "Sentado, vire o pescoço lentamente para a direita, segure 5 segundos, volte ao centro. Vire para a esquerda, segure 5 segundos. Repita 5 vezes para cada lado.",
            image: "🔄",
            warning: "Faça os movimentos DEVAGAR. Movimentos bruscos no pescoço podem causar tontura.",
          },
        ],
      },
      {
        id: "health-2",
        title: "Controlando seus remédios",
        description: "Não esqueça mais nenhum comprimido",
        completed: false,
        locked: false,
        duration: "8 min",
        difficulty: "Fácil",
        videoSearchQuery: "como organizar medicamentos idosos alarme celular",
        steps: [
          {
            title: "A importância de tomar os remédios certos",
            content:
              "Tomar os remédios nos horários certos é muito importante para controlar pressão, diabetes e outras condições. Esquecer ou tomar errado pode causar problemas de saúde.",
            image: "💊",
            warning: "Nunca troque, pare ou altere a dose de um remédio sem falar com seu médico primeiro.",
          },
          {
            title: "Dica 1: Organizador semanal",
            content:
              "Use um organizador de comprimidos (caixinha com os dias da semana). Você encontra em farmácias por R$10 a R$30. Coloque os remédios da semana toda toda segunda-feira.",
            image: "📦",
            tip: "O organizador evita a dúvida 'já tomei esse remédio hoje?' — se o compartimento estiver vazio, você já tomou!",
          },
          {
            title: "Dica 2: Alarme no celular",
            content:
              "Configure alarmes no seu celular nos horários dos remédios. Abra o Relógio do celular, toque em 'Alarme' e em '+' para adicionar um novo. Coloque um nome como 'Remédio da manhã'.",
            image: "⏰",
            tip: "Você pode configurar o alarme para repetir todos os dias automaticamente.",
          },
          {
            title: "Dica 3: Aplicativo de saúde",
            content:
              "Existem aplicativos gratuitos para lembrar dos remédios. No Google Play ou App Store, pesquise 'lembrete de remédio' ou 'Medisafe'. Eles avisam quando é hora de tomar.",
            image: "📱",
            tip: "O aplicativo 'Medisafe' é fácil de usar e muito popular entre idosos.",
          },
          {
            title: "Dica 4: Lista na geladeira",
            content:
              "Cole na geladeira um papel com o nome, horário e dose de cada remédio. Quando tomar, faça um risco. É simples e funciona muito bem!",
            image: "📋",
            tip: "A lista na geladeira funciona porque você vai lá várias vezes por dia — não tem como esquecer!",
          },
        ],
      },
      {
        id: "health-3",
        title: "Alimentação saudável",
        description: "Dicas de nutrição para viver melhor",
        completed: false,
        locked: false,
        duration: "8 min",
        difficulty: "Fácil",
        videoSearchQuery: "alimentação saudável para idosos dicas nutricionista",
        steps: [
          {
            title: "Nutrição na terceira idade",
            content:
              "Com o passar dos anos, o corpo precisa de mais proteína, cálcio e vitaminas. Uma alimentação equilibrada ajuda a manter os ossos fortes, a memória e o coração saudável.",
            image: "🥗",
            tip: "Comer bem não precisa ser caro! Feijão com arroz, ovo e legumes são ótimas opções.",
          },
          {
            title: "Hidratação é essencial",
            content:
              "Com a idade, a sensação de sede diminui, mas o corpo ainda precisa de água. Beba pelo menos 6 a 8 copos de água por dia, mesmo sem sentir sede.",
            image: "💧",
            tip: "Deixe uma garrafinha de água na mesa de cabeceira. Beba um copo ao acordar, antes de dormir e nas refeições.",
          },
          {
            title: "Alimentos que fazem bem",
            content:
              "Priorize: verduras e legumes coloridos, frutas frescas, feijão e lentilha (proteína), peixe 2x por semana, ovos, leite e queijo (cálcio), azeite de oliva.",
            image: "🥦",
          },
          {
            title: "Alimentos para evitar",
            content:
              "Tente reduzir: sal em excesso (causa pressão alta), açúcar (causa diabetes), fritura, embutidos como salsicha e presunto, refrigerante e bebidas alcoólicas.",
            image: "🚫",
            warning: "Se tiver pressão alta, peça ao médico qual o limite de sal por dia. Geralmente é menos que 1 colher de chá.",
          },
          {
            title: "Refeições regulares",
            content:
              "Faça 5 ou 6 refeições pequenas por dia: café da manhã, lanche da manhã, almoço, lanche da tarde, jantar e, se necessário, uma frutinha antes de dormir.",
            image: "🕐",
            tip: "Nunca pule o café da manhã — é a refeição mais importante para dar energia para o dia!",
          },
        ],
      },
      {
        id: "health-4",
        title: "Memória e saúde mental",
        description: "Exercícios para manter a mente afiada",
        completed: false,
        locked: false,
        duration: "10 min",
        difficulty: "Fácil",
        videoSearchQuery: "exercicios para memoria idosos saude mental",
        steps: [
          {
            title: "Cuidar da mente é tão importante quanto do corpo",
            content:
              "A saúde mental na terceira idade afeta o humor, o sono e a memória. Atividades simples no dia a dia ajudam muito a manter o cérebro ativo e saudável.",
            image: "🧠",
            tip: "O cérebro é como um músculo: quanto mais você usa, mais forte fica!",
          },
          {
            title: "Dica 1: Leitura diária",
            content:
              "Leia pelo menos 15 minutos por dia. Pode ser jornal, revista, livro ou a Bíblia. Ler estimula o cérebro, melhora a memória e reduz o risco de Alzheimer.",
            image: "📖",
          },
          {
            title: "Dica 2: Palavras cruzadas e sudoku",
            content:
              "Jogue palavras cruzadas, caça-palavras ou sudoku. Esses passatempos exercitam o raciocínio. Você encontra livrinhos nas bancas de jornal ou no aplicativo 'Palavras Cruzadas' no celular.",
            image: "🧩",
          },
          {
            title: "Dica 3: Socialização",
            content:
              "Conversar com amigos, participar de grupos na igreja, frequentar centros de convivência — o convívio social é fundamental para a saúde mental e reduz a depressão e solidão.",
            image: "👥",
            tip: "Grupos de WhatsApp com amigos e família também ajudam a manter o contato!",
          },
          {
            title: "Dica 4: Sono de qualidade",
            content:
              "Durma entre 7 e 9 horas por noite. Evite o celular 1 hora antes de dormir. Mantenha o quarto escuro e fresco. Um bom sono restaura a memória e o humor.",
            image: "😴",
            warning: "Se tiver dificuldade para dormir com frequência, converse com seu médico. Não tome calmantes sem receita.",
          },
        ],
      },
      {
        id: "health-5",
        title: "Em caso de emergência",
        description: "O que fazer e quem chamar",
        completed: false,
        locked: false,
        duration: "7 min",
        difficulty: "Fácil",
        videoSearchQuery: "como chamar samu ambulancia emergencia",
        steps: [
          {
            title: "Números de emergência",
            content:
              "Memorize ou salve estes números no celular: SAMU: 192 (ambulância), Bombeiros: 193, Polícia: 190, CVV (apoio emocional): 188. Esses números são gratuitos.",
            image: "🚨",
            tip: "Salve 'SAMU 192' nos contatos do celular agora mesmo — em emergência, cada segundo conta!",
          },
          {
            title: "Como chamar o SAMU",
            content:
              "Ligue para 192. Fale seu nome, endereço completo (rua, número, bairro, cidade) e o que está acontecendo. Fique na linha — eles vão orientar você até a ambulância chegar.",
            image: "📞",
            warning: "Não desligue o telefone até o SAMU pedir. Eles precisam de informações para ajudar você.",
          },
          {
            title: "Sinais de AVC (Derrame)",
            content:
              "Reconheça os sinais de AVC com o SAMU: Sorriso torto (um lado da boca caído), Abraço fraco (um braço não sobe), Fala difícil (fala embaralhada). Se ver esses sinais, ligue IMEDIATAMENTE para o SAMU.",
            image: "🧠",
            warning: "AVC é emergência! Quanto mais rápido o atendimento, menos sequelas. Não espere para ver se melhora sozinho.",
          },
          {
            title: "Contato de emergência no celular",
            content:
              "Salve um contato chamado 'EMERGÊNCIA - [Nome de familiar]' no celular. Muitos celulares permitem configurar um contato de emergência que pode ser acessado mesmo com o celular bloqueado.",
            image: "👨‍👩‍👧",
            tip: "No iPhone, vá em Saúde > Ficha Médica. No Android, vá em Configurações > Segurança > Informações de emergência.",
          },
          {
            title: "Kit de emergência em casa",
            content:
              "Tenha sempre em casa: lista dos seus remédios e doses, cartão do plano de saúde ou SUS, documentos (RG, CPF) numa pasta fácil de pegar, e o endereço da sua casa anotado.",
            image: "🧳",
            tip: "Cole na geladeira uma ficha com seus remédios, doenças e contato de emergência — paramédicos checam a geladeira em emergências!",
          },
        ],
      },
    ],
  },
  {
    id: "hobbies",
    name: "Hobbies",
    emoji: "🎨",
    color: "bg-purple-600 hover:bg-purple-700",
    borderColor: "border-purple-400",
    description: "Descubra novos passatempos e criatividade",
    lessons: [
      {
        id: "hobby-1",
        title: "Jardinagem em casa",
        description: "Aprenda a cuidar de plantas e ter uma horta",
        completed: false,
        locked: false,
        duration: "10 min",
        difficulty: "Fácil",
        videoSearchQuery: "jardinagem para iniciantes em vasos apartamento",
        steps: [
          {
            title: "Por que cultivar plantas?",
            content:
              "Cuidar de plantas reduz o estresse, mantém a mente e o corpo ativos, traz alegria e pode até gerar alimentos frescos. É uma atividade perfeita para qualquer idade!",
            image: "🌿",
            tip: "Você não precisa de quintal — muitas plantas crescem bem em vasos na varanda ou janela.",
          },
          {
            title: "Plantas fáceis para começar",
            content:
              "Para iniciantes, recomendamos: Espada-de-São-Jorge (muito resistente, não precisa de muita água), Suculentas (quase não precisam de cuidados), Hortelã (cresce em qualquer vaso e você usa na cozinha!).",
            image: "🪴",
            tip: "Suculentas são perfeitas para quem esquece de regar — elas sobrevivem com muito pouca água!",
          },
          {
            title: "Como plantar em vasos",
            content:
              "Pegue um vaso com furinhos no fundo. Coloque pedrinhas no fundo para drenar a água. Preencha com terra de boa qualidade (compre em mercado ou jardim). Plante sua muda e regue bem.",
            image: "🌱",
          },
          {
            title: "Como regar corretamente",
            content:
              "Regue somente quando a terra estiver seca ao toque. Coloque o dedo na terra: se estiver úmida, não regue ainda. Evite regar de tarde (o sol do meio-dia queima as folhas molhadas). Pela manhã é o melhor horário.",
            image: "💧",
            warning: "Excesso de água é a principal causa de morte das plantas! Menos é mais quando se trata de rega.",
          },
          {
            title: "Horta em casa",
            content:
              "Você pode plantar temperos em vasinhos na janela: cebolinha, salsa, manjericão, hortelã. Coloque onde pega sol. Em 2 a 4 semanas, você já pode colher para usar na cozinha!",
            image: "🌿",
            tip: "Uma hortinha em casa economiza dinheiro e os temperos são muito mais frescos e saborosos!",
          },
        ],
      },
      {
        id: "hobby-2",
        title: "Pintura com aquarela",
        description: "Descubra o artista dentro de você",
        completed: false,
        locked: false,
        duration: "12 min",
        difficulty: "Fácil",
        videoSearchQuery: "pintura aquarela para iniciantes idosos",
        steps: [
          {
            title: "Aquarela é para todos!",
            content:
              "A pintura com aquarela não exige talento especial. É relaxante, criativa e você pode começar com materiais simples e baratos. Não existe pintura 'errada'!",
            image: "🎨",
            tip: "Kits de aquarela para iniciantes custam a partir de R$20 em papelaria ou lojas de arte.",
          },
          {
            title: "Materiais necessários",
            content:
              "Você precisa de: tintas aquarela (caixa básica com 12 cores), pincel (números 4 e 8), papel para aquarela ou cartão branco, um copo com água e um pano para limpar o pincel.",
            image: "🖌️",
            tip: "Use papel mais grosso (180g ou mais) — papel fino amassa com a água.",
          },
          {
            title: "Técnica básica: lavagem",
            content:
              "Molhe o pincel na água, passe na tinta e pinte. Para cores mais claras, use mais água. Para cores mais escuras e intensas, use menos água. Deixe secar entre cada camada.",
            image: "🌊",
          },
          {
            title: "Seu primeiro exercício",
            content:
              "Comece pintando um céu simples: molhe o papel inteiro com água e um pincel grande. Enquanto ainda molhado, passe azul de cima para baixo — a cor vai se espalhando sozinha, criando um efeito bonito!",
            image: "🌤️",
            tip: "Não se preocupe com o resultado — o processo de pintar já faz bem para a mente!",
          },
          {
            title: "Mantenha a prática",
            content:
              "Tente pintar pelo menos 15 minutos por dia. Comece com formas simples: flores, paisagens, frutas. Com o tempo vai ficando cada vez mais fácil e prazeroso.",
            image: "📅",
            tip: "Você pode seguir tutoriais de pintura no YouTube buscando por 'aquarela fácil para iniciantes'.",
          },
        ],
      },
      {
        id: "hobby-3",
        title: "Fotografia com o celular",
        description: "Tire fotos bonitas do cotidiano",
        completed: false,
        locked: false,
        duration: "8 min",
        difficulty: "Fácil",
        videoSearchQuery: "fotografia celular dicas para iniciantes",
        steps: [
          {
            title: "Seu celular é uma câmera poderosa",
            content:
              "Os celulares modernos fazem fotos incríveis. Com algumas dicas simples, você vai tirar fotos que vão encantar sua família e amigos!",
            image: "📸",
          },
          {
            title: "Dica 1: Iluminação",
            content:
              "A melhor luz para fotos é a luz natural. Fique de frente para a janela ou porta ao fotografar pessoas. Evite tirar fotos com a luz atrás do sujeito (contra a luz).",
            image: "☀️",
            tip: "O horário dourado — cedo pela manhã ou ao anoitecer — dá as fotos mais bonitas ao ar livre.",
          },
          {
            title: "Dica 2: Mantenha a câmera firme",
            content:
              "Segure o celular com as duas mãos. Encoste os cotovelos no corpo para estabilizar. Toque suavemente no botão para tirar a foto — pressão forte balança a câmera.",
            image: "🤳",
          },
          {
            title: "Dica 3: Regra dos terços",
            content:
              "Não coloque o sujeito sempre no meio da foto. Imagine que a foto é dividida em 9 partes iguais. Coloque o sujeito em um dos pontos de intersecção — fica muito mais interessante!",
            image: "🖼️",
            tip: "Nas configurações da câmera, ative a 'Grade' ou 'Grade de composição' para ver as linhas dos terços.",
          },
          {
            title: "Dica 4: Organize suas fotos",
            content:
              "Crie álbuns no seu celular para organizar as fotos: família, viagens, natureza. No Android, abra a Galeria. No iPhone, abra o app Fotos e toque em '+' para criar álbuns.",
            image: "🗂️",
            tip: "Faça backup das suas fotos no Google Fotos — é gratuito e salva na nuvem automaticamente!",
          },
        ],
      },
      {
        id: "hobby-4",
        title: "Leitura digital",
        description: "Leia livros e jornais no celular de graça",
        completed: false,
        locked: false,
        duration: "8 min",
        difficulty: "Fácil",
        videoSearchQuery: "como ler livros gratis celular kindle",
        steps: [
          {
            title: "Livros no celular",
            content:
              "Você pode ter centenas de livros no celular, sem pesar nada! Além disso, dá para aumentar a letra o quanto quiser — ideal para quem tem dificuldade de leitura.",
            image: "📚",
            tip: "Muitos livros clássicos são completamente gratuitos no celular!",
          },
          {
            title: "Aplicativo Kindle (gratuito)",
            content:
              "Baixe o app 'Kindle' da Amazon (gratuito) na loja do seu celular. Com ele você acessa milhares de livros. Muitos são gratuitos, especialmente clássicos da literatura.",
            image: "📖",
          },
          {
            title: "Ajustando o tamanho da letra",
            content:
              "No Kindle, toque nas letras 'Aa' para ajustar. Aumente a fonte até ficar confortável para ler. Você também pode mudar o fundo para 'Sépia' (bege) — cansa menos os olhos.",
            image: "🔡",
            tip: "Fundo sépia (cor de papel velho) é muito mais descansado para a vista do que fundo branco!",
          },
          {
            title: "Jornais e revistas gratuitos",
            content:
              "Muitos jornais têm aplicativos gratuitos: G1 (Globo), UOL, Terra, R7. Baixe um deles para ler notícias sempre atualizadas. Também há versão pelo navegador — pesquise no Google.",
            image: "📰",
          },
          {
            title: "Áudio livros",
            content:
              "Se preferir ouvir a ler, experimente áudio livros! No YouTube existe muita coisa gratuita: pesquise 'audiolivro [nome do livro]'. O app Spotify também tem áudio livros em português.",
            image: "🎧",
            tip: "Áudio livros são ótimos para ouvir enquanto caminha, faz exercício ou trabalhos manuais!",
          },
        ],
      },
    ],
  },
  {
    id: "languages",
    name: "Idiomas",
    emoji: "🌎",
    color: "bg-green-600 hover:bg-green-700",
    borderColor: "border-green-400",
    description: "Aprenda palavras e frases em outro idioma",
    lessons: [
      {
        id: "lang-1",
        title: "Inglês: Saudações do dia a dia",
        description: "Como cumprimentar e se apresentar",
        completed: false,
        locked: false,
        duration: "8 min",
        difficulty: "Fácil",
        videoSearchQuery: "inglês básico saudações para iniciantes idosos",
        steps: [
          {
            title: "Por que aprender inglês?",
            content:
              "Com inglês básico você consegue entender embalagens de produtos, se comunicar com médico em viagem, usar melhor o celular e conversar com netos que moram fora.",
            image: "🇺🇸",
            tip: "Não precisa falar perfeito! Qualquer inglês já ajuda muito.",
          },
          {
            title: "Saudações básicas",
            content:
              "Hello = Olá | Good morning = Bom dia | Good afternoon = Boa tarde | Good evening = Boa noite | Goodbye / Bye = Tchau | See you later = Até logo | How are you? = Como vai você?",
            image: "👋",
            tip: "Pronuncie 'Hello' como 'Rrélou'. Good morning = 'Gúd môrning'.",
          },
          {
            title: "Apresentando-se",
            content:
              "My name is [seu nome] = Meu nome é... | I am [sua idade] years old = Tenho [x] anos | I am from Brazil = Sou do Brasil | Nice to meet you = Prazer em conhecer você.",
            image: "🤝",
          },
          {
            title: "Frases úteis",
            content:
              "Please = Por favor | Thank you = Obrigado(a) | You're welcome = De nada | Sorry = Desculpe | Yes = Sim | No = Não | I don't understand = Não entendo | Can you repeat? = Pode repetir?",
            image: "💬",
            tip: "'Thank you' pronuncia-se 'Thênk iú'. 'Please' pronuncia-se 'Plíz'.",
          },
          {
            title: "Pratique todos os dias",
            content:
              "Tente dizer pelo menos uma palavra em inglês por dia. Quando acordar, diga 'Good morning!'. Antes de dormir, diga 'Good night!' (Boa noite). A repetição é o segredo do aprendizado!",
            image: "📅",
            tip: "O aplicativo Duolingo (gratuito) tem lições de inglês ótimas para iniciantes. Baixe no celular!",
          },
        ],
      },
      {
        id: "lang-2",
        title: "Inglês: No médico",
        description: "Palavras importantes de saúde em inglês",
        completed: false,
        locked: false,
        duration: "8 min",
        difficulty: "Fácil",
        videoSearchQuery: "inglês médico vocabulário básico",
        steps: [
          {
            title: "Por que aprender inglês médico?",
            content:
              "Se precisar de atendimento fora do Brasil, ou entender uma bula em inglês, essas palavras vão ajudar muito. Médicos no exterior costumam entender inglês básico.",
            image: "🏥",
          },
          {
            title: "Partes do corpo em inglês",
            content:
              "Head = Cabeça | Eye = Olho | Ear = Ouvido | Throat = Garganta | Chest = Peito | Stomach = Estômago | Back = Costas | Leg = Perna | Arm = Braço | Hand = Mão",
            image: "🫀",
          },
          {
            title: "Frases para o médico",
            content:
              "I have pain in my [parte do corpo] = Tenho dor no/na [parte] | I feel dizzy = Estou com tontura | I have a fever = Estou com febre | I'm allergic to [remédio] = Sou alérgico a [remédio]",
            image: "💉",
          },
          {
            title: "Palavras de medicamentos",
            content:
              "Tablet / Pill = Comprimido | Capsule = Cápsula | Drops = Gotas | Syrup = Xarope | Ointment = Pomada | Injection = Injeção | Prescription = Receita médica | Take 2 times a day = Tome 2 vezes ao dia",
            image: "💊",
            tip: "Guarde essas palavras num papel na sua carteira para caso de emergência no exterior.",
          },
        ],
      },
      {
        id: "lang-3",
        title: "Espanhol básico",
        description: "Comunique-se em países vizinhos",
        completed: false,
        locked: false,
        duration: "8 min",
        difficulty: "Fácil",
        videoSearchQuery: "espanhol básico para brasileiros iniciantes",
        steps: [
          {
            title: "Espanhol para brasileiros",
            content:
              "Espanhol é muito parecido com o português! Com o nosso idioma como base, aprender espanhol é muito mais fácil. É o segundo idioma mais falado no mundo.",
            image: "🇪🇸",
            tip: "Argentina, Uruguai, Paraguai, Peru, México... são 20 países onde você pode usar o espanhol!",
          },
          {
            title: "Saudações em espanhol",
            content:
              "¡Hola! = Olá | Buenos días = Bom dia | Buenas tardes = Boa tarde | Buenas noches = Boa noite | ¿Cómo estás? = Como você está? | Bien, gracias = Bem, obrigado(a) | Hasta luego = Até logo",
            image: "👋",
          },
          {
            title: "Palavras do dia a dia",
            content:
              "Por favor = Por favor (igual!) | Gracias = Obrigado(a) | De nada = De nada (igual!) | Lo siento = Desculpe | Sí = Sim | No = Não (igual!) | ¿Cuánto cuesta? = Quanto custa? | La cuenta = A conta",
            image: "💬",
            tip: "Várias palavras são iguais ou quase iguais em português! Fica fácil.",
          },
          {
            title: "Números em espanhol",
            content:
              "Uno=1, Dos=2, Tres=3, Cuatro=4, Cinco=5, Seis=6, Siete=7, Ocho=8, Nueve=9, Diez=10, Veinte=20, Cien=100, Mil=1000.",
            image: "🔢",
            tip: "Os números em espanhol são muito parecidos com português — você já sabe quase todos!",
          },
        ],
      },
    ],
  },
  {
    id: "citizenship",
    name: "Cidadania Digital",
    emoji: "🏛️",
    color: "bg-amber-600 hover:bg-amber-700",
    borderColor: "border-amber-400",
    description: "INSS, gov.br, SUS e seus direitos",
    lessons: [
      {
        id: "citizen-1",
        title: "Consultar INSS pelo celular",
        description: "Veja seu extrato e benefícios no Meu INSS",
        completed: false,
        locked: false,
        duration: "10 min",
        difficulty: "Médio",
        videoSearchQuery: "como consultar inss pelo celular meu inss aplicativo",
        steps: [
          {
            title: "O que é o Meu INSS?",
            content:
              "O Meu INSS é o aplicativo oficial do Instituto Nacional do Seguro Social. Por ele você consulta seu extrato de aposentadoria, pede benefícios, e resolve situações sem precisar ir à agência.",
            image: "🏛️",
            tip: "Com o Meu INSS, você evita filas e horas de espera nas agências!",
          },
          {
            title: "Passo 1: Baixar o aplicativo",
            content:
              "Abra a Google Play Store (Android) ou App Store (iPhone). Pesquise 'Meu INSS'. Baixe o aplicativo oficial — verifique se é do 'Ministério da Previdência Social'.",
            image: "📲",
            warning: "Cuidado com apps falsos! O app oficial é gratuito e tem o nome exato 'Meu INSS'.",
          },
          {
            title: "Passo 2: Fazer login com gov.br",
            content:
              "Abra o Meu INSS e toque em 'Entrar'. O app vai pedir seu login do gov.br (CPF e senha). Se não tiver conta no gov.br, crie primeiro pelo site www.gov.br.",
            image: "🔑",
            tip: "Use o mesmo CPF e senha que você criou no gov.br.",
          },
          {
            title: "Passo 3: Consultar extrato",
            content:
              "Após entrar, toque em 'Extrato de Pagamento'. Você vai ver os últimos pagamentos do seu benefício, com data e valor. Muito útil para confirmar se o pagamento foi feito.",
            image: "📋",
          },
          {
            title: "Passo 4: Outros serviços",
            content:
              "Pelo Meu INSS você também pode: requerer aposentadoria, pedir revisão de benefícios, agendar perícia médica, emitir Declaração de Benefício e consultar carta de concessão.",
            image: "📄",
            tip: "Salve o comprovante da declaração de benefício — é necessário para solicitar crédito consignado.",
          },
          {
            title: "Prova de vida digital",
            content:
              "Todo ano o INSS pede prova de vida. Pelo app Meu INSS você faz isso pelo celular mesmo, sem sair de casa! Toque em 'Prova de Vida' e siga as instruções de reconhecimento facial.",
            image: "🤳",
            tip: "Faça a prova de vida digital em casa, sem enfrentar filas no banco!",
          },
        ],
      },
      {
        id: "citizen-2",
        title: "Carteira de Trabalho Digital",
        description: "Acesse sua carteira profissional pelo celular",
        completed: false,
        locked: false,
        duration: "8 min",
        difficulty: "Médio",
        videoSearchQuery: "carteira de trabalho digital como acessar pelo celular",
        steps: [
          {
            title: "O que é a Carteira de Trabalho Digital?",
            content:
              "A Carteira de Trabalho física foi substituída pela digital. Pelo celular você vê todo o histórico de empregos, salários e contribuições ao longo da sua vida profissional.",
            image: "📇",
            tip: "Você não precisa mais carregar a carteira física — mas guarde-a bem em casa!",
          },
          {
            title: "Passo 1: Baixar o app CTPS Digital",
            content:
              "Abra a loja de aplicativos do seu celular. Pesquise 'Carteira de Trabalho Digital'. Baixe o app oficial do Ministério do Trabalho e Emprego (é gratuito).",
            image: "📲",
          },
          {
            title: "Passo 2: Entrar com gov.br",
            content:
              "Abra o aplicativo e toque em 'Entrar com gov.br'. Digite seu CPF e senha do gov.br. Se ainda não tem conta no gov.br, você precisa criar primeiro.",
            image: "🔑",
          },
          {
            title: "Passo 3: Consultar seu histórico",
            content:
              "Após entrar, você pode ver: todos os contratos de trabalho, datas de admissão e demissão, último salário, e contribuições para o FGTS.",
            image: "📋",
            tip: "O histórico completo é importante para requerer aposentadoria — todos os vínculos são registrados aqui.",
          },
        ],
      },
      {
        id: "citizen-3",
        title: "SUS: Agendamento online",
        description: "Agende consultas e exames pela internet",
        completed: false,
        locked: false,
        duration: "8 min",
        difficulty: "Médio",
        videoSearchQuery: "como agendar consulta sus pelo celular",
        steps: [
          {
            title: "SUS pelo celular",
            content:
              "O Sistema Único de Saúde (SUS) tem um aplicativo chamado 'Meu SUS Digital' onde você pode agendar consultas, ver resultados de exames e acessar seu histórico de saúde.",
            image: "🏥",
            tip: "Com o Meu SUS Digital você tem seu histórico de saúde sempre na mão!",
          },
          {
            title: "Passo 1: Baixar o app",
            content:
              "Pesquise 'Meu SUS Digital' na Google Play ou App Store. Baixe o app oficial do Ministério da Saúde. O app é gratuito.",
            image: "📲",
            warning: "Baixe apenas o app oficial 'Meu SUS Digital' — verifique o nome exato.",
          },
          {
            title: "Passo 2: Cadastrar com gov.br",
            content:
              "Abra o app e entre com seu CPF e senha do gov.br. Após entrar, seu Cartão Nacional de Saúde (CNS) aparece automaticamente.",
            image: "🔑",
          },
          {
            title: "Passo 3: Agendar consulta",
            content:
              "Toque em 'Agendamentos'. Escolha o tipo de serviço (consulta, exame, vacina). O app mostra as unidades de saúde disponíveis perto de você. Escolha horário e confirme.",
            image: "📅",
            tip: "Você recebe confirmação por SMS e pode cancelar ou remarcar pelo próprio app.",
          },
          {
            title: "Histórico de vacinação",
            content:
              "No app você encontra seu histórico completo de vacinas, incluindo a da COVID-19. É útil para mostrar ao médico e para viagens internacionais.",
            image: "💉",
            tip: "Imprima ou salve a tela com seu histórico de vacinação para ter como comprovante.",
          },
        ],
      },
      {
        id: "citizen-4",
        title: "Imposto de Renda simplificado",
        description: "Entenda e declare o IR pelo celular",
        completed: false,
        locked: false,
        duration: "12 min",
        difficulty: "Difícil",
        videoSearchQuery: "como declarar imposto de renda pelo celular passo a passo",
        steps: [
          {
            title: "Quem precisa declarar?",
            content:
              "Você precisa declarar Imposto de Renda se em 2024 recebeu mais de R$30.639,90 em rendimentos (aposentadoria, aluguel, trabalho, etc.), ou se teve bens acima de R$800.000.",
            image: "📊",
            tip: "Aposentados do INSS que recebem apenas o benefício abaixo do limite geralmente estão isentos. Consulte um contador para confirmar.",
          },
          {
            title: "Prazo de entrega",
            content:
              "A declaração é entregue todo ano entre março e maio. Em 2025, o prazo é até 30 de maio. Quem entrega depois do prazo paga multa mínima de R$165,74.",
            image: "📅",
            warning: "Não deixe para a última hora! As filas virtuais ficam cheias perto do prazo.",
          },
          {
            title: "Documentos necessários",
            content:
              "Separe: CPF, título de eleitor, informe de rendimentos (o banco e o INSS enviam por carta ou app), comprovante de endereço, recibos médicos do ano, e número do IPTU se tiver imóvel.",
            image: "📄",
            tip: "O informe de rendimentos do INSS pode ser baixado pelo app Meu INSS em Extrato > Informe de Rendimentos.",
          },
          {
            title: "App Meu Imposto de Renda",
            content:
              "Baixe o app 'Meu Imposto de Renda' da Receita Federal. Ele tem uma versão simplificada chamada 'Declaração Pré-preenchida' onde muitos dados já vêm preenchidos automaticamente.",
            image: "📱",
            tip: "A declaração pré-preenchida facilita muito — verifique os dados e ajuste o que estiver errado.",
          },
          {
            title: "Quando precisar de ajuda",
            content:
              "Se a declaração for complexa, procure um contador ou o CRAS (Centro de Referência da Assistência Social) da sua cidade — muitos oferecem auxílio gratuito para idosos. Também há grupos de voluntários que ajudam gratuitamente.",
            image: "🤝",
            tip: "O CRAS oferece ajuda gratuita para declarar IR. Procure o mais próximo pelo site do MDS ou pelo telefone 08006441407.",
          },
        ],
      },
      {
        id: "citizen-5",
        title: "Como identificar e evitar golpes",
        description: "Proteja seu dinheiro e seus dados",
        completed: false,
        locked: false,
        duration: "12 min",
        difficulty: "Fácil",
        videoSearchQuery: "como evitar golpes celular idosos whatsapp pix",
        steps: [
          {
            title: "Idosos são alvo de golpistas",
            content:
              "Infelizmente, idosos são os principais alvos de golpes digitais. Mas com informação, você pode se proteger facilmente. Conhecer os golpes mais comuns é o primeiro passo.",
            image: "🚨",
            warning: "Desconfiança é proteção! Na dúvida, sempre consulte um familiar ou amigo antes de agir.",
          },
          {
            title: "Golpe do falso parente",
            content:
              "Como funciona: você recebe mensagem de um número novo dizendo 'Mãe, troquei de número, pode salvar?' ou 'Preciso de dinheiro urgente'. É um golpista. Sempre ligue para o número antigo do parente para confirmar.",
            image: "📱",
            warning: "NUNCA faça PIX ou transferência para número desconhecido, mesmo que diga ser parente!",
          },
          {
            title: "Golpe da central falsa",
            content:
              "Como funciona: ligam dizendo ser do banco, Receita Federal ou INSS, pedindo seus dados, senha ou solicitando que você baixe um app. Bancos NUNCA pedem senha por telefone. Desligue e ligue para o número oficial do banco.",
            image: "☎️",
            tip: "O número oficial dos bancos fica no verso do seu cartão ou no site oficial do banco.",
          },
          {
            title: "Golpe do link suspeito",
            content:
              "Como funciona: você recebe um link pelo WhatsApp ou SMS dizendo 'confirme seu benefício', 'você ganhou um prêmio' ou 'seu cadastro vai ser cancelado'. Não clique! Esses links instalam vírus ou roubam seus dados.",
            image: "🔗",
            warning: "Nunca clique em links recebidos por WhatsApp ou SMS de desconhecidos, mesmo que pareçam ser do banco ou governo.",
          },
          {
            title: "Seus direitos se for vítima",
            content:
              "Se cair em um golpe: ligue imediatamente para o banco para bloquear transferências, registre um Boletim de Ocorrência (pode ser online em delegaciavirtual.pc.sp.gov.br ou pelo app), e denuncie ao Procon pelo telefone 151.",
            image: "⚖️",
            tip: "Procure um familiar ou assistente social do CRAS para ajudar a registrar a ocorrência.",
          },
        ],
      },
    ],
  },
  {
    id: "finance",
    name: "Finanças",
    emoji: "💰",
    color: "bg-teal-600 hover:bg-teal-700",
    borderColor: "border-teal-400",
    description: "Cuide do dinheiro e conheça seus direitos",
    lessons: [
      {
        id: "finance-1",
        title: "Entendendo a aposentadoria",
        description: "Tudo sobre benefícios e direitos do INSS",
        completed: false,
        locked: false,
        duration: "10 min",
        difficulty: "Fácil",
        videoSearchQuery: "aposentadoria inss como funciona direitos",
        steps: [
          {
            title: "Tipos de aposentadoria",
            content:
              "No Brasil existem: Aposentadoria por Idade (65 anos homens / 62 anos mulheres), Aposentadoria por Tempo de Contribuição, Aposentadoria por Invalidez (incapacidade permanente), e BPC/LOAS (para idosos de baixa renda com 65+ anos).",
            image: "👴",
            tip: "O BPC/LOAS é um salário mínimo para idosos 65+ com renda familiar per capita abaixo de 1/4 do salário mínimo. Não precisa ter contribuído para o INSS!",
          },
          {
            title: "Como requerer aposentadoria",
            content:
              "Você pode pedir aposentadoria pelo app Meu INSS (mais fácil), pelo site meu.inss.gov.br, ou presencialmente em uma Agência da Previdência Social. O prazo de análise é de até 90 dias.",
            image: "📋",
            tip: "Agende pelo Meu INSS para evitar filas — você escolhe o dia e hora da sua perícia ou entrevista.",
          },
          {
            title: "Documentos para aposentadoria",
            content:
              "Você vai precisar: CPF, RG, Carteira de Trabalho (física e digital), PIS/PASEP ou NIT, comprovante de residência, e certidão de nascimento ou casamento.",
            image: "📄",
          },
          {
            title: "Direito a revisão",
            content:
              "Se acha que seu benefício foi calculado errado, tem direito a pedir revisão. Contrate um advogado previdencialista (muitos cobram só se ganhar o caso). Sindicatos e o CRAS podem indicar advogados gratuitos.",
            image: "⚖️",
            tip: "Você tem até 10 anos para pedir revisão de uma aposentadoria concedida incorretamente.",
          },
          {
            title: "13º salário do INSS",
            content:
              "Quem recebe aposentadoria, pensão por morte ou auxílio-doença tem direito ao 13º salário do INSS. É pago em duas parcelas: geralmente em agosto e novembro de cada ano.",
            image: "🎁",
            tip: "O 13º salário do INSS é automático — você não precisa fazer nada para receber. Basta verificar o extrato no Meu INSS.",
          },
        ],
      },
      {
        id: "finance-2",
        title: "Internet banking com segurança",
        description: "Use o banco pelo celular sem riscos",
        completed: false,
        locked: false,
        duration: "10 min",
        difficulty: "Médio",
        videoSearchQuery: "como usar aplicativo banco celular segurança",
        steps: [
          {
            title: "Banco pelo celular é seguro?",
            content:
              "Sim! Os aplicativos dos bancos são muito seguros quando você toma os cuidados certos. É muito mais prático do que ir à agência e evita enfrentar filas longas.",
            image: "🏦",
            tip: "Baixe apenas o app oficial do seu banco — pesquise pelo nome do banco na loja de apps.",
          },
          {
            title: "Regra de ouro: senha única",
            content:
              "Use uma senha diferente para o app do banco em relação a outras senhas. Não use datas de aniversário, sequências fáceis (1234) ou seu CPF como senha. Use uma combinação de números que só você sabe.",
            image: "🔐",
            warning: "NUNCA compartilhe sua senha do banco com ninguém — nem com filhos, funcionários do banco ou atendentes de telemarketing.",
          },
          {
            title: "Use apenas Wi-Fi confiável",
            content:
              "Evite usar o app do banco em Wi-Fi de shopping, café ou aeroporto. Use preferencialmente a internet 4G/5G do seu celular ou o Wi-Fi da sua casa.",
            image: "📶",
            warning: "Redes Wi-Fi públicas podem ser monitoradas por pessoas mal-intencionadas.",
          },
          {
            title: "Ative notificações",
            content:
              "No app do banco, ative as notificações de movimentação. Assim, toda vez que sair dinheiro da sua conta você recebe um aviso no celular em tempo real.",
            image: "🔔",
            tip: "Se receber notificação de movimentação que não foi você, ligue imediatamente para o banco para bloquear o cartão.",
          },
          {
            title: "Não instale apps estranhos",
            content:
              "Se receber instrução para instalar um app de 'suporte técnico' ou 'atualização do banco', é golpe! Bancos nunca pedem para instalar nada por telefone ou mensagem.",
            image: "🚫",
            warning: "Apps de acesso remoto (AnyDesk, TeamViewer) são usados em golpes bancários. Jamais instale a pedido de desconhecidos.",
          },
        ],
      },
      {
        id: "finance-3",
        title: "Crédito consignado",
        description: "Entenda antes de assinar qualquer contrato",
        completed: false,
        locked: false,
        duration: "8 min",
        difficulty: "Fácil",
        videoSearchQuery: "credito consignado aposentado cuidados vantagens",
        steps: [
          {
            title: "O que é o consignado?",
            content:
              "O crédito consignado é um empréstimo cujas parcelas são descontadas diretamente da aposentadoria ou pensão. A taxa de juros é menor que outros empréstimos.",
            image: "💳",
          },
          {
            title: "Vantagens",
            content:
              "Taxa de juros mais baixa (lei limita a 1,80% ao mês para aposentados), aprovação fácil (não precisa de garantias), e não precisa de fiador.",
            image: "✅",
          },
          {
            title: "Atenção: margem consignável",
            content:
              "O desconto não pode passar de 35% do seu benefício mensal. Verifique no Meu INSS qual é sua margem disponível antes de assinar qualquer contrato.",
            image: "📊",
            warning: "Nunca contrate consignado por telefone com quem ligou para você — pode ser golpe! Vá pessoalmente ao banco ou pelo Meu INSS.",
          },
          {
            title: "Cuidado com o consignado não autorizado",
            content:
              "Se perceber desconto no seu benefício que não reconhece, acesse o Meu INSS e veja em 'Empréstimos'. Se houver algo irregular, registre queixa no INSS pelo 135 e no Procon pelo 151.",
            image: "🚨",
            warning: "Golpe comum: ligam dizendo que você foi aprovado para consignado e pedem dados. Depois fazem empréstimo sem sua autorização real!",
          },
        ],
      },
    ],
  },
];

export const allLessonsMap: Record<string, LessonItem> = {};
categoriesData.forEach((cat) => {
  cat.lessons.forEach((lesson) => {
    allLessonsMap[lesson.id] = lesson;
  });
});
