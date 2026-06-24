import 'package:flutter/material.dart';
import 'package:educacao_idoso/core/state/app_state.dart';
import 'package:educacao_idoso/features/learning/repositories/lesson_repository.dart';
import 'package:educacao_idoso/shared/widgets/shared_widgets.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: '📊 Meu Progresso',
      subtitle: 'Acompanhe seu aprendizado.',
      child: AnimatedBuilder(
        animation: appState,
        builder: (context, _) {
          final nextLesson = appState.nextLesson;
          final reviewSuggestions = appState.reviewSuggestions;
          final primaryReview = reviewSuggestions.isNotEmpty ? reviewSuggestions.first : null;
          final actionLesson = primaryReview?.lesson ?? nextLesson;

          return ListView(
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
              if (actionLesson != null) ...[
                InfoCard(
                  icon: primaryReview == null ? '▶️' : '🔁',
                  title: primaryReview == null ? 'Continue de onde parou' : 'Revisar esta aula',
                  text: primaryReview == null
                      ? '${actionLesson.title} • ${actionLesson.duration}'
                      : 'Tema ${primaryReview.category.name}: ${primaryReview.score}/${primaryReview.total}. Refaça ${actionLesson.title} para reforçar.',
                ),
                const SizedBox(height: 10),
                SeniorButton(
                  label: primaryReview == null ? 'Continuar aula' : 'Revisar aula',
                  icon: primaryReview == null ? Icons.play_arrow : Icons.replay,
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LessonPage(lesson: actionLesson))),
                ),
                const SizedBox(height: 20),
              ],
              Text('Medalhas', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              ...appState.achievements.map((achievement) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AchievementCard(achievement: achievement),
                  )),
              const SizedBox(height: 10),
              Text('Sugestões de revisão', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              if (reviewSuggestions.isEmpty)
                const InfoCard(icon: '✨', title: 'Tudo em dia', text: 'Quando algum quiz tiver pontos a melhorar, as aulas aparecerão aqui para revisão.'),
              ...reviewSuggestions.map((suggestion) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InfoCard(
                      icon: suggestion.category.emoji,
                      title: suggestion.category.name,
                      text: 'Pontuação do tema: ${suggestion.score}/${suggestion.total}. Aula indicada: ${suggestion.lesson.title}.',
                    ),
                  )),
              const SizedBox(height: 20),
              Text('Histórico', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              if (appState.completedLessons.isEmpty) const InfoCard(icon: '🌱', title: 'Comece hoje', text: 'Conclua sua primeira aula para ver seu histórico aqui.'),
              ...appState.chronologicalHistory.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InfoCard(
                    icon: '✅',
                    title: item.lesson.title,
                    text: 'Quiz: ${item.score}/${item.lesson.quiz.length} • ${item.lesson.duration} • Concluída em ${_formatDateTime(item.completedAt)}',
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  String _formatDateTime(DateTime? value) {
    if (value == null) return 'data não registrada';
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$day/$month/${value.year} às $hour:$minute';
  }
}

class AchievementCard extends StatelessWidget {
  const AchievementCard({required this.achievement, super.key});

  final ProgressAchievement achievement;

  @override
  Widget build(BuildContext context) {
    final color = achievement.unlocked ? Colors.amber.shade700 : Colors.grey.shade800;
    final status = achievement.unlocked ? 'Conquistada' : 'Em andamento';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _panel,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: achievement.unlocked ? Colors.amber : Colors.white10, width: achievement.unlocked ? 2 : 1),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: color,
          child: Text(achievement.icon, style: const TextStyle(fontSize: 28)),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(achievement.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(achievement.description, style: const TextStyle(fontSize: 18, color: _muted, height: 1.35)),
          const SizedBox(height: 8),
          Text(
            achievement.progressText == null ? status : '$status • ${achievement.progressText}',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: achievement.unlocked ? Colors.amber : _muted),
          ),
        ])),
      ]),
    );
  }
}
