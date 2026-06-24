import 'package:flutter/material.dart';
import 'package:educacao_idoso/features/apps/data/app_seed_data.dart';
import 'package:educacao_idoso/features/apps/models/app_models.dart';
import 'package:educacao_idoso/features/apps/services/app_launch_service.dart';
import 'package:educacao_idoso/shared/widgets/shared_widgets.dart';

class AppLauncherPage extends StatelessWidget {
  const AppLauncherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: '📱 Meus Aplicativos',
      subtitle: 'Toque em um ícone para lembrar a função.',
      child: ListView(
        padding: EdgeInsets.all(16 * appState.accessibilitySettings.contentSpacing),
        children: appGroups.map((group) => AppGroupSection(group: group)).toList(),
      ),
    );
  }
}

Future<void> _confirmAndLaunch(BuildContext context, AppItem app) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(app.isEmergency ? 'Confirmar emergência' : 'Confirmar ação'),
      content: Text(_confirmationMessage(app)),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancelar')),
        FilledButton(onPressed: () => Navigator.of(context).pop(true), child: Text(app.isEmergency ? 'Ligar' : 'Continuar')),
      ],
    ),
  );

  if (!context.mounted || confirmed != true) return;

  final result = await appLaunchService.launch(app);
  if (!context.mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.message), behavior: SnackBarBehavior.floating));
}

String _confirmationMessage(AppItem app) {
  if (app.isEmergency && app.phoneNumber != null) {
    return 'Você está prestes a ligar para ${app.phoneNumber} (${app.label}). Confirme apenas em caso de necessidade.';
  }

  switch (app.actionType) {
    case AppActionType.phoneCall:
      return 'Deseja ligar para ${app.phoneNumber ?? app.label}?';
    case AppActionType.openUrl:
      return 'Deseja abrir o link oficial de ${app.label}?';
    case AppActionType.mapSearch:
      return 'Deseja pesquisar ${app.mapQuery ?? app.label} no mapa?';
    case AppActionType.appScheme:
      return 'Deseja abrir ${app.label} no aplicativo compatível?';
    case AppActionType.messageOnly:
      return app.message;
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
        SizedBox(height: 12 * appState.accessibilitySettings.contentSpacing),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: group.apps.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: .82),
          itemBuilder: (context, index) {
            final app = group.apps[index];
            return InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => _confirmAndLaunch(context, app),
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

