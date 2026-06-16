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
