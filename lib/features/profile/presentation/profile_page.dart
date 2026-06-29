import 'package:flutter/material.dart';
import 'package:educacao_idoso/core/state/app_state.dart';
import 'package:educacao_idoso/features/auth/presentation/login_page.dart';
import 'package:educacao_idoso/shared/widgets/shared_widgets.dart';
import 'package:educacao_idoso/features/profile/models/user_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: '👤 Meu Perfil',
      subtitle: 'Ajustes de acessibilidade, segurança e contato de confiança.',
      child: AnimatedBuilder(
        animation: appState,
        builder: (context, _) {
          final settings = appState.accessibilitySettings;
          return ListView(padding: EdgeInsets.all(16 * settings.contentSpacing), children: [
            const InfoCard(icon: '😊', title: 'Aluno(a)', text: 'Usuário demonstrativo com progresso salvo apenas durante a sessão.'),
            SizedBox(height: 16 * settings.contentSpacing),
            Text('Acessibilidade visual', style: Theme.of(context).textTheme.titleLarge),
            _AccessibilitySlider(
              title: 'Tamanho do texto',
              value: settings.textScale,
              min: .9,
              max: 1.35,
              divisions: 3,
              label: '${(settings.textScale * 100).round()}%',
              onChanged: appState.setTextScale,
            ),
            _AccessibilitySlider(
              title: 'Escala dos botões',
              value: settings.buttonScale,
              min: .9,
              max: 1.3,
              divisions: 4,
              label: '${(settings.buttonScale * 100).round()}%',
              onChanged: appState.setButtonScale,
            ),
            _AccessibilitySlider(
              title: 'Espaçamento do conteúdo',
              value: settings.contentSpacing,
              min: 1,
              max: 1.4,
              divisions: 4,
              label: '${(settings.contentSpacing * 100).round()}%',
              onChanged: appState.setContentSpacing,
            ),
            SwitchListTile(
              value: settings.highContrast,
              onChanged: (_) => appState.toggleContrast(),
              title: const Text('Alto contraste', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              subtitle: const Text('Reforça contraste entre fundo, texto e destaques.'),
            ),
            SwitchListTile(
              value: settings.lowLightTheme,
              onChanged: appState.setLowLightTheme,
              title: const Text('Tema de baixa luminosidade', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              subtitle: const Text('Reduz brilho e troca o destaque amarelo por azul suave.'),
            ),
            SwitchListTile(
              value: settings.dyslexiaFriendlyFont,
              onChanged: appState.setDyslexiaFriendlyFont,
              title: const Text('Fonte amigável para dislexia', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              subtitle: const Text('Usa fonte monoespaçada com maior espaçamento entre letras.'),
            ),
            SwitchListTile(
              value: settings.readAloudEnabled,
              onChanged: appState.setReadAloudEnabled,
              title: const Text('Ler aulas em voz alta', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              subtitle: const Text('Mostra o botão “Ouvir explicação” durante as aulas, quando houver voz disponível no sistema.'),
            ),
            SeniorButton.secondary(
              label: 'Restaurar configurações padrão',
              icon: Icons.restore,
              onPressed: () {
                final previous = appState.accessibilitySettings;
                appState.resetAccessibilitySettings();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Configurações de acessibilidade restauradas.'),
                  action: SnackBarAction(label: 'Desfazer', onPressed: () => appState.updateAccessibilitySettings(previous)),
                ));
              },
            ),
            SizedBox(height: 16 * settings.contentSpacing),
            const EmergencyCard(),
            SizedBox(height: 16 * settings.contentSpacing),
            SeniorButton.secondary(
              label: 'Sair',
              icon: Icons.logout,
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginPage()), (_) => false),
            ),
          ]);
        },
      ),
    );
  }
}

class _AccessibilitySlider extends StatelessWidget {
  const _AccessibilitySlider({required this.title, required this.value, required this.min, required this.max, required this.divisions, required this.label, required this.onChanged});

  final String title;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String label;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
      Slider(value: value, min: min, max: max, divisions: divisions, label: label, onChanged: onChanged),
    ]);
  }
}

Future<void> showProfileEditor(BuildContext context, UserProfile initialProfile) async {
  final nameController = TextEditingController(text: initialProfile.name);
  final phoneController = TextEditingController(text: initialProfile.emergencyPhone);
  final contactController = TextEditingController(text: initialProfile.trustedContactName);
  final preferencesController = TextEditingController(text: initialProfile.preferences);
  final formKey = GlobalKey<FormState>();

  String? phoneError(String? value) {
    final phone = (value ?? '').trim();
    if (phone.isEmpty) return 'Informe um telefone de emergência.';
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 8 || digits.length > 13) return 'Use um formato como (11) 99999-9999.';
    return null;
  }

  try {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Perfil opcional'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(controller: nameController, decoration: const InputDecoration(labelText: 'Nome (opcional)')),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Telefone de emergência (obrigatório)', helperText: 'Exemplo: (11) 99999-9999'),
                  keyboardType: TextInputType.phone,
                  validator: phoneError,
                ),
                TextFormField(controller: contactController, decoration: const InputDecoration(labelText: 'Contato de confiança (opcional)')),
                TextFormField(controller: preferencesController, decoration: const InputDecoration(labelText: 'Preferências (opcional)'), maxLines: 2),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Cancelar')),
          FilledButton(
            onPressed: () async {
              if (!(formKey.currentState?.validate() ?? false)) return;
              await appState.saveUserProfile(UserProfile(
                name: nameController.text.trim(),
                emergencyPhone: phoneController.text.trim(),
                trustedContactName: contactController.text.trim(),
                preferences: preferencesController.text.trim(),
              ));
              if (!dialogContext.mounted) return;
              Navigator.of(dialogContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Perfil salvo neste computador.'), behavior: SnackBarBehavior.floating));
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  } finally {
    nameController.dispose();
    phoneController.dispose();
    contactController.dispose();
    preferencesController.dispose();
  }
}
