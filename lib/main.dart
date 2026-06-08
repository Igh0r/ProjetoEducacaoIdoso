import 'package:flutter/material.dart';

void main() => runApp(const EducacaoIdosoApp());

const _bg = Color(0xFF111827);
const _panel = Color(0xFF1F2937);
const _line = Color(0xFFFACC15);
const _muted = Color(0xFFD1D5DB);

class EducacaoIdosoApp extends StatelessWidget {
  const EducacaoIdosoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Educação para Idosos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _line,
          brightness: Brightness.dark,
          primary: _line,
          surface: _panel,
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          bodyLarge: TextStyle(fontSize: 20, height: 1.35),
          bodyMedium: TextStyle(fontSize: 18, height: 1.35),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class AppState extends ChangeNotifier {
  final Set<String> completedLessons = <String>{};
  final Map<String, int> quizScores = <String, int>{};
  double textScale = 1;
  bool highContrast = true;

  int get totalLessons => categories.fold(0, (sum, c) => sum + c.lessons.length);
  int get totalMinutes => completedLessons.fold(0, (sum, id) {
        final lesson = lessonById(id);
        return sum + (lesson?.minutes ?? 0);
      });

  void completeLesson(String id, int score) {
    completedLessons.add(id);
    quizScores[id] = score;
    notifyListeners();
  }

  void toggleContrast() {
    highContrast = !highContrast;
    notifyListeners();
  }

  void setTextScale(double value) {
    textScale = value;
    notifyListeners();
  }
}

final appState = AppState();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🌟', style: TextStyle(fontSize: 84)),
                const SizedBox(height: 12),
                Text('Bem-vindo!', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 12),
                const Text(
                  'Aprenda tecnologia, saúde, cidadania e finanças no seu ritmo, com letras grandes e passos simples.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: _muted, height: 1.35),
                ),
                const SizedBox(height: 28),
                SeniorButton(
                  label: 'Entrar no aplicativo',
                  icon: Icons.login,
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const MainNavigation()),
                  ),
                ),
                const SizedBox(height: 16),
                const InfoCard(
                  icon: '🔒',
                  title: 'Seguro e acolhedor',
                  text: 'Este protótipo usa login simplificado para facilitar testes e demonstrações.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int index = 0;

  final pages = const [
    HomePage(),
    AppLauncherPage(),
    AssistantPage(),
    ProgressPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(appState.textScale),
        ),
        child: Scaffold(
          body: pages[index],
          bottomNavigationBar: NavigationBar(
            selectedIndex: index,
            backgroundColor: _panel,
            indicatorColor: _line,
            labelTextStyle: WidgetStateProperty.all(const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
            onDestinationSelected: (value) => setState(() => index = value),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.school), label: 'Aprender'),
              NavigationDestination(icon: Icon(Icons.apps), label: 'Apps'),
              NavigationDestination(icon: Icon(Icons.smart_toy), label: 'Ajuda'),
              NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Progresso'),
              NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'O que vamos aprender hoje?',
      subtitle: 'Escolha um tema. Cada aula tem passos curtos, dicas e quiz.',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AnimatedBuilder(
            animation: appState,
            builder: (context, _) => ProgressBanner(
              completed: appState.completedLessons.length,
              total: appState.totalLessons,
            ),
          ),
          const SizedBox(height: 20),
          ...categories.map((category) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CategoryCard(category: category),
              )),
          const SizedBox(height: 20),
          const EmergencyCard(),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({required this.category, super.key});
  final LessonCategory category;

  @override
  Widget build(BuildContext context) {
    final done = category.lessons.where((l) => appState.completedLessons.contains(l.id)).length;
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CategoryPage(category: category))),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _panel,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: category.color, width: 3),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: category.color,
              child: Text(category.emoji, style: const TextStyle(fontSize: 34)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(category.name, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 6),
                Text(category.description, style: const TextStyle(fontSize: 18, color: _muted)),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: category.lessons.isEmpty ? 0 : done / category.lessons.length,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(99),
                  backgroundColor: Colors.white12,
                ),
                const SizedBox(height: 6),
                Text('$done de ${category.lessons.length} aulas concluídas', style: const TextStyle(fontWeight: FontWeight.bold)),
              ]),
            ),
            const Icon(Icons.chevron_right, size: 34),
          ],
        ),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({required this.category, super.key});
  final LessonCategory category;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: '${category.emoji} ${category.name}',
      subtitle: category.description,
      showBack: true,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: category.lessons.length,
        itemBuilder: (context, index) {
          final lesson = category.lessons[index];
          final completed = appState.completedLessons.contains(lesson.id);
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: LessonTile(lesson: lesson, completed: completed),
          );
        },
      ),
    );
  }
}

