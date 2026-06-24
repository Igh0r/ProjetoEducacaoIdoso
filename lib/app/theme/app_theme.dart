import 'package:flutter/material.dart';
import 'package:educacao_idoso/app/theme/app_colors.dart';
import 'package:educacao_idoso/features/auth/presentation/login_page.dart';

class EducacaoIdosoApp extends StatelessWidget {
  const EducacaoIdosoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Educação para Idosos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: appBackgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: appAccentColor,
          brightness: Brightness.dark,
          primary: appAccentColor,
          surface: appPanelColor,
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          bodyLarge: TextStyle(fontSize: 20, height: 1.35),
          bodyMedium: TextStyle(fontSize: 18, height: 1.35),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
