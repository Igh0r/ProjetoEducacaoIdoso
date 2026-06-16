part of 'package:educacao_idoso/main.dart';

class AppLauncherPage extends StatelessWidget {
  const AppLauncherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: '📱 Meus Aplicativos',
      subtitle: 'Toque em um ícone para lembrar a função.',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: appRepository.getGroups().map((group) => AppGroupSection(group: group)).toList(),
      ),
    );
  }
}

class AppGroupSection extends StatelessWidget {
  const AppGroupSection({required this.group, super.key});
  final AppGroup group;


  void _showPlannedAction(BuildContext context, AppItem app) {
    final action = appLaunchService.plan(app);
    if (!action.requiresConfirmation) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(action.message), behavior: SnackBarBehavior.floating));
      return;
    }
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(action.title),
        content: Text(action.message, style: const TextStyle(fontSize: 18)),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Entendi')),
        ],
      ),
    );
  }

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
              onTap: () => _showPlannedAction(context, app),
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

