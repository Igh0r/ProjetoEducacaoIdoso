part of 'package:educacao_idoso/main.dart';

List<LessonStep> standardSteps(String topic, String emoji) => [
      LessonStep('Entenda o objetivo', 'Nesta aula você aprende $topic com calma, usando palavras simples e exemplos do dia a dia.', emoji, tip: 'Reserve alguns minutos e mantenha o celular carregado.'),
      const LessonStep('Faça um passo por vez', 'Leia a tela, toque apenas uma vez no botão desejado e espere a resposta do aparelho antes de tocar novamente.', '👆', tip: 'Se algo sair errado, use o botão voltar ou peça ajuda.'),
      const LessonStep('Pratique com segurança', 'Repita a ação em um momento tranquilo. Evite compartilhar senhas, códigos e documentos por mensagem.', '🔒', warning: 'Nunca entregue senha ou código de confirmação a desconhecidos.'),
    ];

List<QuizQuestion> standardQuiz(String topic) => [
      QuizQuestion('Qual é a melhor forma de aprender $topic?', ['Tocar rápido em tudo', 'Fazer um passo por vez', 'Compartilhar a senha'], 1, 'Um passo por vez reduz erros e aumenta a confiança.'),
      const QuizQuestion('O que fazer se aparecer uma mensagem pedindo senha ou código?', ['Enviar para ajudar', 'Ignorar e confirmar com fonte confiável', 'Postar em redes sociais'], 1, 'Senhas e códigos são pessoais. Confirme sempre por canais oficiais.'),
    ];

