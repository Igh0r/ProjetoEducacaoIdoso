part of 'package:educacao_idoso/main.dart';

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
}
