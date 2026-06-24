import 'package:flutter/material.dart';
import 'package:educacao_idoso/core/state/app_state.dart';
import 'package:educacao_idoso/features/auth/presentation/login_page.dart';
import 'package:educacao_idoso/shared/widgets/shared_widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: '👤 Meu Perfil',
      subtitle: 'Ajustes de acessibilidade, segurança e contato de confiança.',
      child: AnimatedBuilder(
        animation: appState,
        builder: (context, _) => ListView(padding: const EdgeInsets.all(16), children: [
          ProfileSummaryCard(profile: appState.userProfile),
          const SizedBox(height: 12),
          const InfoCard(
            icon: '🔐',
            title: 'Privacidade',
            text: 'Seu perfil é opcional e fica salvo somente neste aparelho. Use apenas dados que você se sinta confortável em guardar localmente.',
          ),
          const SizedBox(height: 16),
          SeniorButton(
            label: appState.userProfile.hasAnyData ? 'Editar meus dados' : 'Cadastrar dados opcionais',
            icon: Icons.edit_note,
            onPressed: () => showProfileEditor(context, appState.userProfile),
          ),
          const SizedBox(height: 24),
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
          const SizedBox(height: 16),
          EmergencyCard(profile: appState.userProfile),
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

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({required this.profile, super.key});
  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    if (!profile.hasAnyData) {
      return const InfoCard(
        icon: '😊',
        title: 'Cadastro opcional',
        text: 'Você pode entrar sem preencher nada. Se quiser, adicione nome, contato de emergência e preferências para receber orientações mais acolhedoras.',
      );
    }
    return InfoCard(
      icon: '😊',
      title: profile.name.trim().isEmpty ? 'Aluno(a)' : profile.name.trim(),
      text: 'Contato de confiança: ${profile.trustedContactLabel}. Preferências: ${profile.preferences.trim().isEmpty ? 'não informadas' : profile.preferences.trim()}.',
    );
  }
}

Future<void> showProfileEditor(BuildContext context, UserProfile profile) async {
  final name = TextEditingController(text: profile.name);
  final phone = TextEditingController(text: profile.emergencyPhone);
  final trusted = TextEditingController(text: profile.trustedContactName);
  final prefs = TextEditingController(text: profile.preferences);

  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: _panel,
      title: const Text('Dados opcionais do perfil'),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Essas informações ficam armazenadas apenas neste aparelho e ajudam o app a lembrar seu contato de confiança em situações sensíveis.'),
          const SizedBox(height: 12),
          _ProfileField(controller: name, label: 'Nome', icon: Icons.person),
          _ProfileField(controller: phone, label: 'Telefone de emergência', icon: Icons.phone),
          _ProfileField(controller: trusted, label: 'Familiar ou cuidador', icon: Icons.volunteer_activism),
          _ProfileField(controller: prefs, label: 'Preferências e observações', icon: Icons.notes, maxLines: 3),
        ]),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Agora não')),
        FilledButton(
          onPressed: () async {
            await appState.saveUserProfile(UserProfile(
              name: name.text.trim(),
              emergencyPhone: phone.text.trim(),
              trustedContactName: trusted.text.trim(),
              preferences: prefs.text.trim(),
            ));
            if (context.mounted) Navigator.of(context).pop();
          },
          child: const Text('Salvar neste aparelho'),
        ),
      ],
    ),
  );
  name.dispose();
  phone.dispose();
  trusted.dispose();
  prefs.dispose();
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({required this.controller, required this.label, required this.icon, this.maxLines = 1});
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(prefixIcon: Icon(icon), labelText: label, filled: true, fillColor: Colors.white10),
      ),
    );
  }
}