final categories = <LessonCategory>[
  LessonCategory('technology', 'Tecnologia', '💻', Colors.blue, 'Aprenda a usar celular, WhatsApp e internet', [
    Lesson(
      id: 'tech-1',
      title: 'Como usar o WhatsApp',
      description: 'Envie mensagens, fotos e áudios',
      emoji: '💬',
      duration: '8 min',
      difficulty: 'Fácil',
      minutes: 8,
      steps: [
        LessonStep('O que é o WhatsApp?', 'O WhatsApp é um aplicativo gratuito para enviar mensagens, fotos e fazer chamadas usando internet.', '💬', tip: 'Use Wi-Fi quando possível para economizar dados móveis.'),
        LessonStep('Abrir o aplicativo', 'Procure o ícone verde com telefone branco e toque uma vez para abrir.', '📱'),
        LessonStep('Escolher contato', 'Toque no balão de conversa, escolha a pessoa e abra a conversa.', '👥'),
        LessonStep('Enviar mensagem', 'Toque no campo “Mensagem”, escreva e toque na seta verde para enviar.', '⌨️', tip: 'Para áudio, segure o microfone, fale e solte.'),
      ],
      quiz: [
        QuizQuestion('Para que serve o WhatsApp?', ['Apenas para jogos', 'Mensagens, fotos, áudios e chamadas', 'Somente para banco'], 1, 'O WhatsApp facilita comunicação com família e amigos.'),
        QuizQuestion('Como enviar áudio?', ['Segurar o microfone, falar e soltar', 'Desligar o celular', 'Apagar o contato'], 0, 'Segure o microfone enquanto fala e solte para enviar.'),
      ],
    ),
    Lesson(id: 'tech-2', title: 'Fazendo videochamadas', description: 'Veja a família de qualquer lugar', emoji: '📹', duration: '6 min', difficulty: 'Fácil', minutes: 6, steps: standardSteps('a fazer videochamadas pelo celular', '📹'), quiz: standardQuiz('videochamadas')),
    Lesson(
      id: 'tech-3', title: 'Como acessar o gov.br', description: 'Acesse serviços do governo pelo celular', emoji: '🏛️', duration: '12 min', difficulty: 'Médio', minutes: 12,
      steps: const [
        LessonStep('Use canais oficiais', 'Abra o aplicativo gov.br ou digite gov.br no navegador. Evite links recebidos por mensagem.', '🏛️', warning: 'Nunca informe senha do gov.br fora do aplicativo ou site oficial.'),
        LessonStep('Entrar com CPF', 'Digite seu CPF, confira os números e toque em continuar. Depois informe sua senha.', '🪪', tip: 'Se esquecer a senha, use “Esqueci minha senha” no canal oficial.'),
        LessonStep('Confirme com calma', 'Leia cada tela antes de autorizar acesso a serviços como INSS, SUS ou documentos digitais.', '✅'),
      ],
      quiz: const [
        QuizQuestion('Qual é o local mais seguro para acessar serviços do governo?', ['Link de mensagem desconhecida', 'Aplicativo ou site oficial gov.br', 'Perfil de rede social'], 1, 'Serviços públicos digitais devem ser acessados por canais oficiais.'),
        QuizQuestion('O que fazer ao esquecer a senha gov.br?', ['Usar “Esqueci minha senha” no canal oficial', 'Pedir senha emprestada', 'Enviar CPF em grupo'], 0, 'A recuperação de senha deve ser feita pelo fluxo oficial.'),
      ],
    ),
    Lesson(
      id: 'tech-4', title: 'Usando o PIX', description: 'Transfira dinheiro de forma rápida e gratuita', emoji: '⚡', duration: '10 min', difficulty: 'Médio', minutes: 10,
      steps: const [
        LessonStep('Comece pelo app do banco', 'Abra somente o aplicativo oficial do seu banco e escolha PIX.', '🏦'),
        LessonStep('Confira os dados', 'Antes de confirmar, verifique nome, banco e valor. Se estiver diferente, cancele.', '🔎', warning: 'Não faça PIX por pressão, ameaça ou promessa de prêmio.'),
        LessonStep('Guarde o comprovante', 'Depois de enviar, salve ou compartilhe o comprovante apenas com quem deve receber.', '🧾'),
      ],
      quiz: const [
        QuizQuestion('Antes de confirmar um PIX, o que conferir?', ['Nome, banco e valor', 'Somente a cor do aplicativo', 'Nada, é sempre automático'], 0, 'A conferência evita transferências para pessoas erradas ou golpes.'),
        QuizQuestion('Se alguém pressionar por PIX urgente, o melhor é:', ['Transferir rápido', 'Parar e confirmar por canal confiável', 'Mandar sua senha'], 1, 'Golpistas usam urgência para reduzir sua atenção.'),
      ],
    ),
    Lesson(id: 'tech-5', title: 'Usando o YouTube', description: 'Assista vídeos, receitas e novelas', emoji: '▶️', duration: '8 min', difficulty: 'Fácil', minutes: 8, steps: standardSteps('a procurar vídeos no YouTube', '▶️'), quiz: standardQuiz('YouTube')),
    Lesson(id: 'tech-6', title: 'Usando o Google Maps', description: 'Encontre endereços e trace rotas', emoji: '🗺️', duration: '8 min', difficulty: 'Fácil', minutes: 8, steps: standardSteps('a encontrar caminhos no mapa', '🗺️'), quiz: standardQuiz('mapas')),
  ]),
  LessonCategory('health', 'Saúde', '❤️', Colors.red, 'Cuide melhor da sua saúde e bem-estar', [
    Lesson(id: 'health-1', title: 'Exercícios para o dia a dia', description: 'Atividades leves que você pode fazer em casa', emoji: '🧘', duration: '10 min', difficulty: 'Fácil', minutes: 10, steps: standardSteps('movimentos leves para bem-estar', '🧘'), quiz: standardQuiz('exercícios leves')),
    Lesson(
      id: 'health-2', title: 'Controlando seus remédios', description: 'Não esqueça mais nenhum comprimido', emoji: '💊', duration: '8 min', difficulty: 'Fácil', minutes: 8,
      steps: const [
        LessonStep('Monte uma lista', 'Anote nome do remédio, horário, dose e orientação do profissional de saúde.', '📝'),
        LessonStep('Use alarmes', 'Configure alarmes no celular com o nome do remédio e o horário correto.', '⏰', tip: 'Caixas organizadoras ajudam a conferir se a dose foi tomada.'),
        LessonStep('Não mude sozinho', 'Se sentir desconforto, fale com médico, enfermeiro ou farmacêutico antes de mudar a dose.', '🩺', warning: 'Nunca pare ou aumente remédio sem orientação profissional.'),
      ],
      quiz: const [
        QuizQuestion('O que deve aparecer na lista de remédios?', ['Nome, dose e horário', 'Apenas a cor da caixa', 'Somente o preço'], 0, 'Informações claras reduzem esquecimentos e confusões.'),
        QuizQuestion('Se o remédio causar desconforto, você deve:', ['Mudar a dose sozinho', 'Consultar profissional de saúde', 'Jogar tudo fora'], 1, 'Mudanças de medicação precisam de orientação profissional.'),
      ],
    ),
    Lesson(id: 'health-3', title: 'Alimentação saudável', description: 'Dicas de nutrição para viver melhor', emoji: '🥗', duration: '8 min', difficulty: 'Fácil', minutes: 8, steps: standardSteps('escolhas simples de alimentação saudável', '🥗'), quiz: standardQuiz('alimentação saudável')),
    Lesson(id: 'health-4', title: 'Memória e saúde mental', description: 'Exercícios para manter a mente afiada', emoji: '🧠', duration: '10 min', difficulty: 'Fácil', minutes: 10, steps: standardSteps('exercícios para memória e bem-estar mental', '🧠'), quiz: standardQuiz('memória')),
    Lesson(id: 'health-5', title: 'Em caso de emergência', description: 'O que fazer e quem chamar', emoji: '🚑', duration: '7 min', difficulty: 'Fácil', minutes: 7, steps: standardSteps('números e ações em emergências', '🚑'), quiz: standardQuiz('emergência')),
  ]),
  LessonCategory('hobbies', 'Hobbies', '🎨', Colors.purple, 'Descubra novos passatempos e criatividade', [
    Lesson(id: 'hobby-1', title: 'Jardinagem em casa', description: 'Aprenda a cuidar de plantas e ter uma horta', emoji: '🌱', duration: '10 min', difficulty: 'Fácil', minutes: 10, steps: standardSteps('jardinagem simples em casa', '🌱'), quiz: standardQuiz('jardinagem')),
    Lesson(id: 'hobby-2', title: 'Pintura com aquarela', description: 'Descubra o artista dentro de você', emoji: '🎨', duration: '12 min', difficulty: 'Fácil', minutes: 12, steps: standardSteps('pintura com aquarela', '🎨'), quiz: standardQuiz('aquarela')),
    Lesson(id: 'hobby-3', title: 'Fotografia com o celular', description: 'Tire fotos bonitas do cotidiano', emoji: '📷', duration: '8 min', difficulty: 'Fácil', minutes: 8, steps: standardSteps('fotografia com celular', '📷'), quiz: standardQuiz('fotografia')),
    Lesson(id: 'hobby-4', title: 'Leitura digital', description: 'Leia livros e jornais no celular de graça', emoji: '📚', duration: '8 min', difficulty: 'Fácil', minutes: 8, steps: standardSteps('leitura digital no celular', '📚'), quiz: standardQuiz('leitura digital')),
  ]),
  LessonCategory('languages', 'Idiomas', '🌎', Colors.green, 'Aprenda palavras e frases em outro idioma', [
    Lesson(id: 'lang-1', title: 'Inglês: Saudações do dia a dia', description: 'Como cumprimentar e se apresentar', emoji: '👋', duration: '8 min', difficulty: 'Fácil', minutes: 8, steps: standardSteps('saudações simples em inglês', '👋'), quiz: standardQuiz('inglês básico')),
    Lesson(id: 'lang-2', title: 'Inglês: No médico', description: 'Palavras importantes de saúde em inglês', emoji: '🩺', duration: '8 min', difficulty: 'Fácil', minutes: 8, steps: standardSteps('palavras de saúde em inglês', '🩺'), quiz: standardQuiz('inglês no médico')),
    Lesson(id: 'lang-3', title: 'Espanhol básico', description: 'Comunique-se em países vizinhos', emoji: '🇪🇸', duration: '8 min', difficulty: 'Fácil', minutes: 8, steps: standardSteps('frases simples em espanhol', '🇪🇸'), quiz: standardQuiz('espanhol básico')),
  ]),
  LessonCategory('citizenship', 'Cidadania Digital', '🏛️', Colors.amber, 'INSS, gov.br, SUS e seus direitos', [
    Lesson(id: 'citizen-1', title: 'Consultar INSS pelo celular', description: 'Veja seu extrato e benefícios no Meu INSS', emoji: '📋', duration: '10 min', difficulty: 'Médio', minutes: 10, steps: standardSteps('consulta do INSS pelo celular', '📋'), quiz: standardQuiz('Meu INSS')),
    Lesson(id: 'citizen-2', title: 'Carteira de Trabalho Digital', description: 'Acesse sua carteira profissional pelo celular', emoji: '💼', duration: '8 min', difficulty: 'Médio', minutes: 8, steps: standardSteps('Carteira de Trabalho Digital', '💼'), quiz: standardQuiz('carteira digital')),
    Lesson(id: 'citizen-3', title: 'SUS: Agendamento online', description: 'Agende consultas e exames pela internet', emoji: '🏥', duration: '8 min', difficulty: 'Médio', minutes: 8, steps: standardSteps('agendamento online no SUS', '🏥'), quiz: standardQuiz('SUS online')),
    Lesson(id: 'citizen-4', title: 'Imposto de Renda simplificado', description: 'Entenda e declare o IR pelo celular', emoji: '🧾', duration: '12 min', difficulty: 'Difícil', minutes: 12, steps: standardSteps('noções de Imposto de Renda', '🧾'), quiz: standardQuiz('Imposto de Renda')),
    Lesson(
      id: 'citizen-5', title: 'Como identificar e evitar golpes', description: 'Proteja seu dinheiro e seus dados', emoji: '🛡️', duration: '12 min', difficulty: 'Fácil', minutes: 12,
      steps: const [
        LessonStep('Desconfie de urgência', 'Mensagens com ameaça, prêmio ou pedido de dinheiro rápido podem ser golpe.', '🚨'),
        LessonStep('Proteja códigos e senhas', 'Banco, gov.br e WhatsApp nunca devem pedir código por conversa comum.', '🔐', warning: 'Senha, token e código SMS são pessoais e não devem ser compartilhados.'),
        LessonStep('Confirme por outro canal', 'Ligue para a pessoa ou instituição usando número oficial antes de pagar ou clicar.', '📞'),
      ],
      quiz: const [
        QuizQuestion('Qual sinal indica possível golpe?', ['Pedido urgente de dinheiro', 'Mensagem de bom dia da família', 'Alarme do remédio'], 0, 'Urgência e pressão são técnicas comuns de golpe.'),
        QuizQuestion('O que fazer se pedirem código SMS?', ['Enviar imediatamente', 'Não enviar e confirmar por canal oficial', 'Publicar nas redes'], 1, 'Códigos podem dar acesso às suas contas.'),
      ],
    ),
  ]),
  LessonCategory('finance', 'Finanças', '💰', Colors.teal, 'Cuide do dinheiro e conheça seus direitos', [
    Lesson(id: 'finance-1', title: 'Entendendo a aposentadoria', description: 'Tudo sobre benefícios e direitos do INSS', emoji: '👵', duration: '10 min', difficulty: 'Fácil', minutes: 10, steps: standardSteps('direitos básicos da aposentadoria', '👵'), quiz: standardQuiz('aposentadoria')),
    Lesson(
      id: 'finance-2', title: 'Internet banking com segurança', description: 'Use o banco pelo celular sem riscos', emoji: '🏦', duration: '10 min', difficulty: 'Médio', minutes: 10,
      steps: const [
        LessonStep('Abra o app oficial', 'Use o aplicativo instalado pela loja oficial ou orientado pelo seu banco.', '📲'),
        LessonStep('Confira cadeado e dados', 'Não entre no banco por links de mensagens. Confira beneficiário, valor e data antes de confirmar.', '🔎', warning: 'Banco não pede senha completa, token ou foto do cartão por telefone ou mensagem.'),
        LessonStep('Saia ao terminar', 'Ao finalizar, feche o aplicativo e bloqueie o celular com senha ou biometria.', '🔒'),
      ],
      quiz: const [
        QuizQuestion('Como acessar o banco com mais segurança?', ['Por link recebido em mensagem', 'Pelo aplicativo oficial', 'Por site desconhecido'], 1, 'O app oficial reduz risco de páginas falsas.'),
        QuizQuestion('Banco pedindo token por WhatsApp é:', ['Normal', 'Sinal de golpe', 'Obrigatório para todos'], 1, 'Tokens e senhas não devem ser enviados por conversa.'),
      ],
    ),
    Lesson(id: 'finance-3', title: 'Crédito consignado', description: 'Entenda antes de assinar qualquer contrato', emoji: '📄', duration: '8 min', difficulty: 'Fácil', minutes: 8, steps: standardSteps('cuidados com crédito consignado', '📄'), quiz: standardQuiz('crédito consignado')),
  ]),
];

