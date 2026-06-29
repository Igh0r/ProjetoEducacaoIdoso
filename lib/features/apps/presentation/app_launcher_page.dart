import 'package:flutter/material.dart';
import 'package:educacao_idoso/features/apps/data/app_seed_data.dart';
import 'package:educacao_idoso/features/apps/models/app_models.dart';
import 'package:educacao_idoso/features/apps/services/app_launch_service.dart';
import 'package:educacao_idoso/shared/widgets/shared_widgets.dart';
import 'package:educacao_idoso/core/state/app_state.dart';

class AppLauncherPage extends StatelessWidget {
  const AppLauncherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: '📱 Meus Aplicativos',
      subtitle: 'Clique em um ícone para abrir uma opção compatível com este computador.',
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
class AppGroupSection extends StatefulWidget {
  const AppGroupSection({required this.group, super.key});
  final AppGroup group;

  @override
  State<AppGroupSection> createState() => _AppGroupSectionState();
}

class _AppGroupSectionState extends State<AppGroupSection> {
  String? launchingLabel;

  Future<void> launch(AppItem app) async {
    if (launchingLabel != null) return;
    final confirmed = await _confirmLaunch(context, app);
    if (!mounted || confirmed != true) return;

    setState(() => launchingLabel = app.label);
    final result = await appLaunchService.launch(app);
    if (!mounted) return;
    setState(() => launchingLabel = null);

    if (result.launched) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.message), behavior: SnackBarBehavior.floating));
    } else {
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Não foi possível abrir'),
          content: Text(result.message),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Fechar')),
            FilledButton(onPressed: () { Navigator.of(context).pop(); launch(app); }, child: const Text('Tentar novamente')),
          ],
        ),
      );
    }
  }

  Future<bool?> _confirmLaunch(BuildContext context, AppItem app) => showDialog<bool>(
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.group.title, style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 12 * appState.accessibilitySettings.contentSpacing),
        LayoutBuilder(builder: (context, constraints) {
          final width = constraints.maxWidth;
          final columns = width < 430 ? 1 : width < 760 ? 2 : 3;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.group.apps.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: columns == 1 ? 2.8 : .95),
            itemBuilder: (context, index) {
              final app = widget.group.apps[index];
              final isLaunching = launchingLabel == app.label;
              return InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: isLaunching ? null : () => launch(app),
                child: Opacity(
                  opacity: launchingLabel == null || isLaunching ? 1 : .55,
                  child: Container(
                    decoration: BoxDecoration(color: app.color, borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.all(10),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(app.emoji, style: const TextStyle(fontSize: 38)),
                      const SizedBox(height: 8),
                      Text(isLaunching ? 'Abrindo...' : app.label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                      if (isLaunching) const Padding(padding: EdgeInsets.only(top: 8), child: CircularProgressIndicator()),
                    ]),
                  ),
                ),
              );
            },
          );
        }),
      ]),
    );
  }
}
