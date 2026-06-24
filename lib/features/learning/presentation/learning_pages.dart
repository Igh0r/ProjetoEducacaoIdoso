import 'package:flutter/material.dart';
import 'package:educacao_idoso/app/theme/app_colors.dart';
import 'package:educacao_idoso/core/state/app_state.dart';
import 'package:educacao_idoso/features/learning/data/lesson_seed_data.dart';
import 'package:educacao_idoso/features/learning/models/learning_models.dart';
import 'package:educacao_idoso/shared/widgets/shared_widgets.dart';

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
          color: appPanelColor,
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
                Text(category.description, style: const TextStyle(fontSize: 18, color: appMutedTextColor)),
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
        decoration: BoxDecoration(color: appPanelColor, borderRadius: BorderRadius.circular(24)),
        child: Row(children: [
          Text(completed ? '✅' : lesson.emoji, style: const TextStyle(fontSize: 42)),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(lesson.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(lesson.description, style: const TextStyle(fontSize: 17, color: appMutedTextColor)),
            const SizedBox(height: 10),
            Wrap(spacing: 10, runSpacing: 8, children: [
              Chip(label: Text('⏱ ${lesson.duration}')),
              Chip(label: Text('⭐ ${lesson.difficulty}')),
            ]),
          ])),
          const Icon(Icons.play_circle_fill, color: appAccentColor, size: 38),
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
                decoration: BoxDecoration(color: appPanelColor, borderRadius: BorderRadius.circular(32)),
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
                  decoration: BoxDecoration(color: appPanelColor, borderRadius: BorderRadius.circular(28)),
                  child: Text(q.question, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge),
                ),
                const SizedBox(height: 16),
                ...List.generate(q.options.length, (i) {
                  final isCorrect = i == q.correct;
                  final isSelected = i == selected;
                  Color color = appPanelColor;
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
            Text('Resultado do quiz: $score/$total', style: const TextStyle(fontSize: 28, color: appAccentColor, fontWeight: FontWeight.w900)),
            const SizedBox(height: 24),
            SeniorButton(label: 'Voltar para lições', icon: Icons.check, onPressed: () => Navigator.of(context).pop()),
          ]),
        ),
      ),
    );
  }
}

