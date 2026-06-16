part of 'package:educacao_idoso/main.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: '👤 Meu Perfil',
      subtitle: 'Ajustes de acessibilidade e segurança.',
      child: AnimatedBuilder(
        animation: appState,
        builder: (context, _) => ListView(padding: const EdgeInsets.all(16), children: [
          const InfoCard(icon: '😊', title: 'Aluno(a)', text: 'Usuário demonstrativo com progresso salvo apenas durante a sessão.'),
          const SizedBox(height: 16),
          Text('Tamanho do texto', style: Theme.of(context).textTheme.titleLarge),
          Slider(
            value: appState.textScale,
            min: .9,
            max: 1.35,
            divisions: 3,
            label: '${(appState.textScale * 100).round()}%',
            onChanged: appState.setTextScale,
          ),
          SwitchListTile(
            value: appState.highContrast,
            onChanged: (_) => appState.toggleContrast(),
            title: const Text('Alto contraste', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            subtitle: const Text('Mantém fundo escuro e destaque amarelo.'),
          ),
          SwitchListTile(
            value: appState.accessibilitySettings.lowLightTheme,
            onChanged: (value) => appState.updateAccessibility(appState.accessibilitySettings.copyWith(lowLightTheme: value)),
            title: const Text('Tema baixa luminosidade', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            subtitle: const Text('Preparado para futura variação menos intensa do tema.'),
          ),
          SwitchListTile(
            value: appState.accessibilitySettings.readAloudEnabled,
            onChanged: (value) => appState.updateAccessibility(appState.accessibilitySettings.copyWith(readAloudEnabled: value)),
            title: const Text('Leitura em voz alta', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            subtitle: const Text('Preferência salva em sessão para futura integração de voz.'),
          ),
          const SizedBox(height: 16),
          const EmergencyCard(),
          const SizedBox(height: 16),
          SeniorButton.secondary(
            label: 'Sair',
            icon: Icons.logout,
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginPage()), (_) => false),
          ),
        ]),
      ),
    );
  }
}
