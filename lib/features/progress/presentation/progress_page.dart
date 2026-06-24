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
        builder: (context, _) => ListView(
          padding: EdgeInsets.all(16 * appState.accessibilitySettings.contentSpacing),
          children: [
            ProgressBanner(completed: appState.completedLessons.length, total: appState.totalLessons),
            SizedBox(height: 16 * appState.accessibilitySettings.contentSpacing),
            Row(children: [
              Expanded(child: StatCard(icon: '🏆', value: '${appState.completedLessons.length}', label: 'Aulas concluídas')),
              SizedBox(width: 12 * appState.accessibilitySettings.contentSpacing),
              Expanded(child: StatCard(icon: '⏱', value: '${appState.totalMinutes}', label: 'Minutos estudados')),
            ]),
            SizedBox(height: 20 * appState.accessibilitySettings.contentSpacing),
            Text('Histórico', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10 * appState.accessibilitySettings.contentSpacing),
            if (appState.completedLessons.isEmpty) const InfoCard(icon: '🌱', title: 'Comece hoje', text: 'Conclua sua primeira aula para ver seu histórico aqui.'),
            ...appState.completedLessons.map((id) {
              final lesson = lessonById(id)!;
              final latestAttempt = appState.latestQuizAttempt(id);
              final bestAttempt = appState.bestQuizAttempt(id);
              final latestScore = latestAttempt?.score ?? appState.quizScores[id] ?? 0;
              final bestScore = bestAttempt?.score ?? latestScore;
              final attemptCount = appState.quizAttempts[id]?.length ?? 0;
              final attemptSummary = attemptCount == 0
                  ? 'Sem tentativa registrada'
                  : 'Última tentativa: $latestScore/${lesson.quiz.length} • Melhor: $bestScore/${lesson.quiz.length} • $attemptCount tentativa${attemptCount == 1 ? '' : 's'}';
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InfoCard(
                  icon: bestScore == lesson.quiz.length ? '🏆' : '✅',
                  title: lesson.title,
                  text: '$attemptSummary • ${lesson.duration}',
                ),
              );
            }),
          ],
        ),
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
