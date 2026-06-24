import 'package:educacao_idoso/features/apps/models/app_models.dart';

class AppLaunchService {
  const AppLaunchService();

  String launchMessage(AppItem app) => app.message;
}

const appLaunchService = AppLaunchService();
