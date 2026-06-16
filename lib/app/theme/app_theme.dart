part of 'package:educacao_idoso/main.dart';

const _bg = Color(0xFF111827);
const _panel = Color(0xFF1F2937);
const _line = Color(0xFFFACC15);
const _muted = Color(0xFFD1D5DB);

class EducacaoIdosoApp extends StatelessWidget {
  const EducacaoIdosoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      state: appState,
      child: MaterialApp(
      title: 'Educação para Idosos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _line,
          brightness: Brightness.dark,
          primary: _line,
          surface: _panel,
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
      ),
    );
  }
}
