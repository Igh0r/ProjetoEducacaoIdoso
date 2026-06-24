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
        padding: EdgeInsets.all(16 * appState.accessibilitySettings.contentSpacing),
        children: [
          AnimatedBuilder(
            animation: appState,
            builder: (context, _) => Column(
              children: [
                ProgressBanner(
                  completed: appState.completedLessons.length,
                  total: appState.totalLessons,
                ),
                const SizedBox(height: 16),
                RecommendedLessonCard(lesson: LessonUtils.nextRecommendedLesson(learningTracks, appState.completedLessons)),
              ],
            ),
          ),
          SizedBox(height: 20 * appState.accessibilitySettings.contentSpacing),
          ...categories.map((category) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CategoryCard(category: category),
              )),
          SizedBox(height: 20 * appState.accessibilitySettings.contentSpacing),
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
            SizedBox(width: 16 * appState.accessibilitySettings.contentSpacing),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(category.name, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 6),
                 Text(category.description, style: const TextStyle(fontSize: 18, color: _muted)),
                SizedBox(height: 10 * appState.accessibilitySettings.contentSpacing),
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
        padding: EdgeInsets.all(16 * appState.accessibilitySettings.contentSpacing),
        itemCount: category.lessons.length,
        itemBuilder: (context, index) {
          final lesson = category.lessons[index];
          final completed = appState.completedLessons.contains(lesson.id);
          final unlocked = LessonUtils.isUnlocked(lesson, appState.completedLessons);
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: LessonTile(lesson: lesson, completed: completed, unlocked: unlocked),
          );
        },
      ),
    );
  }
}

class LessonTile extends StatelessWidget {
  const LessonTile({required this.lesson, required this.completed, required this.unlocked, super.key});
  final Lesson lesson;
  final bool completed;
  final bool unlocked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: unlocked || completed ? () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LessonPage(lesson: lesson))) : null,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: unlocked || completed ? _panel : _panel.withOpacity(0.55), borderRadius: BorderRadius.circular(24)),
        child: Row(children: [
          Text(completed ? '✅' : lesson.emoji, style: const TextStyle(fontSize: 42)),
          SizedBox(width: 16 * appState.accessibilitySettings.contentSpacing),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(lesson.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(lesson.description, style: const TextStyle(fontSize: 17, color: _muted)),
            SizedBox(height: 10 * appState.accessibilitySettings.contentSpacing),
            Wrap(spacing: 10, runSpacing: 8, children: [
              Chip(label: Text('⏱ ${lesson.duration}')),
              Chip(label: Text('⭐ ${lesson.difficulty}')),
              Chip(label: Text('🧭 ${LessonUtils.trackName(lesson.trackId)}')),
              Chip(label: Text('📈 ${lesson.level}')),
            ]),
            if (!unlocked && !completed) ...[
              const SizedBox(height: 8),
              Text('Conclua primeiro: ${LessonUtils.missingPrerequisites(lesson, appState.completedLessons).map((id) => lessonById(id)?.title ?? id).join(', ')}', style: const TextStyle(fontSize: 15, color: _muted, fontWeight: FontWeight.bold)),
            ],
          ])),
          Icon(unlocked || completed ? Icons.play_circle_fill : Icons.lock, color: _line, size: 38),
        ]),
      ),
    );
  }
}

class RecommendedLessonCard extends StatelessWidget {
  const RecommendedLessonCard({required this.lesson, super.key});
  final Lesson? lesson;

