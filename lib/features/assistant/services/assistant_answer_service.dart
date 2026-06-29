import 'package:educacao_idoso/core/state/app_state.dart';
import 'package:educacao_idoso/features/profile/models/user_profile.dart';

/// Contrato usado para integrar o assistente a um provedor GPT.
///
/// A implementação concreta pode chamar uma API externa, mas os testes usam um
/// cliente falso para validar o fluxo sem depender de internet, chave de API ou
/// custo de uso.
abstract class GptAssistantClient {
  Future<String?> answer(String question, {UserProfile? profile});
}

class AssistantAnswerService {
  const AssistantAnswerService({GptAssistantClient? gptClient})
      : _gptClient = gptClient;

  final GptAssistantClient? _gptClient;

  /// Responde usando a base local determinística.
  ///
  /// Este método permanece síncrono para manter o comportamento offline já
  /// testado e usado pela interface atual.
  String answerFor(String question, {UserProfile? profile}) {
    final normalizedQuestion = _normalize(question);

    for (final intent in _assistantIntents) {
      if (intent.matches(normalizedQuestion)) {
        return intent.answer;
      }
    }

    return _fallbackAnswer;
  }

  /// Responde priorizando a integração GPT configurada.
  ///
  /// Caso não exista cliente GPT, a resposta venha vazia ou ocorra erro na
  /// integração, o assistente volta para a resposta local. Assim a experiência
  /// continua funcional para idosos mesmo sem internet ou serviço externo.
  Future<String> answerForIntegrated(
    String question, {
    UserProfile? profile,
  }) async {
    final gptClient = _gptClient;
    if (gptClient == null) {
      return answerFor(question, profile: profile);
    }

    try {
      final gptAnswer = await gptClient.answer(question, profile: profile);
      final sanitizedAnswer = gptAnswer?.trim();
      if (sanitizedAnswer != null && sanitizedAnswer.isNotEmpty) {
        return sanitizedAnswer;
      }
    } catch (_) {
      // Mantém o assistente seguro e disponível com a base local.
    }

    return answerFor(question, profile: profile);
  }

  String _normalize(String value) {
    const accents = {
      'á': 'a',
      'à': 'a',
      'â': 'a',
      'ã': 'a',
      'é': 'e',
      'ê': 'e',
      'í': 'i',
      'ó': 'o',
      'ô': 'o',
      'õ': 'o',
      'ú': 'u',
      'ü': 'u',
      'ç': 'c',
    };

    final lowerCaseValue = value.toLowerCase();
    final withoutAccents = lowerCaseValue.split('').map((character) {
      return accents[character] ?? character;
    }).join();

    return withoutAccents.replaceAll(RegExp(r'[^a-z0-9]+'), ' ');
  }
}

class _AssistantIntent {
  const _AssistantIntent({
    required this.keywords,
    required this.answer,
  });

  final List<String> keywords;
  final String answer;

  bool matches(String normalizedQuestion) {
    return keywords.any((keyword) => normalizedQuestion.contains(keyword));
  }
}

const _fallbackAnswer =
    'Boa pergunta! Vá por partes: leia a tela, procure botões como “Entrar”, “Confirmar” ou “Voltar” e, se envolver dinheiro, documento, saúde ou senha, confirme com alguém de confiança antes de continuar.';

