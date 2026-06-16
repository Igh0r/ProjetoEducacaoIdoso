part of 'package:educacao_idoso/main.dart';

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
          textScaler: TextScaler.linear(appState.textScale),
        ),
        child: Scaffold(
          body: pages[index],
          bottomNavigationBar: NavigationBar(
            selectedIndex: index,
            backgroundColor: _panel,
            indicatorColor: _line,
            labelTextStyle: WidgetStateProperty.all(const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
            onDestinationSelected: (value) => setState(() => index = value),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.school), label: 'Aprender'),
              NavigationDestination(icon: Icon(Icons.apps), label: 'Apps'),
              NavigationDestination(icon: Icon(Icons.smart_toy), label: 'Ajuda'),
              NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Progresso'),
              NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
            ],
          ),
        ),
      ),
    );
  }
}

