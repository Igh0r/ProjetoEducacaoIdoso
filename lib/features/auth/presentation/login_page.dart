part of 'package:educacao_idoso/main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🌟', style: TextStyle(fontSize: 84)),
                const SizedBox(height: 12),
                Text('Bem-vindo!', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 12),
                const Text(
                  'Aprenda tecnologia, saúde, cidadania e finanças no seu ritmo, com letras grandes e passos simples.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: _muted, height: 1.35),
                ),
                const SizedBox(height: 28),
                SeniorButton(
                  label: 'Entrar no aplicativo',
                  icon: Icons.login,
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const MainNavigation()),
                  ),
                ),
                const SizedBox(height: 16),
                const InfoCard(
                  icon: '🔒',
                  title: 'Seguro e acolhedor',
                  text: 'Este protótipo usa login simplificado para facilitar testes e demonstrações.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