class LessonTile extends StatelessWidget {
  const LessonTile({required this.lesson, required this.completed, super.key});
  final Lesson lesson;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LessonPage(lesson: lesson))),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(24)),
        child: Row(children: [
          Text(completed ? '✅' : lesson.emoji, style: const TextStyle(fontSize: 42)),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(lesson.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(lesson.description, style: const TextStyle(fontSize: 17, color: _muted)),
            const SizedBox(height: 10),
            Wrap(spacing: 10, runSpacing: 8, children: [
              Chip(label: Text('⏱ ${lesson.duration}')),
              Chip(label: Text('⭐ ${lesson.difficulty}')),
            ]),
          ])),
          const Icon(Icons.play_circle_fill, color: _line, size: 38),
        ]),
      ),
    );
  }
}

class LessonPage extends StatefulWidget {
  const LessonPage({required this.lesson, super.key});
  final Lesson lesson;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  int step = 0;
  int quiz = 0;
  int score = 0;
  int? selected;
  LessonPhase phase = LessonPhase.steps;

  @override
  Widget build(BuildContext context) {
    switch (phase) {
      case LessonPhase.steps:
        return _stepView(context);
      case LessonPhase.quizIntro:
        return _quizIntro(context);
      case LessonPhase.quiz:
        return _quizView(context);
      case LessonPhase.done:
        return _doneView(context);
    }
  }

