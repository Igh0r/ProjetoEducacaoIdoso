part of 'package:educacao_idoso/main.dart';

enum AppActionType { messageOnly, openUrl, callPhone, openMap }

class AppItem {
  const AppItem(
    this.label,
    this.emoji,
    this.color,
    this.message, {
    this.actionType = AppActionType.messageOnly,
    this.officialUrl,
    this.phoneNumber,
  });

  final String label;
  final String emoji;
  final Color color;
  final String message;
  final AppActionType actionType;
  final Uri? officialUrl;
  final String? phoneNumber;
}

class AppGroup {
  const AppGroup(this.title, this.apps);
  final String title;
  final List<AppItem> apps;
}
