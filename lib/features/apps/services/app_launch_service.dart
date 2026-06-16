part of 'package:educacao_idoso/main.dart';

class PlannedAppAction {
  const PlannedAppAction({required this.title, required this.message, required this.requiresConfirmation});

  final String title;
  final String message;
  final bool requiresConfirmation;
}

class AppLaunchService {
  const AppLaunchService();

  String launchMessage(AppItem app) => app.message;

  PlannedAppAction plan(AppItem app) => PlannedAppAction(
        title: app.label,
        message: app.message,
        requiresConfirmation: app.actionType != AppActionType.messageOnly,
      );
}

const appLaunchService = AppLaunchService();