  Widget _stepView(BuildContext context) {
    final item = widget.lesson.steps[step];
    final progress = (step + 1) / widget.lesson.steps.length;
    return AppShell(
      title: widget.lesson.title,
      subtitle: 'Passo ${step + 1} de ${widget.lesson.steps.length}',
      showBack: true,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(children: [
          LinearProgressIndicator(value: progress, minHeight: 12, borderRadius: BorderRadius.circular(99)),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(32)),
                child: Column(children: [
                  Text(item.emoji, style: const TextStyle(fontSize: 88)),
                  const SizedBox(height: 16),
                  Text(item.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 18),
                  Text(item.content, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
                  if (item.tip != null) ...[
                    const SizedBox(height: 20),
                    InfoCard(icon: '💡', title: 'Dica', text: item.tip!),
                  ],
                  if (item.warning != null) ...[
                    const SizedBox(height: 20),
                    WarningCard(text: item.warning!),
                  ],
                ]),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(children: [
            if (step > 0)
              Expanded(
                child: SeniorButton.secondary(
                  label: 'Voltar',
                  icon: Icons.arrow_back,
                  onPressed: () => setState(() => step--),
                ),
              ),
            if (step > 0) const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: SeniorButton(
                label: step == widget.lesson.steps.length - 1 ? 'Fazer quiz' : 'Próximo',
                icon: Icons.arrow_forward,
                onPressed: () => setState(() {
                  if (step == widget.lesson.steps.length - 1) {
                    phase = LessonPhase.quizIntro;
                  } else {
                    step++;
                  }
                }),
              ),
            ),
          ]),
        ]),
      ),
    );
  }

  Widget _quizIntro(BuildContext context) {
    return AppShell(
      title: '🧠 Hora do quiz!',
      showBack: true,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('Você completou os passos. Agora responda perguntas simples para fixar o aprendizado.', textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
            const SizedBox(height: 24),
            const InfoCard(icon: '✅', title: 'Como funciona', text: 'Toque em uma resposta. Você verá uma explicação após escolher.'),
            const SizedBox(height: 24),
            SeniorButton(label: 'Começar quiz', icon: Icons.psychology, onPressed: () => setState(() => phase = LessonPhase.quiz)),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                appState.completeLesson(widget.lesson.id, 0);
                setState(() => phase = LessonPhase.done);
              },
              child: const Text('Pular quiz e concluir', style: TextStyle(fontSize: 20)),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _quizView(BuildContext context) {
    final q = widget.lesson.quiz[quiz];
    final answered = selected != null;
    return AppShell(
      title: 'Quiz ${quiz + 1}/${widget.lesson.quiz.length}',
      subtitle: widget.lesson.title,
      showBack: true,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(children: [
          LinearProgressIndicator(value: (quiz + 1) / widget.lesson.quiz.length, minHeight: 12, borderRadius: BorderRadius.circular(99)),
          const SizedBox(height: 18),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(28)),
                  child: Text(q.question, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge),
                ),
                const SizedBox(height: 16),
                ...List.generate(q.options.length, (i) {
                  final isCorrect = i == q.correct;
                  final isSelected = i == selected;
                  Color color = _panel;
                  if (answered && isCorrect) color = Colors.green.shade700;
                  if (answered && isSelected && !isCorrect) color = Colors.red.shade700;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: color,
                          padding: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                        ),
                        onPressed: answered
                            ? null
                            : () => setState(() {
                                  selected = i;
                                  if (isCorrect) score++;
                                }),
                        child: Text(q.options[i], textAlign: TextAlign.center, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  );
                }),
                if (answered) InfoCard(icon: selected == q.correct ? '🎉' : '💡', title: selected == q.correct ? 'Muito bem!' : 'Vamos aprender', text: q.explanation),
              ]),
            ),
          ),
          if (answered)
            SeniorButton(
              label: quiz == widget.lesson.quiz.length - 1 ? 'Ver resultado' : 'Próxima pergunta',
              icon: Icons.arrow_forward,
              onPressed: () => setState(() {
                if (quiz == widget.lesson.quiz.length - 1) {
                  appState.completeLesson(widget.lesson.id, score);
                  phase = LessonPhase.done;
                } else {
                  quiz++;
                  selected = null;
                }
              }),
            ),
        ]),
      ),
    );
  }

  Widget _doneView(BuildContext context) {
    final total = widget.lesson.quiz.length;
    return AppShell(
      title: 'Aula concluída!',
      showBack: true,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('🎉', style: TextStyle(fontSize: 96)),
            Text(widget.lesson.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            Text('Resultado do quiz: $score/$total', style: const TextStyle(fontSize: 28, color: _line, fontWeight: FontWeight.w900)),
            const SizedBox(height: 24),
            SeniorButton(label: 'Voltar para lições', icon: Icons.check, onPressed: () => Navigator.of(context).pop()),
          ]),
        ),
      ),
    );
  }
}

class AppLauncherPage extends StatelessWidget {
  const AppLauncherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: '📱 Meus Aplicativos',
      subtitle: 'Toque em um ícone para lembrar a função.',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: appGroups.map((group) => AppGroupSection(group: group)).toList(),
      ),
    );
  }
}