  @override
  Widget build(BuildContext context) {
    if (lesson == null) {
      return const InfoCard(icon: '🎉', title: 'Próxima aula recomendada', text: 'Você concluiu todas as aulas disponíveis. Continue revisando quando quiser!');
    }

    final next = lesson!;
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LessonPage(lesson: next))),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _panel,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: _line, width: 3),
        ),
        child: Row(children: [
          Text(next.emoji, style: const TextStyle(fontSize: 46)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Próxima aula recomendada', style: TextStyle(fontSize: 18, color: _line, fontWeight: FontWeight.w900)),
              const SizedBox(height: 6),
              Text(next.title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 6),
              Text('${LessonUtils.trackName(next.trackId)} • ${next.level} • ${next.duration}', style: const TextStyle(fontSize: 17, color: _muted)),
            ]),
          ),
          const Icon(Icons.arrow_forward, size: 34),
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
  bool attemptSaved = false;
  LessonPhase phase = LessonPhase.steps;
  final Map<int, int> selectedAnswers = <int, int>{};

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        switch (controller.phase) {
          case LessonPhase.steps:
            return _stepView(context);
          case LessonPhase.quizIntro:
            return _quizIntro(context);
          case LessonPhase.quiz:
            return _quizView(context);
          case LessonPhase.done:
            return _doneView(context);
        }
      },
    );
  }

  Widget _stepView(BuildContext context) {
    final item = controller.step;
    final progress = (controller.currentStep + 1) / widget.lesson.steps.length;
    return AppShell(
      title: widget.lesson.title,
      subtitle: 'Passo ${controller.currentStep + 1} de ${widget.lesson.steps.length}',
      showBack: true,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(children: [
          LinearProgressIndicator(value: progress, minHeight: 12, borderRadius: BorderRadius.circular(99)),
          SizedBox(height: 20 * appState.accessibilitySettings.contentSpacing),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: appPanelColor, borderRadius: BorderRadius.circular(32)),
                child: Column(children: [
                  Text(item.emoji, style: const TextStyle(fontSize: 88)),
                  SizedBox(height: 16 * appState.accessibilitySettings.contentSpacing),
                  Text(item.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 18),
                  Text(item.content, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
                  if (accessibilitySettings.readAloudEnabled) ...[
                    const SizedBox(height: 20),
                    SeniorButton.secondary(
                      label: 'Ouvir explicação',
                      icon: Icons.volume_up,
                      onPressed: () => _textToSpeechService.speakLessonStep(
                        item,
                        settings: accessibilitySettings,
                      ),
                    ),
                  ],
                  if (item.tip != null) ...[
                    SizedBox(height: 20 * appState.accessibilitySettings.contentSpacing),
                    InfoCard(icon: '💡', title: 'Dica', text: item.tip!),
                  ],
                  if (item.warning != null) ...[
                    SizedBox(height: 20 * appState.accessibilitySettings.contentSpacing),
                    WarningCard(text: item.warning!),
                  ],
                ]),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(children: [
            if (controller.currentStep > 0)
              Expanded(
                child: SeniorButton.secondary(
                  label: 'Voltar',
                  icon: Icons.arrow_back,
                  onPressed: controller.goToPreviousStep,
                ),
              ),
            if (controller.currentStep > 0) const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: SeniorButton(
                label: controller.isLastStep ? 'Fazer quiz' : 'Próximo',
                icon: Icons.arrow_forward,
                onPressed: controller.goToNextStep,
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
            SeniorButton(label: 'Começar quiz', icon: Icons.psychology, onPressed: controller.startQuiz),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                _saveAttempt();
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
    final q = controller.question;
    final answered = controller.selectedAnswer != null;
    return AppShell(
      title: 'Quiz ${controller.currentQuestion + 1}/${widget.lesson.quiz.length}',
      subtitle: widget.lesson.title,
      showBack: true,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(children: [
          LinearProgressIndicator(value: (controller.currentQuestion + 1) / widget.lesson.quiz.length, minHeight: 12, borderRadius: BorderRadius.circular(99)),
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
                SizedBox(height: 16 * appState.accessibilitySettings.contentSpacing),
                ...List.generate(q.options.length, (i) {
                  final isCorrect = i == q.correct;
                  final isSelected = i == controller.selectedAnswer;
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
                                  selectedAnswers[quiz] = i;
                                  if (isCorrect) score++;
                                }),
                        child: Text(q.options[i], textAlign: TextAlign.center, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  );
                }),
                if (answered) InfoCard(icon: controller.selectedAnswer == q.correct ? '🎉' : '💡', title: controller.selectedAnswer == q.correct ? 'Muito bem!' : 'Vamos aprender', text: q.explanation),
              ]),
            ),
          ),
          if (answered)
            SeniorButton(
              label: controller.isLastQuestion ? 'Ver resultado' : 'Próxima pergunta',
              icon: Icons.arrow_forward,
              onPressed: () => setState(() {
                if (quiz == widget.lesson.quiz.length - 1) {
                  _saveAttempt();
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
      subtitle: 'Confira sua revisão antes de voltar.',
      showBack: true,
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(32)),
            child: Column(children: [
              const Text('🎉', style: TextStyle(fontSize: 80)),
              Text(widget.lesson.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              Text('Resultado do quiz: $score/$total', style: const TextStyle(fontSize: 28, color: _line, fontWeight: FontWeight.w900)),
            ]),
          ),
          const SizedBox(height: 20),
          Text('Revisão das respostas', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ...List.generate(widget.lesson.quiz.length, _reviewCard),
          const SizedBox(height: 12),
          SeniorButton(label: 'Voltar para lições', icon: Icons.check, onPressed: () => Navigator.of(context).pop()),
        ],
      ),
    );
  }

  Widget _reviewCard(int index) {
    final question = widget.lesson.quiz[index];
    final selectedIndex = selectedAnswers[index];
    final isCorrect = selectedIndex == question.correct;
    final statusColor = isCorrect ? Colors.green.shade700 : Colors.red.shade700;
    final statusIcon = isCorrect ? Icons.check_circle : Icons.cancel;
    final statusText = isCorrect ? 'Você acertou' : selectedIndex == null ? 'Não respondida' : 'Você errou';
    final selectedText = selectedIndex == null ? 'Sem resposta escolhida' : question.options[selectedIndex];
    final correctText = question.options[question.correct];

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _panel,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: statusColor, width: 3),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(statusIcon, color: statusColor, size: 34),
            const SizedBox(width: 10),
            Expanded(child: Text(statusText, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: statusColor))),
          ]),
          const SizedBox(height: 12),
          Text('${index + 1}. ${question.question}', style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          _reviewLine('Sua resposta', selectedText, selectedIndex == null ? Colors.orange.shade800 : statusColor),
          const SizedBox(height: 8),
          _reviewLine('Resposta correta', correctText, Colors.green.shade700),
          const SizedBox(height: 12),
          InfoCard(icon: '💡', title: 'Explicação', text: question.explanation),
        ]),
      ),
    );
  }

  Widget _reviewLine(String label, String text, Color color) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.circle, color: color, size: 16),
        const SizedBox(width: 10),
        Expanded(child: Text('$label: $text', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
      ]);

  void _saveAttempt() {
    if (attemptSaved) return;
    appState.saveQuizAttempt(QuizAttempt(
      lessonId: widget.lesson.id,
      selectedAnswers: Map.unmodifiable(selectedAnswers),
      score: score,
      finishedAt: DateTime.now(),
    ));
    attemptSaved = true;
  }
}
