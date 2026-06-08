export interface QuizQuestion {
  question: string;
  options: string[];
  correctIndex: number;
  explanation: string;
}

export const quizData: Record<string, QuizQuestion[]> = {
  "tech-1": [
    {
      question: "Para que serve o WhatsApp?",
      options: [
        "Para fazer compras na internet",
        "Para enviar mensagens, fotos e fazer chamadas",
        "Para pagar contas no banco",
      ],
      correctIndex: 1,
      explanation:
        "Correto! O WhatsApp serve para enviar mensagens, fotos, áudios e fazer chamadas de voz e vídeo.",
    },
    {
      question: "Precisa pagar para usar o WhatsApp?",
      options: [
        "Sim, custa R$10 por mês",
        "Sim, só nos fins de semana é de graça",
        "Não! O WhatsApp é completamente gratuito",
      ],
      correctIndex: 2,
      explanation:
        "O WhatsApp é 100% gratuito! Você só precisa ter internet (Wi-Fi ou dados móveis) no celular.",
    },
    {
      question: "Como você envia uma mensagem de VOZ no WhatsApp?",
      options: [
        "Digitando e apertando Enter",
        "Tocando e segurando o botão do microfone 🎙️",
        "Ligando pelo número de telefone",
      ],
      correctIndex: 1,
      explanation:
        "Para mandar áudio: toque e SEGURE o microfone, fale sua mensagem, e solte o dedo para enviar. Muito mais fácil do que digitar!",
    },
  ],

  "tech-2": [
    {
      question: "Como iniciar uma videochamada pelo WhatsApp?",
      options: [
        "Discando o número pelo teclado",
        "Abrindo a conversa e tocando no ícone de câmera de vídeo no topo",
        "Enviando uma mensagem pedindo a chamada",
      ],
      correctIndex: 1,
      explanation:
        "Correto! Abra a conversa com o contato e toque no ícone de câmera (📹) no canto superior direito para iniciar a videochamada.",
    },
    {
      question: "Durante uma videochamada, onde a outra pessoa vai aparecer?",
      options: [
        "Numa tela separada no celular",
        "Na tela grande — e você aparece numa telinha pequena no canto",
        "No alto-falante, somente com voz",
      ],
      correctIndex: 1,
      explanation:
        "A outra pessoa ocupa a tela principal (grande) e você aparece num quadradinho menor no canto. Assim vocês podem se ver ao mesmo tempo!",
    },
    {
      question: "Para ter uma boa imagem na videochamada, você deve...",
      options: [
        "Ficar num quarto completamente escuro",
        "Usar fone de ouvido e desligar a câmera",
        "Ficar perto de uma janela ou luz acesa, com o rosto bem iluminado",
      ],
      correctIndex: 2,
      explanation:
        "A iluminação é o segredo de uma boa videochamada! Fique de frente para a luz — uma janela aberta funciona muito bem.",
    },
  ],

  "tech-3": [
    {
      question: "O que é o gov.br?",
      options: [
        "Uma loja virtual para compras online",
        "O site oficial do governo para acessar INSS, Carteira de Trabalho e outros serviços",
        "Um aplicativo de notícias do Brasil",
      ],
      correctIndex: 1,
      explanation:
        "O gov.br reúne mais de 4.000 serviços do governo federal num só lugar: INSS, Carteira de Trabalho, Receita Federal, SUS e muito mais.",
    },
    {
      question: "O que você precisa para criar uma conta no gov.br?",
      options: [
        "Passaporte e comprovante de renda",
        "Apenas o seu CPF",
        "Carteira de trabalho e título de eleitor",
      ],
      correctIndex: 1,
      explanation:
        "Para criar conta no gov.br você precisa principalmente do seu CPF. O sistema verifica sua identidade pelo banco digital, reconhecimento facial ou envio de código por SMS.",
    },
    {
      question: "Qual é o endereço correto do site do governo?",
      options: ["www.govbr.com", "www.governo.com.br", "www.gov.br"],
      correctIndex: 2,
      explanation:
        "O endereço correto é www.gov.br. Cuidado com sites falsos com nomes parecidos — sempre verifique o endereço antes de digitar seus dados!",
    },
  ],

  "tech-4": [
    {
      question: "Quando o dinheiro chega ao destino num PIX?",
      options: [
        "Em até 3 dias úteis",
        "Na hora! O PIX é instantâneo",
        "No dia seguinte",
      ],
      correctIndex: 1,
      explanation:
        "O PIX é instantâneo — o dinheiro chega em segundos, 24 horas por dia, inclusive fins de semana e feriados!",
    },
    {
      question: "O PIX é gratuito para quem usa?",
      options: [
        "Não, custa uma taxa de 1% por transferência",
        "Sim, mas apenas nos dias úteis",
        "Sim, é sempre gratuito para pessoas físicas",
      ],
      correctIndex: 2,
      explanation:
        "O PIX é totalmente gratuito para pessoas físicas! Funciona 24 horas por dia, todos os dias — incluindo sábado, domingo e feriados.",
    },
    {
      question: "O que você DEVE fazer ANTES de confirmar um PIX?",
      options: [
        "Enviar logo para não perder o prazo",
        "Verificar se o nome da pessoa que vai receber está correto",
        "Ligar para o banco para pedir autorização",
      ],
      correctIndex: 1,
      explanation:
        "SEMPRE verifique o nome do destinatário antes de confirmar o PIX. Se o nome não for o da pessoa certa, cancele imediatamente. PIX enviado para a pessoa errada é muito difícil de recuperar!",
    },
    {
      question: "Você recebe mensagem de número desconhecido dizendo ser seu filho pedindo PIX urgente. O que fazer?",
      options: [
        "Enviar o PIX logo, pois pode ser emergência real",
        "Ligar para o número que você já tem do seu filho para confirmar",
        "Enviar metade do valor primeiro para testar",
      ],
      correctIndex: 1,
      explanation:
        "Este é o 'golpe do falso parente'! NUNCA envie PIX sem antes ligar para o número antigo do familiar. Golpistas criam situações de urgência para te apressar.",
    },
  ],

  "tech-5": [
    {
      question: "Como pesquisar um vídeo no YouTube?",
      options: [
        "Enviando uma mensagem para o YouTube",
        "Tocando na lupa 🔍 e digitando (ou falando) o que quer ver",
        "Ligando para a empresa YouTube",
      ],
      correctIndex: 1,
      explanation:
        "Toque na lupa 🔍 no topo da tela e escreva o que quer ver. Dica: toque no microfone para falar em vez de digitar — muito mais fácil!",
    },
    {
      question: "O YouTube é gratuito?",
      options: [
        "Não, custa R$15 por mês",
        "Sim, é totalmente gratuito",
        "Gratuito só nos fins de semana",
      ],
      correctIndex: 1,
      explanation:
        "O YouTube é gratuito! Existe uma versão paga (YouTube Premium) que remove propagandas, mas a versão gratuita tem todos os vídeos normalmente.",
    },
    {
      question: "Como ver o vídeo em tela cheia (maior)?",
      options: [
        "Toque duas vezes rápido na tela",
        "Vire o celular de lado e toque no ícone de tela cheia",
        "Aumente o volume do celular",
      ],
      correctIndex: 1,
      explanation:
        "Vire o celular deitado (landscape) e toque nos dois quadradinhos no canto inferior direito do vídeo. O vídeo vai ocupar toda a tela!",
    },
  ],

  "tech-6": [
    {
      question: "Para que serve o Google Maps?",
      options: [
        "Para ver o clima e a temperatura",
        "Para encontrar endereços e traçar rotas para chegar a lugares",
        "Para fazer videochamadas com a família",
      ],
      correctIndex: 1,
      explanation:
        "O Google Maps é um mapa interativo no celular! Ele encontra qualquer endereço, mostra como chegar, quanto tempo vai levar e até fala o caminho como um GPS.",
    },
    {
      question: "Qual é a forma mais FÁCIL de pesquisar um lugar no Google Maps?",
      options: [
        "Digitar o endereço completo com CEP",
        "Falar o nome do lugar tocando no microfone 🎙️",
        "Desenhar o caminho na tela",
      ],
      correctIndex: 1,
      explanation:
        "Tocar no microfone e falar o nome do lugar é a forma mais fácil! Você pode dizer 'farmácia mais perto' ou 'UBS perto de mim' e o Maps encontra automaticamente.",
    },
  ],

  "health-1": [
    {
      question: "Quantos minutos de caminhada por dia são recomendados para idosos?",
      options: [
        "Apenas 5 minutos",
        "Pelo menos 20 a 30 minutos",
        "2 horas por dia",
      ],
      correctIndex: 1,
      explanation:
        "20 a 30 minutos de caminhada por dia já fazem uma enorme diferença na saúde! E se não conseguir tudo de uma vez, pode dividir em partes menores ao longo do dia.",
    },
    {
      question: "O exercício 'levanta e senta' serve para quê?",
      options: [
        "Para emagrecer rapidamente",
        "Fortalecer as pernas e ajudar a prevenir quedas",
        "Melhorar a visão",
      ],
      correctIndex: 1,
      explanation:
        "O exercício de levantar e sentar da cadeira fortalece os músculos das pernas e melhora o equilíbrio — fundamental para evitar quedas, que são a principal causa de fraturas em idosos.",
    },
    {
      question: "Quando é o MELHOR horário para regar plantas e também para fazer exercícios ao ar livre?",
      options: [
        "Ao meio-dia, quando o sol está forte",
        "Pela manhã cedo ou ao entardecer",
        "Não importa o horário",
      ],
      correctIndex: 1,
      explanation:
        "Pela manhã ou ao entardecer é ideal tanto para exercícios quanto para jardinagem. Evite o sol forte do meio-dia, que pode causar insolação.",
    },
  ],

  "health-2": [
    {
      question: "Qual é a MELHOR forma de não esquecer os remédios?",
      options: [
        "Esperar sentir falta ou dor antes de tomar",
        "Tomar todos os remédios juntos de manhã",
        "Configurar alarme no celular ou usar um organizador semanal",
      ],
      correctIndex: 2,
      explanation:
        "Alarmes no celular e o organizador semanal são as melhores formas! O organizador deixa claro se você já tomou o remédio do dia — se o compartimento estiver vazio, já tomou!",
    },
    {
      question: "Você pode parar de tomar um remédio se se sentir melhor?",
      options: [
        "Sim, se estiver se sentindo bem pode parar",
        "Sim, mas só depois de 1 mês tomando",
        "Não! Sempre consulte o médico antes de parar qualquer medicamento",
      ],
      correctIndex: 2,
      explanation:
        "NUNCA pare um remédio sem orientação médica, mesmo que se sinta melhor. Muitos remédios (como os de pressão e diabetes) precisam ser tomados continuamente para manter o efeito.",
    },
    {
      question: "Onde colocar a lista de remédios para não esquecer?",
      options: [
        "Num caderno guardado na gaveta",
        "Na geladeira — você vai lá várias vezes por dia e não esquece",
        "No celular, num arquivo de texto",
      ],
      correctIndex: 1,
      explanation:
        "A geladeira é o lugar perfeito! Você vai lá muitas vezes por dia, então a lista fica sempre visível. Coloque nome, dose e horário de cada remédio.",
    },
  ],

  "health-3": [
    {
      question: "Quantos copos de água por dia são recomendados para idosos?",
      options: [
        "2 copos ao acordar e só se sentir sede",
        "Pelo menos 6 a 8 copos por dia, mesmo sem sede",
        "Somente água de coco conta",
      ],
      correctIndex: 1,
      explanation:
        "Com a idade, a sensação de sede diminui, mas o corpo continua precisando de água! Beba pelo menos 6 a 8 copos por dia para evitar desidratação, que pode causar tonturas e cansaço.",
    },
    {
      question: "Qual alimento é especialmente bom para os ossos dos idosos?",
      options: [
        "Refrigerante com sódio",
        "Leite, queijo e derivados (ricos em cálcio)",
        "Embutidos como salsicha e presunto",
      ],
      correctIndex: 1,
      explanation:
        "Leite, queijo e iogurte são ricos em cálcio, essencial para os ossos. Com a idade, os ossos ficam mais frágeis (osteoporose), e o cálcio ajuda a mantê-los fortes.",
    },
  ],

  "health-4": [
    {
      question: "Ler livros e jornais ajuda a...",
      options: [
        "Exercitar o cérebro e ajudar a memória",
        "Melhorar a pressão arterial diretamente",
        "Substituir medicamentos para dormir",
      ],
      correctIndex: 0,
      explanation:
        "A leitura estimula o cérebro, melhora a memória e pode reduzir o risco de Alzheimer. Estudos mostram que pessoas que leem regularmente mantêm a mente mais ativa por mais tempo!",
    },
    {
      question: "Quantas horas de sono são recomendadas para idosos?",
      options: [
        "Apenas 4 horas — idosos precisam dormir menos",
        "Entre 7 e 9 horas por noite",
        "Mais de 12 horas",
      ],
      correctIndex: 1,
      explanation:
        "Idosos precisam de 7 a 9 horas de sono por noite. Um bom sono é fundamental para a memória, o humor e a saúde do coração. Se tiver insônia frequente, converse com o médico.",
    },
    {
      question: "O que fazer para melhorar a qualidade do sono?",
      options: [
        "Usar o celular na cama até adormecer",
        "Tomar qualquer calmante disponível na farmácia",
        "Evitar o celular 1 hora antes de dormir e manter o quarto escuro e fresco",
      ],
      correctIndex: 2,
      explanation:
        "A luz do celular (chamada luz azul) engana o cérebro e dificulta o sono. Deixar o quarto escuro e fresco ajuda o corpo a entrar no ritmo do sono. Nunca tome calmantes sem receita médica!",
    },
  ],

  "health-5": [
    {
      question: "Qual é o número correto para chamar a ambulância?",
      options: ["192 — o SAMU", "190 — a Polícia", "193 — os Bombeiros"],
      correctIndex: 0,
      explanation:
        "O SAMU (Serviço de Atendimento Móvel de Urgência) é chamado pelo 192. É gratuito e funciona 24 horas. Salve esse número agora mesmo no seu celular!",
    },
    {
      question: "Quais são os sinais de AVC (derrame) que exigem SAMU imediato?",
      options: [
        "Fome excessiva, vontade de dormir e sede",
        "Sorriso torto, braço fraco e fala difícil ou embolada",
        "Dor de cabeça leve e cansaço",
      ],
      correctIndex: 1,
      explanation:
        "Sorriso torto, braço que não sobe e fala difícil são sinais de AVC — LIGUE para o SAMU (192) imediatamente! Quanto mais rápido o atendimento, menores são as sequelas.",
    },
    {
      question: "O que você deve fazer ao ligar para o SAMU?",
      options: [
        "Falar rapidamente e desligar logo",
        "Dizer nome, endereço completo e o que está acontecendo, e NÃO desligar",
        "Só dar o endereço e esperar",
      ],
      correctIndex: 1,
      explanation:
        "Ao ligar para o SAMU: diga seu nome, endereço completo (rua, número, bairro) e descreva o que está acontecendo. Não desligue — a equipe vai orientar você até a ambulância chegar.",
    },
  ],

  "citizen-1": [
    {
      question: "Qual é o nome do aplicativo oficial do INSS?",
      options: ["App Previdência Social", "Meu INSS", "INSS Digital Gov"],
      correctIndex: 1,
      explanation:
        "O aplicativo oficial do INSS se chama 'Meu INSS'. Baixe gratuitamente na Google Play (Android) ou App Store (iPhone). Sempre verifique que é do Ministério da Previdência Social.",
    },
    {
      question: "Pelo app Meu INSS, você pode...",
      options: [
        "Sacar dinheiro da sua conta corrente",
        "Ver extrato de pagamentos, fazer prova de vida e agendar perícias",
        "Pagar contas de luz e água",
      ],
      correctIndex: 1,
      explanation:
        "Pelo Meu INSS você consulta extrato de benefícios, faz prova de vida digital (sem sair de casa!), agenda perícias médicas, solicita documentos e muito mais.",
    },
    {
      question: "Como fazer a prova de vida pelo celular?",
      options: [
        "Tirar uma foto da carteira de identidade",
        "No app Meu INSS, tocar em 'Prova de Vida' e seguir as instruções de reconhecimento facial",
        "Ir pessoalmente ao banco todo ano",
      ],
      correctIndex: 1,
      explanation:
        "A prova de vida digital é feita pelo próprio app Meu INSS, com reconhecimento facial (selfie). Assim você não precisa enfrentar filas no banco — tudo pelo celular, em casa!",
    },
  ],

  "citizen-2": [
    {
      question: "A Carteira de Trabalho física foi substituída por quê?",
      options: [
        "Por uma carteirinha de plástico nova",
        "Pela Carteira de Trabalho Digital, acessível pelo celular",
        "Não foi substituída — continua a mesma",
      ],
      correctIndex: 1,
      explanation:
        "Sim! A CTPS Digital substituiu a versão em papel. Você acessa todo o histórico de empregos, salários e contribuições pelo app 'Carteira de Trabalho Digital', gratuitamente.",
    },
    {
      question: "Por que o histórico da Carteira de Trabalho Digital é importante?",
      options: [
        "Serve apenas para conseguir emprego novo",
        "É necessário para requerer aposentadoria — registra todos os vínculos de trabalho",
        "Serve somente para pedir empréstimo no banco",
      ],
      correctIndex: 1,
      explanation:
        "O histórico completo de empregos é fundamental para calcular e requerer a aposentadoria. Todos os vínculos de trabalho ficam registrados digitalmente.",
    },
  ],

  "citizen-3": [
    {
      question: "Qual é o nome do aplicativo para acessar serviços do SUS pelo celular?",
      options: ["SUS App", "Meu SUS Digital", "Saúde Gov"],
      correctIndex: 1,
      explanation:
        "O app 'Meu SUS Digital' do Ministério da Saúde permite agendar consultas, ver resultados de exames, histórico de vacinação e muito mais — tudo de graça!",
    },
    {
      question: "O que você pode fazer pelo app Meu SUS Digital?",
      options: [
        "Comprar remédios com desconto",
        "Agendar consultas, ver histórico de vacinação e resultados de exames",
        "Pagar mensalidade do plano de saúde",
      ],
      correctIndex: 1,
      explanation:
        "Pelo Meu SUS Digital você agenda consultas e exames, acompanha vacinas (incluindo COVID-19), vê resultados de exames e tem acesso ao seu histórico de saúde.",
    },
  ],

  "citizen-5": [
    {
      question: "Recebeu mensagem de número desconhecido dizendo ser seu filho pedindo PIX urgente. O que fazer?",
      options: [
        "Enviar logo, pois pode ser emergência de verdade",
        "Ligar para o número que você já tem do seu filho para confirmar se é ele",
        "Enviar a metade do valor pedido e ver o que acontece",
      ],
      correctIndex: 1,
      explanation:
        "Este é o 'golpe do falso parente' — o mais comum contra idosos! SEMPRE ligue para o número que você já conhece antes de enviar qualquer dinheiro. Nunca confie em número novo.",
    },
    {
      question: "Bancos pedem sua senha ou dados pelo telefone?",
      options: [
        "Sim, quando há alguma irregularidade na conta",
        "Sim, mas somente na central de atendimento oficial",
        "NUNCA! Bancos jamais pedem senha por telefone",
      ],
      correctIndex: 2,
      explanation:
        "Bancos NUNCA pedem sua senha pelo telefone, por WhatsApp ou por mensagem. Se alguém ligar pedindo isso, é golpe! Desligue e ligue direto para o número oficial do banco (no verso do cartão).",
    },
    {
      question: "Chegou um link pelo WhatsApp prometendo benefício extra do governo. O que fazer?",
      options: [
        "Clicar para ver se é verdade",
        "Encaminhar para família e amigos verem também",
        "NÃO clicar e deletar a mensagem — é golpe!",
      ],
      correctIndex: 2,
      explanation:
        "Links suspeitos por WhatsApp ou SMS são armadilhas! Eles instalam vírus ou roubam seus dados. O governo NUNCA envia benefícios por link de WhatsApp. Na dúvida, acesse o site oficial diretamente.",
    },
    {
      question: "O que fazer se cair em um golpe?",
      options: [
        "Não fazer nada e esperar resolver sozinho",
        "Ligar imediatamente para o banco para bloquear, e registrar BO pelo 190",
        "Tentar recuperar o dinheiro sozinho contactando o golpista",
      ],
      correctIndex: 1,
      explanation:
        "Aja rápido! Ligue para o banco imediatamente para bloquear movimentações, registre Boletim de Ocorrência (BO) pelo 190 ou online, e denuncie ao Procon (151). Quanto mais rápido, maiores as chances de recuperar o dinheiro.",
    },
  ],

  "citizen-4": [
    {
      question: "Quem precisa declarar Imposto de Renda?",
      options: [
        "Somente quem tem empresa",
        "Quem recebeu mais de R$30.639,90 em rendimentos em 2024",
        "Todo mundo que tem celular",
      ],
      correctIndex: 1,
      explanation:
        "Precisa declarar quem recebeu mais de R$30.639,90 em 2024 (somatório de aposentadoria, aluguel, trabalho etc.). Aposentados que recebem apenas o benefício abaixo desse valor geralmente estão isentos.",
    },
    {
      question: "O que acontece se atrasar a entrega do Imposto de Renda?",
      options: [
        "Nada, pode entregar quando quiser",
        "Paga multa — mínimo de R$165,74",
        "Perde o CPF",
      ],
      correctIndex: 1,
      explanation:
        "Entregar o IR fora do prazo gera multa de no mínimo R$165,74 — e pode ser maior dependendo do valor a pagar. Fique atento ao prazo, que geralmente é em maio.",
    },
  ],

  "finance-1": [
    {
      question: "Qual é a idade mínima para aposentadoria por idade no Brasil para mulheres?",
      options: ["55 anos", "62 anos", "65 anos"],
      correctIndex: 1,
      explanation:
        "Após a reforma previdenciária, mulheres se aposentam por idade aos 62 anos e homens aos 65 anos. É necessário também ter contribuído por pelo menos 15 anos (mulheres) ou 20 anos (homens).",
    },
    {
      question: "O BPC/LOAS (benefício da assistência social) é para quem?",
      options: [
        "Apenas para quem contribuiu por 30 anos ao INSS",
        "Para idosos de 65 anos ou mais com renda familiar muito baixa",
        "Somente para pessoas com deficiência",
      ],
      correctIndex: 1,
      explanation:
        "O BPC/LOAS é um salário mínimo pago a idosos com 65+ anos cuja renda familiar por pessoa é menor que 1/4 do salário mínimo. O melhor: não precisa ter contribuído ao INSS!",
    },
    {
      question: "Quando é pago o 13º salário do INSS?",
      options: [
        "Somente em dezembro",
        "Em duas parcelas: geralmente em agosto e novembro",
        "O INSS não paga 13º salário",
      ],
      correctIndex: 1,
      explanation:
        "Quem recebe aposentadoria, pensão ou auxílio do INSS tem direito ao 13º! É pago automaticamente em duas parcelas, geralmente em agosto e novembro. Verifique no extrato do Meu INSS.",
    },
  ],

  "finance-2": [
    {
      question: "Usar o app do banco pelo celular é seguro?",
      options: [
        "Não, é perigoso usar banco no celular",
        "Sim, quando você toma os cuidados certos (senha forte, Wi-Fi confiável)",
        "Somente se usar um celular novo",
      ],
      correctIndex: 1,
      explanation:
        "Sim, usar o app do banco é seguro! Os bancos têm sistemas avançados de proteção. O importante é usar senha forte, não compartilhar sua senha e evitar Wi-Fi público.",
    },
    {
      question: "Em qual rede de internet você DEVE usar o app do banco?",
      options: [
        "Wi-Fi de shopping ou café — é mais rápido",
        "Na internet 4G do seu celular ou no Wi-Fi de casa",
        "Tanto faz, qualquer rede serve",
      ],
      correctIndex: 1,
      explanation:
        "Use sempre o 4G do seu celular ou o Wi-Fi da sua casa para acessar o banco. Redes Wi-Fi públicas (shopping, café, aeroporto) podem ser monitoradas por pessoas mal-intencionadas.",
    },
    {
      question: "O banco pediu por telefone para você instalar um app de 'suporte'. O que fazer?",
      options: [
        "Instalar o app pois o banco está tentando te ajudar",
        "Instalar e fornecer os dados que pedirem",
        "NÃO instalar nada — é golpe! Desligue e ligue para o banco pelo número do cartão",
      ],
      correctIndex: 2,
      explanation:
        "Bancos NUNCA pedem para instalar apps de suporte remoto por telefone. Apps como AnyDesk e TeamViewer são usados por golpistas para acessar seu celular e roubar sua conta. Desligue e ligue para o banco pelo número oficial (no verso do seu cartão).",
    },
  ],

  "finance-3": [
    {
      question: "Qual é a taxa máxima de juros permitida no consignado para aposentados?",
      options: ["5% ao mês", "1,80% ao mês", "0,5% ao mês"],
      correctIndex: 1,
      explanation:
        "A lei limita os juros do consignado para aposentados a 1,80% ao mês — bem abaixo dos outros tipos de empréstimo, que podem chegar a 10% ou mais ao mês.",
    },
    {
      question: "O desconto das parcelas do consignado não pode ultrapassar...",
      options: ["10% do benefício mensal", "35% do benefício mensal", "50% do benefício mensal"],
      correctIndex: 1,
      explanation:
        "Por lei, as parcelas do consignado não podem descontar mais de 35% do seu benefício mensal. Verifique sua 'margem consignável' no app Meu INSS antes de assinar qualquer contrato.",
    },
    {
      question: "Ligaram oferecendo consignado aprovado para você. Como agir?",
      options: [
        "Aceitar imediatamente — é oportunidade rara",
        "Pedir mais informações e depois fechar",
        "Desconfiar! Vá pessoalmente ao banco ou acesse o Meu INSS para fazer com segurança",
      ],
      correctIndex: 2,
      explanation:
        "Golpistas ligam oferecendo consignado e depois descontam parcelas sem autorização real. Nunca contrate consignado por telefone com quem te ligou. Procure seu banco pessoalmente ou use o app Meu INSS.",
    },
  ],

  "hobby-1": [
    {
      question: "Qual planta é mais fácil para quem está começando?",
      options: [
        "Orquídea — é a mais bonita",
        "Suculentas e Espada-de-São-Jorge — precisam de pouquíssimo cuidado",
        "Árvore frutífera — dá frutas rápido",
      ],
      correctIndex: 1,
      explanation:
        "Suculentas e a Espada-de-São-Jorge são perfeitas para iniciantes! Sobrevivem com muito pouca água e não precisam de muita atenção. Ótimas para começar e ganhar confiança!",
    },
    {
      question: "Quando é o MELHOR momento para regar as plantas?",
      options: [
        "Ao meio-dia, com o sol mais forte",
        "Pela manhã cedo",
        "Regar sempre que a terra parecer seca visualmente",
      ],
      correctIndex: 1,
      explanation:
        "O melhor horário é pela manhã cedo! A água é absorvida antes do calor do dia. Regar ao meio-dia pode queimar as folhas com a combinação de água e sol forte.",
    },
    {
      question: "Como saber se a planta precisa de água?",
      options: [
        "Regar todo dia, independentemente do estado da terra",
        "Colocar o dedo na terra — se estiver úmida, não regue ainda",
        "Regar somente quando as folhas estiverem murchas",
      ],
      correctIndex: 1,
      explanation:
        "O teste do dedo é o melhor! Coloque o dedo 2 cm na terra. Se ainda estiver úmida, espere. Se estiver seca, regue. Excesso de água mata mais plantas do que falta!",
    },
  ],

  "hobby-3": [
    {
      question: "Qual é a dica mais importante para tirar uma boa foto?",
      options: [
        "Usar o zoom máximo do celular sempre",
        "Ter boa iluminação — ficar de frente para a luz natural",
        "Só tirar foto no escuro com flash",
      ],
      correctIndex: 1,
      explanation:
        "A iluminação é tudo na fotografia! Posicione-se com a luz (janela ou sol) na frente, iluminando o sujeito da foto. Nunca tire foto contra a luz — a pessoa fica escura.",
    },
    {
      question: "Como fazer zoom na câmera do celular?",
      options: [
        "Apertar o botão de volume",
        "Juntar dois dedos na tela e abrir devagar (como abrindo uma tesoura)",
        "Virar o celular de lado",
      ],
      correctIndex: 1,
      explanation:
        "Para dar zoom: coloque dois dedos juntos na tela e abra-os devagar. Para tirar o zoom, faça o movimento contrário (fechar os dedos). É o movimento de 'pellizcar' a tela!",
    },
  ],

  "hobby-4": [
    {
      question: "No aplicativo Kindle, como você pode facilitar a leitura?",
      options: [
        "Não dá para ajustar nada — só funciona como vem",
        "Tocando em 'Aa' para aumentar a fonte e mudar o fundo para sépia (bege)",
        "Precisa comprar uma versão especial para idosos",
      ],
      correctIndex: 1,
      explanation:
        "No Kindle, toque em 'Aa' e aumente a letra até ficar confortável! O fundo sépia (cor de papel) cansa menos a vista do que o branco. Você também pode aumentar o contraste.",
    },
    {
      question: "Os áudio livros são úteis para quê?",
      options: [
        "Somente para pessoas cegas",
        "Para ouvir enquanto caminha, faz exercício ou trabalhos manuais",
        "Substituem completamente a leitura de livros",
      ],
      correctIndex: 1,
      explanation:
        "Áudio livros são ótimos para aproveitar qualquer momento! Você pode ouvir histórias e aprender enquanto caminha, faz crochê, cozinha ou descansa. Uma ótima forma de se manter ativo mentalmente.",
    },
  ],

  "lang-1": [
    {
      question: "Como se diz 'Bom dia' em inglês?",
      options: ["Good night", "Good morning", "Good afternoon"],
      correctIndex: 1,
      explanation:
        "'Good morning' significa Bom dia. Para tarde é 'Good afternoon' e para a noite é 'Good evening' (boa noite ao chegar) ou 'Good night' (boa noite ao se despedir para dormir).",
    },
    {
      question: "Como se diz 'Obrigado(a)' em inglês?",
      options: ["Please", "Sorry", "Thank you"],
      correctIndex: 2,
      explanation:
        "'Thank you' significa obrigado(a) — pronuncia-se 'Thênk iú'. A resposta é 'You're welcome' (De nada) — pronuncia-se 'Iôr uélcom'.",
    },
    {
      question: "Como apresentar seu nome em inglês?",
      options: [
        "I called [nome]",
        "My name is [nome]",
        "Name [nome] I am",
      ],
      correctIndex: 1,
      explanation:
        "'My name is [seu nome]' — pronuncia-se 'Mái néim iz [nome]'. Você também pode dizer 'I am [nome]' (pronuncia-se 'Ái æm [nome]'), que também significa 'Eu sou [nome]'.",
    },
  ],

  "lang-2": [
    {
      question: "Como se diz 'Tenho dor na cabeça' em inglês?",
      options: [
        "I have pain in my head",
        "My head is bad",
        "Head problem I have",
      ],
      correctIndex: 0,
      explanation:
        "'I have pain in my [parte do corpo]' é como você diz que tem dor em algum lugar. Para cabeça: 'I have pain in my head'. Para as costas: 'I have pain in my back'.",
    },
    {
      question: "O que significa 'Take 2 times a day' numa embalagem de remédio?",
      options: [
        "Tome somente 2 dias",
        "Tome 2 comprimidos de uma vez",
        "Tome 2 vezes por dia",
      ],
      correctIndex: 2,
      explanation:
        "'Take 2 times a day' significa tomar 2 vezes por dia. Outras instruções comuns: 'Take with food' = Tome com alimento; 'Before bed' = Antes de dormir; 'As needed' = Se necessário.",
    },
  ],

  "lang-3": [
    {
      question: "Como se diz 'Quanto custa?' em espanhol?",
      options: ["¿Cómo estás?", "¿Cuánto cuesta?", "¿Dónde está?"],
      correctIndex: 1,
      explanation:
        "'¿Cuánto cuesta?' significa 'Quanto custa?' — você vai usar muito isso em viagens a países de fala espanhola! Para pedir a conta no restaurante: '¡La cuenta, por favor!'",
    },
    {
      question: "Como se diz 'Obrigado(a)' em espanhol?",
      options: ["Por favor", "De nada", "Gracias"],
      correctIndex: 2,
      explanation:
        "'Gracias' é obrigado em espanhol — pronuncia-se 'Grásias'. A resposta é 'De nada' — igual ao português! O espanhol tem muitas palavras parecidas com o português.",
    },
  ],
};