class AppGroupSection extends StatelessWidget {
  const AppGroupSection({required this.group, super.key});
  final AppGroup group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(group.title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: group.apps.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: .82),
          itemBuilder: (context, index) {
            final app = group.apps[index];
            return InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(app.message), behavior: SnackBarBehavior.floating)),
              child: Container(
                decoration: BoxDecoration(color: app.color, borderRadius: BorderRadius.circular(24)),
                padding: const EdgeInsets.all(10),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(app.emoji, style: const TextStyle(fontSize: 38)),
                  const SizedBox(height: 8),
                  Text(app.label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                ]),
              ),
            );
          },
        ),
      ]),
    );
  }
}

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

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: '📊 Meu Progresso',
      subtitle: 'Acompanhe seu aprendizado.',
      child: AnimatedBuilder(
        animation: appState,
        builder: (context, _) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ProgressBanner(completed: appState.completedLessons.length, total: appState.totalLessons),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: StatCard(icon: '🏆', value: '${appState.completedLessons.length}', label: 'Aulas concluídas')),
              const SizedBox(width: 12),
              Expanded(child: StatCard(icon: '⏱', value: '${appState.totalMinutes}', label: 'Minutos estudados')),
            ]),
            const SizedBox(height: 20),
            Text('Histórico', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            if (appState.completedLessons.isEmpty) const InfoCard(icon: '🌱', title: 'Comece hoje', text: 'Conclua sua primeira aula para ver seu histórico aqui.'),
            ...appState.completedLessons.map((id) {
              final lesson = lessonById(id)!;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InfoCard(icon: '✅', title: lesson.title, text: 'Quiz: ${appState.quizScores[id] ?? 0}/${lesson.quiz.length} • ${lesson.duration}'),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: '👤 Meu Perfil',
      subtitle: 'Ajustes de acessibilidade e segurança.',
      child: AnimatedBuilder(
        animation: appState,
        builder: (context, _) => ListView(padding: const EdgeInsets.all(16), children: [
          const InfoCard(icon: '😊', title: 'Aluno(a)', text: 'Usuário demonstrativo com progresso salvo apenas durante a sessão.'),
          const SizedBox(height: 16),
          Text('Tamanho do texto', style: Theme.of(context).textTheme.titleLarge),
          Slider(
            value: appState.textScale,
            min: .9,
            max: 1.35,
            divisions: 3,
            label: '${(appState.textScale * 100).round()}%',
            onChanged: appState.setTextScale,
          ),
          SwitchListTile(
            value: appState.highContrast,
            onChanged: (_) => appState.toggleContrast(),
            title: const Text('Alto contraste', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            subtitle: const Text('Mantém fundo escuro e destaque amarelo.'),
          ),
          const SizedBox(height: 16),
          const EmergencyCard(),
          const SizedBox(height: 16),
          SeniorButton.secondary(
            label: 'Sair',
            icon: Icons.logout,
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginPage()), (_) => false),
          ),
        ]),
      ),
    );
  }
}

class AppShell extends StatelessWidget {
  const AppShell({this.title, this.subtitle, required this.child, this.showBack = false, super.key});
  final String? title;
  final String? subtitle;
  final Widget child;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final body = title == null
        ? child
        : Column(children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 16, 16, 18),
              decoration: const BoxDecoration(color: _panel, border: Border(bottom: BorderSide(color: _line, width: 4))),
              child: Row(children: [
                if (showBack) IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, size: 32)),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title!, style: Theme.of(context).textTheme.headlineMedium),
                  if (subtitle != null) Padding(padding: const EdgeInsets.only(top: 4), child: Text(subtitle!, style: const TextStyle(fontSize: 18, color: _muted))),
                ])),
              ]),
            ),
            Expanded(child: child),
          ]);
    return Scaffold(backgroundColor: _bg, body: SafeArea(top: title == null, bottom: false, child: body));
  }
}

class SeniorButton extends StatelessWidget {
  const SeniorButton({required this.label, required this.icon, required this.onPressed, super.key}) : secondaryStyle = false;
  const SeniorButton.secondary({required this.label, required this.icon, required this.onPressed, super.key}) : secondaryStyle = true;
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool secondaryStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: secondaryStyle ? Colors.grey.shade700 : _line,
          foregroundColor: secondaryStyle ? Colors.white : _bg,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: 30),
        label: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({required this.icon, required this.title, required this.text, super.key});
  final String icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white10)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(icon, style: const TextStyle(fontSize: 34)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(text, style: const TextStyle(fontSize: 18, color: _muted, height: 1.35)),
        ])),
      ]),
    );
  }
}

