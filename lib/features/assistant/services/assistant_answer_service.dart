class AssistantAnswerService {
  const AssistantAnswerService();

  String answerFor(String question, {UserProfile profile = const UserProfile()}) {
    final q = question.toLowerCase();
    final trusted = profile.trustedContactLabel;
    if (q.contains('golpe') || q.contains('segurança')) {
      return 'Nunca informe senha, código SMS ou número do cartão por mensagem. Desconfie de urgência, links estranhos e pedidos de dinheiro. Na dúvida, pare e confirme com $trusted ou com o banco por um número oficial.';
    }
    if (q.contains('pix')) {
      return 'Para usar PIX com segurança: confira nome e banco antes de confirmar, comece com valores pequenos e nunca faça transferência por pressão de desconhecidos. Se houver urgência ou ameaça, confirme antes com $trusted.';
    }
    if (q.contains('gov')) {
      return 'No gov.br, use o aplicativo ou site oficial. Toque em “Esqueci minha senha” e siga as etapas. Peça ajuda a alguém de confiança, mas não compartilhe sua senha.';
    }
    if (q.contains('remédio') || q.contains('remedio')) {
      return 'Use alarmes no celular, mantenha uma lista dos remédios e confirme horários com médico ou farmacêutico. Não altere doses sem orientação profissional.';
    }
    return 'Boa pergunta! Vá por partes: leia a tela, procure botões como “Entrar”, “Confirmar” ou “Voltar” e, se envolver dinheiro, senha ou dados sensíveis, confirme com $trusted antes de continuar.';
  }
}

const assistantAnswerService = AssistantAnswerService();

String answerFor(String question) => assistantAnswerService.answerFor(question, profile: appState.userProfile);
