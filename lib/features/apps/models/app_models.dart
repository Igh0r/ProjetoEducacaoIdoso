import 'package:flutter/material.dart';

enum AppActionType { messageOnly, openUrl, phoneCall, mapSearch, appScheme }

class AppItem {
  const AppItem(
    this.label,
    this.emoji,
    this.color,
    this.message, {
    this.actionType = AppActionType.messageOnly,
    this.url,
    this.phoneNumber,
    this.mapQuery,
    this.scheme,
    this.fallbackMessage,
    this.isEmergency = false,
  });

  final String label;
  final String emoji;
  final Color color;
  final String message;
  final AppActionType actionType;
  final String? url;
  final String? phoneNumber;
  final String? mapQuery;
  final String? scheme;
  final String? fallbackMessage;
  final bool isEmergency;
}

class AppGroup {
  const AppGroup(this.title, this.apps);
  final String title;
  final List<AppItem> apps;
}