class WarningCard extends StatelessWidget {
  const WarningCard({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.red.shade900, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.red.shade400, width: 2)),
      child: Text('⚠️ $text', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

class ProgressBanner extends StatelessWidget {
  const ProgressBanner({required this.completed, required this.total, super.key});
  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final value = total == 0 ? 0.0 : completed / total;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.yellow.shade700, Colors.orange.shade700]),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Seu progresso', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: _bg)),
        const SizedBox(height: 10),
        LinearProgressIndicator(value: value, minHeight: 14, borderRadius: BorderRadius.circular(99), backgroundColor: Colors.black26, color: Colors.greenAccent),
        const SizedBox(height: 10),
        Text('$completed de $total aulas concluídas', style: const TextStyle(color: _bg, fontSize: 20, fontWeight: FontWeight.w900)),
      ]),
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({required this.icon, required this.value, required this.label, super.key});
  final String icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(24)),
      child: Column(children: [
        Text(icon, style: const TextStyle(fontSize: 40)),
        Text(value, style: const TextStyle(fontSize: 34, color: _line, fontWeight: FontWeight.w900)),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 17, color: _muted)),
      ]),
    );
  }
}

class EmergencyCard extends StatelessWidget {
  const EmergencyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const WarningCard(text: 'Emergência: SAMU 192 • Bombeiros 193 • Polícia 190 • CVV 188. Em risco imediato, ligue para o serviço adequado.');
  }
}

enum LessonPhase { steps, quizIntro, quiz, done }

class LessonCategory {
  const LessonCategory(this.id, this.name, this.emoji, this.color, this.description, this.lessons);
  final String id;
  final String name;
  final String emoji;
  final Color color;
  final String description;
  final List<Lesson> lessons;
}

class Lesson {
  const Lesson({required this.id, required this.title, required this.description, required this.emoji, required this.duration, required this.difficulty, required this.minutes, required this.steps, required this.quiz});
  final String id;
  final String title;
  final String description;
  final String emoji;
  final String duration;
  final String difficulty;
  final int minutes;
  final List<LessonStep> steps;
  final List<QuizQuestion> quiz;
}

class LessonStep {
  const LessonStep(this.title, this.content, this.emoji, {this.tip, this.warning});
  final String title;
  final String content;
  final String emoji;
  final String? tip;
  final String? warning;
}

class QuizQuestion {
  const QuizQuestion(this.question, this.options, this.correct, this.explanation);
  final String question;
  final List<String> options;
  final int correct;
  final String explanation;
}

class ChatMessage {
  const ChatMessage(this.user, this.text);
  final bool user;
  final String text;
}

class AppItem {
  const AppItem(this.label, this.emoji, this.color, this.message);
  final String label;
  final String emoji;
  final Color color;
  final String message;
}

class AppGroup {
  const AppGroup(this.title, this.apps);
  final String title;
  final List<AppItem> apps;
}

Lesson? lessonById(String id) {
  for (final category in categories) {
    for (final lesson in category.lessons) {
      if (lesson.id == id) return lesson;
    }
  }
  return null;
}

