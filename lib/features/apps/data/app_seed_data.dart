part of 'package:educacao_idoso/main.dart';

final appGroups = <AppGroup>[
  AppGroup('📞 Comunicação', [
    AppItem('WhatsApp', '💬', Colors.green, 'Abrindo WhatsApp...', actionType: AppActionType.appScheme, scheme: 'whatsapp://send', fallbackMessage: 'Se o WhatsApp não abrir, procure o ícone verde com telefone nos seus aplicativos.'),
    AppItem('Ligar', '📞', Colors.green, 'Abrindo chamadas...', actionType: AppActionType.appScheme, scheme: 'tel:', fallbackMessage: 'Abra o aplicativo Telefone e toque em Teclado para fazer uma ligação.'),
    AppItem('Mensagens', '✉️', Colors.blue, 'Abrindo SMS...', actionType: AppActionType.appScheme, scheme: 'sms:', fallbackMessage: 'Abra o aplicativo Mensagens para ler ou enviar SMS.'),
    AppItem('Vídeo', '📹', Colors.purple, 'Abrindo videochamada...', actionType: AppActionType.openUrl, url: 'https://meet.google.com/', fallbackMessage: 'Se a videochamada não abrir, peça o link ao familiar e toque nele novamente.'),
    AppItem('E-mail', '📧', Colors.indigo, 'Abrindo e-mail...', actionType: AppActionType.appScheme, scheme: 'mailto:', fallbackMessage: 'Abra o aplicativo de e-mail instalado no celular, como Gmail ou Mail.'),
  ]),
  AppGroup('🎬 Entretenimento', [
    AppItem('YouTube', '▶️', Colors.red, 'Abrindo YouTube...', actionType: AppActionType.openUrl, url: 'https://www.youtube.com/', fallbackMessage: 'Se o YouTube não abrir, procure pelo ícone vermelho ou acesse youtube.com no navegador.'),
    AppItem('Música', '🎵', Colors.deepOrange, 'Abrindo música...', actionType: AppActionType.openUrl, url: 'https://music.youtube.com/', fallbackMessage: 'Abra seu aplicativo de música preferido e procure a música pelo nome.'),
    AppItem('Fotos', '🖼️', Colors.purple, 'Abrindo fotos...', actionType: AppActionType.appScheme, scheme: 'content://media/external/images/media', fallbackMessage: 'Procure o aplicativo Galeria ou Fotos para ver suas imagens.'),
    AppItem('Câmera', '📷', Colors.blueGrey, 'Abrindo câmera...', actionType: AppActionType.appScheme, scheme: 'camera:', fallbackMessage: 'Procure o ícone de câmera nos aplicativos do celular.'),
  ]),
  AppGroup('🏦 Serviços', [
    AppItem('Banco', '🏦', Colors.teal, 'Abra apenas o aplicativo oficial do seu banco.', fallbackMessage: 'Nunca informe senhas fora do aplicativo oficial do seu banco.'),
    AppItem('PIX', '⚡', Colors.cyan, 'Confira os dados antes de confirmar o PIX.', fallbackMessage: 'Para PIX, abra somente o aplicativo oficial do banco e confira nome, valor e chave.'),
    AppItem('Gov.br', '🏛️', Colors.amber, 'Abrindo gov.br...', actionType: AppActionType.openUrl, url: 'https://www.gov.br/pt-br', fallbackMessage: 'Digite gov.br no navegador e confirme se o endereço começa com https://www.gov.br.'),
    AppItem('Meu INSS', '📋', Colors.blue, 'Abrindo Meu INSS...', actionType: AppActionType.openUrl, url: 'https://meu.inss.gov.br/', fallbackMessage: 'Digite meu.inss.gov.br no navegador ou procure o aplicativo Meu INSS oficial.'),
  ]),
  AppGroup('🚨 Emergência', [
    AppItem('SAMU 192', '🚑', Colors.red, 'Ligando para 192 (SAMU)...', actionType: AppActionType.phoneCall, phoneNumber: '192', isEmergency: true, fallbackMessage: 'Não foi possível iniciar a ligação. Disque 192 no telefone para chamar o SAMU.'),
    AppItem('Bombeiros', '🚒', Colors.deepOrange, 'Ligando para 193 (Bombeiros)...', actionType: AppActionType.phoneCall, phoneNumber: '193', isEmergency: true, fallbackMessage: 'Não foi possível iniciar a ligação. Disque 193 no telefone para chamar os Bombeiros.'),
    AppItem('Polícia 190', '🚔', Colors.blue, 'Ligando para 190 (Polícia)...', actionType: AppActionType.phoneCall, phoneNumber: '190', isEmergency: true, fallbackMessage: 'Não foi possível iniciar a ligação. Disque 190 no telefone para chamar a Polícia.'),
    AppItem('CVV 188', '💙', Colors.indigo, 'Ligando para 188 (CVV)...', actionType: AppActionType.phoneCall, phoneNumber: '188', isEmergency: true, fallbackMessage: 'Não foi possível iniciar a ligação. Disque 188 no telefone para falar com o CVV.'),
  ]),
];
