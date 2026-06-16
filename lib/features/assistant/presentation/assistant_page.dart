part of 'package:educacao_idoso/main.dart';

class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final controller = TextEditingController();
  final messages = <ChatMessage>[
    const ChatMessage(false, 'Olá! 😊 Sou seu Assistente Digital. Pergunte sobre WhatsApp, gov.br, INSS, PIX, remédios, SUS ou segurança.'),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void send([String? preset]) {
    final text = (preset ?? controller.text).trim();
    if (text.isEmpty) return;
    setState(() {
      messages.add(ChatMessage(true, text));
      messages.add(ChatMessage(false, answerFor(text)));
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: '🤖 Assistente Digital',
      subtitle: 'Pergunte qualquer coisa.',
      child: Column(children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            itemBuilder: (context, index) => ChatBubble(message: messages[index]),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Como evitar golpes?', 'Como usar PIX?', 'Esqueci a senha gov.br'].map((s) => ActionChip(label: Text(s), onPressed: () => send(s))).toList(),
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
                  fillColor: _panel,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onSubmitted: (_) => send(),
              ),
            ),
            const SizedBox(width: 10),
            FilledButton(onPressed: send, style: FilledButton.styleFrom(padding: const EdgeInsets.all(18)), child: const Icon(Icons.send, size: 30)),
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
          color: message.user ? Colors.blue.shade700 : _panel,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(message.text, style: const TextStyle(fontSize: 20, height: 1.35)),
      ),
    );
  }
}