String answerFor(String question) {
  final q = question.toLowerCase();
  if (q.contains('golpe') || q.contains('segurança')) {
    return 'Nunca informe senha, código SMS ou número do cartão por mensagem. Desconfie de urgência, links estranhos e pedidos de dinheiro. Na dúvida, ligue para um familiar ou para o banco por um número oficial.';
  }
  if (q.contains('pix')) {
    return 'Para usar PIX com segurança: confira nome e banco antes de confirmar, comece com valores pequenos e nunca faça transferência por pressão de desconhecidos.';
  }
  if (q.contains('gov')) {
    return 'No gov.br, use o aplicativo ou site oficial. Toque em “Esqueci minha senha” e siga as etapas. Peça ajuda a alguém de confiança, mas não compartilhe sua senha.';
  }
  if (q.contains('remédio') || q.contains('remedio')) {
    return 'Use alarmes no celular, mantenha uma lista dos remédios e confirme horários com médico ou farmacêutico. Não altere doses sem orientação profissional.';
  }
  return 'Boa pergunta! Vá por partes: leia a tela, procure botões como “Entrar”, “Confirmar” ou “Voltar” e, se envolver dinheiro ou senha, confirme com alguém de confiança antes de continuar.';
}

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
    Lesson(id: 'tech-3', title: 'Como acessar o gov.br', description: 'Acesse serviços do governo pelo celular', emoji: '🏛️', duration: '12 min', difficulty: 'Médio', minutes: 12, steps: standardSteps('a entrar no gov.br com segurança', '🏛️'), quiz: standardQuiz('gov.br')),
    Lesson(id: 'tech-4', title: 'Usando o PIX', description: 'Transfira dinheiro de forma rápida e gratuita', emoji: '⚡', duration: '10 min', difficulty: 'Médio', minutes: 10, steps: standardSteps('a usar PIX conferindo dados antes de confirmar', '⚡'), quiz: standardQuiz('PIX')),
    Lesson(id: 'tech-5', title: 'Usando o YouTube', description: 'Assista vídeos, receitas e novelas', emoji: '▶️', duration: '8 min', difficulty: 'Fácil', minutes: 8, steps: standardSteps('a procurar vídeos no YouTube', '▶️'), quiz: standardQuiz('YouTube')),
    Lesson(id: 'tech-6', title: 'Usando o Google Maps', description: 'Encontre endereços e trace rotas', emoji: '🗺️', duration: '8 min', difficulty: 'Fácil', minutes: 8, steps: standardSteps('a encontrar caminhos no mapa', '🗺️'), quiz: standardQuiz('mapas')),
  ]),
  LessonCategory('health', 'Saúde', '❤️', Colors.red, 'Cuide melhor da sua saúde e bem-estar', [
    Lesson(id: 'health-1', title: 'Exercícios para o dia a dia', description: 'Atividades leves que você pode fazer em casa', emoji: '🧘', duration: '10 min', difficulty: 'Fácil', minutes: 10, steps: standardSteps('movimentos leves para bem-estar', '🧘'), quiz: standardQuiz('exercícios leves')),
    Lesson(id: 'health-2', title: 'Controlando seus remédios', description: 'Não esqueça mais nenhum comprimido', emoji: '💊', duration: '8 min', difficulty: 'Fácil', minutes: 8, steps: standardSteps('organização dos remédios e alarmes', '💊'), quiz: standardQuiz('controle de remédios')),
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
    Lesson(id: 'citizen-5', title: 'Como identificar e evitar golpes', description: 'Proteja seu dinheiro e seus dados', emoji: '🛡️', duration: '12 min', difficulty: 'Fácil', minutes: 12, steps: standardSteps('identificação de golpes digitais', '🛡️'), quiz: standardQuiz('segurança digital')),
  ]),
  LessonCategory('finance', 'Finanças', '💰', Colors.teal, 'Cuide do dinheiro e conheça seus direitos', [
    Lesson(id: 'finance-1', title: 'Entendendo a aposentadoria', description: 'Tudo sobre benefícios e direitos do INSS', emoji: '👵', duration: '10 min', difficulty: 'Fácil', minutes: 10, steps: standardSteps('direitos básicos da aposentadoria', '👵'), quiz: standardQuiz('aposentadoria')),
    Lesson(id: 'finance-2', title: 'Internet banking com segurança', description: 'Use o banco pelo celular sem riscos', emoji: '🏦', duration: '10 min', difficulty: 'Médio', minutes: 10, steps: standardSteps('banco no celular com segurança', '🏦'), quiz: standardQuiz('internet banking')),
    Lesson(id: 'finance-3', title: 'Crédito consignado', description: 'Entenda antes de assinar qualquer contrato', emoji: '📄', duration: '8 min', difficulty: 'Fácil', minutes: 8, steps: standardSteps('cuidados com crédito consignado', '📄'), quiz: standardQuiz('crédito consignado')),
  ]),
];

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
