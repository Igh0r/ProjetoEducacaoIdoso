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
