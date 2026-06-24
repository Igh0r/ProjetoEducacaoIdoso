import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import 'app/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final progressRepository = SqliteProgressRepository();
  await progressRepository.init();
  appState = AppState(progressRepository: progressRepository);
  runApp(const EducacaoIdosoApp());
}
