import 'package:flutter/material.dart';
import 'package:educacao_idoso/app/theme/app_colors.dart';
import 'package:educacao_idoso/core/state/app_state.dart';
import 'package:educacao_idoso/features/assistant/models/chat_message.dart';
import 'package:educacao_idoso/features/assistant/services/assistant_conversation_controller.dart';
import 'package:educacao_idoso/shared/widgets/shared_widgets.dart';

class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key, this.conversationController});

  final AssistantConversationController? conversationController;

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final controller = TextEditingController();
  late final AssistantConversationController conversationController;
  final messages = <ChatMessage>[
    ChatMessage(role: ChatRole.assistant, text: 'Olá! 😊 Sou seu Assistente Digital com IA online. Posso ajudar com dúvidas sobre celular, gov.br, INSS, PIX, remédios, SUS e segurança. Não digite senhas, códigos, documentos ou dados bancários.'),
  ];
  bool isSending = false;
  String? lastQuestion;

  @override
  void initState() {
    super.initState();
    conversationController = widget.conversationController ?? AssistantConversationController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> send([String? preset]) async {
    final text = (preset ?? controller.text).trim();
    if (text.isEmpty || isSending) return;

    if (!appState.userProfile.acceptedRemoteAssistantTerms) {
      final accepted = await _askRemoteAssistantConsent();
      if (!accepted) return;
    }

    setState(() {
      isSending = true;
      lastQuestion = text;
      messages
        ..add(ChatMessage(role: ChatRole.user, text: text))
        ..add(ChatMessage(role: ChatRole.assistant, text: 'Estou pensando...', status: ChatMessageStatus.sending));
      controller.clear();
    });

    final answer = await conversationController.answer(text, messages.where((message) => message.status != ChatMessageStatus.sending).toList());
    if (!mounted) return;

    setState(() {
      messages.removeWhere((message) => message.status == ChatMessageStatus.sending);
      messages.add(answer);
      isSending = false;
    });
  }

  Future<void> retryLastQuestion() async {
    final question = lastQuestion;
    if (question == null || question.isEmpty) return;
    await send(question);
  }

  Future<bool> _askRemoteAssistantConsent() async {
    final accepted = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Usar IA online?'),
        content: const Text('Para responder, este assistente envia sua pergunta para um serviço online de IA. Não digite senhas, códigos, documentos, cartão ou dados bancários.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Agora não')),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Entendi e aceito')),
        ],
      ),
    );

    if (accepted == true) {
      await appState.saveUserProfile(appState.userProfile.copyWith(acceptedRemoteAssistantTerms: true, acceptedRemoteAssistantTermsAt: DateTime.now()));
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: '🤖 Assistente Digital',
      subtitle: 'Consulta online com IA. Precisa de internet.',
      child: Column(children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            itemBuilder: (context, index) => ChatBubble(message: messages[index], onRetry: messages[index].canRetry ? retryLastQuestion : null),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Como evitar golpes?', 'Como usar PIX?', 'Esqueci a senha gov.br'].map((s) => ActionChip(label: Text(s), onPressed: isSending ? null : () => send(s))).toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 3,
                enabled: !isSending,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  hintText: 'Digite sua dúvida...',
                  filled: true,
                  fillColor: appPanelColor,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onSubmitted: (_) => send(),
              ),
            ),
            const SizedBox(width: 10),
            FilledButton(onPressed: isSending ? null : send, style: FilledButton.styleFrom(padding: const EdgeInsets.all(18)), child: isSending ? const SizedBox(width: 30, height: 30, child: CircularProgressIndicator(strokeWidth: 3)) : const Icon(Icons.send, size: 30)),
          ]),
        ),
      ]),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.message, this.onRetry, super.key});
  final ChatMessage message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final isFailed = message.status == ChatMessageStatus.failed;
    return Align(
      alignment: message.user ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 620),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: message.user ? Colors.blue.shade700 : isFailed ? Colors.red.shade900 : appPanelColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(message.text, style: const TextStyle(fontSize: 20, height: 1.35)),
          if (message.status == ChatMessageStatus.sending) const Padding(padding: EdgeInsets.only(top: 10), child: LinearProgressIndicator()),
          if (onRetry != null) Padding(padding: const EdgeInsets.only(top: 10), child: TextButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh), label: const Text('Tentar novamente'))),
        ]),
      ),
    );
  }
}
