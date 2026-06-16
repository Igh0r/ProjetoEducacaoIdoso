part of 'package:educacao_idoso/main.dart';

final appGroups = <AppGroup>[
  AppGroup('📞 Comunicação', [
    AppItem('WhatsApp', '💬', Colors.green, 'Abrindo WhatsApp...'),
    AppItem('Ligar', '📞', Colors.green, 'Abrindo chamadas...'),
    AppItem('Mensagens', '✉️', Colors.blue, 'Abrindo SMS...'),
    AppItem('Vídeo', '📹', Colors.purple, 'Abrindo videochamada...'),
    AppItem('E-mail', '📧', Colors.indigo, 'Abrindo e-mail...'),
  ]),
  AppGroup('🎬 Entretenimento', [
    AppItem('YouTube', '▶️', Colors.red, 'Abrindo YouTube...'),
    AppItem('Música', '🎵', Colors.deepOrange, 'Abrindo música...'),
    AppItem('Fotos', '🖼️', Colors.purple, 'Abrindo fotos...'),
    AppItem('Câmera', '📷', Colors.blueGrey, 'Abrindo câmera...'),
  ]),
  AppGroup('🏦 Serviços', [
    AppItem('Banco', '🏦', Colors.teal, 'Abra apenas o aplicativo oficial do seu banco.'),
    AppItem('PIX', '⚡', Colors.cyan, 'Confira os dados antes de confirmar o PIX.'),
    AppItem('Gov.br', '🏛️', Colors.amber, 'Use apenas canais oficiais do gov.br.'),
    AppItem('Meu INSS', '📋', Colors.blue, 'Abrindo orientação do Meu INSS.'),
  ]),
  AppGroup('🚨 Emergência', [
    AppItem('SAMU 192', '🚑', Colors.red, 'Ligue agora: 192 (SAMU).'),
    AppItem('Bombeiros', '🚒', Colors.deepOrange, 'Ligue agora: 193 (Bombeiros).'),
    AppItem('Polícia 190', '🚔', Colors.blue, 'Ligue agora: 190 (Polícia).'),
    AppItem('CVV 188', '💙', Colors.indigo, 'Ligue agora: 188 (CVV).'),
  ]),
];
