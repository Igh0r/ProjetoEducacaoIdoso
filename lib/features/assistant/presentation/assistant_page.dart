import 'package:flutter/material.dart';
import 'package:educacao_idoso/app/theme/app_colors.dart';
import 'package:educacao_idoso/core/state/app_state.dart';
import 'package:educacao_idoso/features/assistant/models/chat_message.dart';
import 'package:educacao_idoso/features/assistant/services/assistant_answer_service.dart';
import 'package:educacao_idoso/shared/widgets/shared_widgets.dart';

class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final controller = TextEditingController();
  final messages = <ChatMessage>[
    const ChatMessage(false, 'Olá! 😊 Sou seu Assistente Digital. Posso ajudar com WhatsApp, gov.br, INSS, PIX, remédios, SUS, segurança e emergências.'),
  ];
  var isAnswering = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> send([String? preset]) async {
    final text = (preset ?? controller.text).trim();
    if (text.isEmpty || isAnswering) return;

    setState(() {
      messages.add(ChatMessage(true, text));
      isAnswering = true;
      controller.clear();
    });

    final answer = await assistantAnswerService.answerForIntegrated(
      text,
      profile: appState.userProfile,
    );

    if (!mounted) return;
    setState(() {
      messages.add(ChatMessage(false, answer));
      isAnswering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: '🤖 Assistente Digital',
      subtitle: 'Pergunte sobre os temas abaixo.',
      child: Column(children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            itemBuilder: (context, index) => ChatBubble(message: messages[index]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Assuntos disponíveis: WhatsApp, gov.br, INSS, PIX, remédios, SUS, segurança e emergências.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Como evitar golpes?', 'Como usar PIX?', 'Esqueci a senha gov.br'].map((s) => ActionChip(label: Text(s), onPressed: () => send(s))).toList(),
            ),
          ]),
        ),
        if (isAnswering)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [
              SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              SizedBox(width: 12),
              Text('Pensando em uma resposta segura...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ]),
          ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 3,
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
            FilledButton.icon(onPressed: isAnswering ? null : send, style: FilledButton.styleFrom(padding: const EdgeInsets.all(18)), icon: const Icon(Icons.send, size: 30), label: const Text('Enviar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900))),
          ]),
        ),
      ]),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.message, super.key});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.user ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 620),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: message.user ? Colors.blue.shade700 : appPanelColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(message.text, style: const TextStyle(fontSize: 20, height: 1.35)),
      ),
    );
  }
}