const _assistantIntents = <_AssistantIntent>[
  _AssistantIntent(
    keywords: ['whatsapp', 'zap', 'zapi', 'mensagem', 'audio', 'figurinhas'],
    answer:
        'No WhatsApp, abra a conversa, confira se é o contato correto e use áudio, texto ou chamada. Não toque em links estranhos nem envie códigos recebidos por SMS. Em pedidos de dinheiro ou documentos, confirme por ligação com uma pessoa de confiança.',
  ),
  _AssistantIntent(
    keywords: ['inss', 'aposentadoria', 'beneficio', 'meu inss'],
    answer:
        'Para assuntos do INSS, use o aplicativo Meu INSS, o site gov.br/meuinss ou ligue 135. Tenha CPF e documentos por perto, mas não envie fotos ou senhas para desconhecidos. Se precisar, peça ajuda a um familiar de confiança ou ao atendimento oficial.',
  ),
  _AssistantIntent(
    keywords: [
      'sus',
      'posto de saude',
      'ubs',
      'consulta',
      'vacina',
      'cartao sus',
    ],
    answer:
        'Para serviços do SUS, procure a UBS/posto de saúde do seu bairro, o aplicativo Conecte SUS ou canais oficiais da prefeitura. Leve documento, cartão SUS e lista de remédios. Não altere tratamentos sem orientação de médico, enfermeiro ou farmacêutico.',
  ),
  _AssistantIntent(
    keywords: [
      'banco',
      'agencia',
      'cartao',
      'conta',
      'boleto',
      'transferencia',
    ],
    answer:
        'Em assuntos de banco, use apenas o aplicativo oficial, caixa eletrônico da agência ou telefone escrito no cartão. Nunca informe senha, código SMS ou número completo do cartão por mensagem. Na dúvida, pare e confirme com o banco ou alguém de confiança.',
  ),
  _AssistantIntent(
    keywords: ['internet', 'wifi', 'wi fi', 'dados moveis', 'navegar', 'site'],
    answer:
        'Para usar a internet, confirme se o Wi-Fi ou os dados móveis estão ligados e prefira sites conhecidos. Evite links recebidos de desconhecidos e não preencha senha, dinheiro ou documentos se o endereço parecer estranho. Peça ajuda antes de continuar.',
  ),
  _AssistantIntent(
    keywords: ['senha', 'senhas', 'codigo', 'codigos', 'pin', 'esqueci'],
    answer:
        'Crie senhas difíceis de adivinhar e não compartilhe com ninguém. Se esquecer uma senha, use “Esqueci minha senha” no aplicativo ou site oficial. Nunca passe código SMS, PIN ou senha por telefone ou WhatsApp, mesmo que a pessoa diga ser do banco.',
  ),
  _AssistantIntent(
    keywords: [
      'compras online',
      'comprar online',
      'loja virtual',
      'mercado livre',
      'pedido',
      'entrega',
    ],
    answer:
        'Em compras online, prefira lojas conhecidas, confira avaliações, preço final, prazo de entrega e política de troca. Não compre por links suspeitos nem pague por pressão. Para valores altos, converse antes com alguém de confiança.',
  ),
  _AssistantIntent(
    keywords: ['transporte', 'onibus', 'metro', 'uber', '99', 'taxi'],
    answer:
        'Para transporte, confira destino, horário e placa ou número do veículo antes de entrar. Em aplicativos, espere em local seguro e veja se motorista e carro são os mesmos da tela. Se tiver dúvida, peça ajuda a alguém de confiança.',
  ),
  _AssistantIntent(
    keywords: ['localizacao', 'mapa', 'maps', 'endereco', 'gps'],
    answer:
        'Para localização, abra o mapa, digite o endereço completo e confira se o ponto está correto antes de iniciar a rota. Compartilhe sua localização apenas com pessoas de confiança e evite divulgar endereço ou rotina para desconhecidos.',
  ),
  _AssistantIntent(
    keywords: ['emergencia', 'socorro', 'samu', 'policia', 'bombeiro'],
    answer:
        'Em emergência, ligue para canais oficiais: SAMU 192, Polícia 190 ou Bombeiros 193. Fale devagar, diga seu nome, endereço e o que aconteceu. Se puder, chame um vizinho, familiar ou pessoa de confiança para ficar com você.',
  ),
  _AssistantIntent(
    keywords: ['golpe', 'seguranca', 'fraude'],
    answer:
        'Nunca informe senha, código SMS ou número do cartão por mensagem. Desconfie de urgência, links estranhos e pedidos de dinheiro. Na dúvida, ligue para um familiar ou para o banco por um número oficial.',
  ),
  _AssistantIntent(
    keywords: ['pix'],
    answer:
        'Para usar PIX com segurança: confira nome e banco antes de confirmar, comece com valores pequenos e nunca faça transferência por pressão de desconhecidos. Se tiver dúvida, confirme com o banco ou com alguém de confiança.',
  ),
  _AssistantIntent(
    keywords: ['gov', 'gov br'],
    answer:
        'No gov.br, use o aplicativo ou site oficial. Toque em “Esqueci minha senha” e siga as etapas. Peça ajuda a alguém de confiança, mas não compartilhe sua senha.',
  ),
  _AssistantIntent(
    keywords: ['remedio', 'medicamento'],
    answer:
        'Use alarmes no celular, mantenha uma lista dos remédios e confirme horários com médico ou farmacêutico. Não altere doses sem orientação profissional.',
  ),
];

const assistantAnswerService = AssistantAnswerService();

String answerFor(String question) => assistantAnswerService.answerFor(question, profile: appState.userProfile);
