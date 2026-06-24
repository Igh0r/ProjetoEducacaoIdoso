import 'package:flutter/material.dart';

class AppItem {
  const AppItem(this.label, this.emoji, this.color, this.message);
  final String label;
  final String emoji;
  final Color color;
  final String message;
}

class AppGroup {
  const AppGroup(this.title, this.apps);
  final String title;
  final List<AppItem> apps;
}

