part of 'package:educacao_idoso/main.dart';

class AppLaunchService {
  const AppLaunchService();

  String launchMessage(AppItem app) => app.message;
}

const appLaunchService = AppLaunchService();
