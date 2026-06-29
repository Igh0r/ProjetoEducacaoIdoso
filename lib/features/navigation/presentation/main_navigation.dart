import 'package:flutter/material.dart';
import 'package:educacao_idoso/app/theme/app_colors.dart';
import 'package:educacao_idoso/core/state/app_state.dart';
import 'package:educacao_idoso/features/apps/presentation/app_launcher_page.dart';
import 'package:educacao_idoso/features/assistant/presentation/assistant_page.dart';
import 'package:educacao_idoso/features/learning/presentation/learning_pages.dart';
import 'package:educacao_idoso/features/profile/presentation/profile_page.dart';
import 'package:educacao_idoso/features/progress/presentation/progress_page.dart';
import 'package:educacao_idoso/features/accessibility/services/accessibility_service.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int index = 0;

  final pages = const [
    HomePage(),
    AppLauncherPage(),
    AssistantPage(),
    ProgressPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: accessibilityService.textScalerFor(appState.accessibilitySettings),
        ),
        child: Scaffold(
          body: pages[index],
          bottomNavigationBar: NavigationBar(
            selectedIndex: index,
            backgroundColor: appPanelColor,
            indicatorColor: appAccentColor,
            labelTextStyle: MaterialStateProperty.all(const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            height: 88,
            onDestinationSelected: (value) => setState(() => index = value),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.school, size: 32), label: 'Aprender'),
              NavigationDestination(icon: Icon(Icons.apps, size: 32), label: 'Apps'),
              NavigationDestination(icon: Icon(Icons.smart_toy, size: 32), label: 'Ajuda'),
              NavigationDestination(icon: Icon(Icons.bar_chart, size: 32), label: 'Progresso'),
              NavigationDestination(icon: Icon(Icons.person, size: 32), label: 'Perfil'),
            ],
          ),
        ),
      ),
    );
  }
}

