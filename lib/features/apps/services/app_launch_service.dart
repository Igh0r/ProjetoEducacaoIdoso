import 'package:url_launcher/url_launcher.dart';
import 'package:educacao_idoso/features/apps/models/app_models.dart';


class PlannedAppAction {
  const PlannedAppAction({required this.app, required this.requiresConfirmation, required this.confirmationMessage});

  final AppItem app;
  final bool requiresConfirmation;
  final String confirmationMessage;
}

class AppLaunchResult {
  const AppLaunchResult({required this.message, this.launched = false});

  final String message;
  final bool launched;
}

class AppLaunchService {
  const AppLaunchService();


  PlannedAppAction plan(AppItem app) => PlannedAppAction(
        app: app,
        requiresConfirmation: app.actionType != AppActionType.messageOnly || app.isEmergency || _isSensitiveLabel(app.label),
        confirmationMessage: _planningMessage(app),
      );

  Future<AppLaunchResult> launch(AppItem app) async {
    final uri = _buildUri(app);
    if (uri == null) {
      return AppLaunchResult(message: app.message);
    }

    if (await canLaunchUrl(uri)) {
      final launched = await launchUrl(uri, mode: _launchModeFor(app.actionType));
      if (launched) {
        return AppLaunchResult(message: app.message, launched: true);
      }
    }

    return AppLaunchResult(message: app.fallbackMessage ?? _defaultFallback(app));
  }

  Uri? _buildUri(AppItem app) {
    switch (app.actionType) {
      case AppActionType.messageOnly:
        return null;
      case AppActionType.openUrl:
        final url = app.url;
        return url == null ? null : Uri.tryParse(url);
      case AppActionType.phoneCall:
        final phoneNumber = app.phoneNumber;
        return phoneNumber == null ? null : Uri(scheme: 'tel', path: phoneNumber);
      case AppActionType.mapSearch:
        final mapQuery = app.mapQuery;
        return mapQuery == null ? null : Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': mapQuery});
      case AppActionType.appScheme:
        final scheme = app.scheme;
        return scheme == null ? null : Uri.tryParse(scheme);
    }
  }

  LaunchMode _launchModeFor(AppActionType actionType) {
    switch (actionType) {
      case AppActionType.openUrl:
      case AppActionType.mapSearch:
        return LaunchMode.externalApplication;
      case AppActionType.phoneCall:
      case AppActionType.appScheme:
      case AppActionType.messageOnly:
        return LaunchMode.platformDefault;
    }
  }


  bool _isSensitiveLabel(String label) => const {'Banco', 'PIX', 'Emergência', 'gov.br', 'Meu INSS', 'SUS'}.contains(label);

  String _planningMessage(AppItem app) {
    switch (app.actionType) {
      case AppActionType.phoneCall:
        return 'Confirme se deseja ligar para ${app.phoneNumber ?? app.label}.';
      case AppActionType.openUrl:
        return 'Confirme se deseja abrir um site externo de ${app.label}.';
      case AppActionType.mapSearch:
        return 'Confirme se deseja abrir o mapa para ${app.mapQuery ?? app.label}.';
      case AppActionType.appScheme:
        return 'Confirme se deseja abrir ${app.label} fora do aplicativo educativo.';
      case AppActionType.messageOnly:
        return app.message;
    }
  }

  String _defaultFallback(AppItem app) {
    switch (app.actionType) {
      case AppActionType.phoneCall:
        return 'Não foi possível iniciar a ligação. Disque ${app.phoneNumber ?? 'o número indicado'} no telefone.';
      case AppActionType.openUrl:
        return 'Não foi possível abrir o link. Procure pelo canal oficial de ${app.label} no navegador.';
      case AppActionType.mapSearch:
        return 'Não foi possível abrir o mapa. Pesquise por "${app.mapQuery ?? app.label}" no aplicativo de mapas.';
      case AppActionType.appScheme:
        return 'Não foi possível abrir o aplicativo. Procure por ${app.label} nos aplicativos instalados ou na loja oficial.';
      case AppActionType.messageOnly:
        return app.message;
    }
  }
}

const appLaunchService = AppLaunchService();
