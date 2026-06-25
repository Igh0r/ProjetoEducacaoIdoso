import 'package:flutter/material.dart';
import 'package:educacao_idoso/app/theme/app_colors.dart';
import 'package:educacao_idoso/features/auth/presentation/login_page.dart';
import 'package:educacao_idoso/core/state/app_state.dart';
import 'package:educacao_idoso/features/accessibility/models/accessibility_settings.dart';

const _lowLightBg = Color(0xFF050816);
const _lowLightPanel = Color(0xFF111827);
const _lowLightLine = Color(0xFF38BDF8);

class EducacaoIdosoApp extends StatelessWidget {
  const EducacaoIdosoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) => MaterialApp(
        title: 'Educação para Idosos',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.fromAccessibility(appState.accessibilitySettings),
        home: const LoginPage(),
      ),
    );
  }
}

class AppTheme {
  const AppTheme._();

  static ThemeData fromAccessibility(AccessibilitySettings settings) {
    if (settings.lowLightTheme) {
      return _buildTheme(settings, background: _lowLightBg, panel: _lowLightPanel, accent: _lowLightLine, highContrast: settings.highContrast);
    }

    return _buildTheme(settings, background: appBackgroundColor, panel: appPanelColor, accent: settings.highContrast ? appAccentColor : Colors.amber.shade400, highContrast: settings.highContrast);
  }

  static ThemeData _buildTheme(
    AccessibilitySettings settings, {
    required Color background,
    required Color panel,
    required Color accent,
    required bool highContrast,
  }) {
    final textColor = highContrast ? Colors.white : appMutedTextColor;
    final fontFamily = settings.dyslexiaFriendlyFont ? 'monospace' : 'Roboto';

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        brightness: Brightness.dark,
        primary: accent,
        surface: panel,
      ),
      fontFamily: fontFamily,
      textTheme: TextTheme(
        headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: textColor, letterSpacing: settings.dyslexiaFriendlyFont ? .6 : null),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: textColor, letterSpacing: settings.dyslexiaFriendlyFont ? .5 : null),
        titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: textColor, letterSpacing: settings.dyslexiaFriendlyFont ? .4 : null),
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: textColor, letterSpacing: settings.dyslexiaFriendlyFont ? .3 : null),
        bodyLarge: TextStyle(fontSize: 20, height: settings.contentSpacing, color: textColor, letterSpacing: settings.dyslexiaFriendlyFont ? .25 : null),
        bodyMedium: TextStyle(fontSize: 18, height: settings.contentSpacing, color: textColor, letterSpacing: settings.dyslexiaFriendlyFont ? .2 : null),
      ),
      cardTheme: CardThemeData(color: panel, margin: EdgeInsets.all(12 * settings.contentSpacing)),
      dividerColor: highContrast ? accent : Colors.white24,
      useMaterial3: true,
    );
  }
}
