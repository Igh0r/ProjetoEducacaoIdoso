part of 'package:educacao_idoso/main.dart';

class AppShell extends StatelessWidget {
  const AppShell({this.title, this.subtitle, required this.child, this.showBack = false, super.key});
  final String? title;
  final String? subtitle;
  final Widget child;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final body = title == null
        ? child
        : Column(children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 16, 16, 18),
              decoration: const BoxDecoration(color: _panel, border: Border(bottom: BorderSide(color: _line, width: 4))),
              child: Row(children: [
                if (showBack) IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, size: 32)),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title!, style: Theme.of(context).textTheme.headlineMedium),
                  if (subtitle != null) Padding(padding: const EdgeInsets.only(top: 4), child: Text(subtitle!, style: const TextStyle(fontSize: 18, color: _muted))),
                ])),
              ]),
            ),
            Expanded(child: child),
          ]);
    return Scaffold(backgroundColor: _bg, body: SafeArea(top: title == null, bottom: false, child: body));
  }
}

class SeniorButton extends StatelessWidget {
  const SeniorButton({required this.label, required this.icon, required this.onPressed, super.key}) : secondaryStyle = false;
  const SeniorButton.secondary({required this.label, required this.icon, required this.onPressed, super.key}) : secondaryStyle = true;
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool secondaryStyle;

  @override
  Widget build(BuildContext context) {
    final buttonScale = appState.accessibilitySettings.buttonScale;
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: secondaryStyle ? Colors.grey.shade700 : _line,
          foregroundColor: secondaryStyle ? Colors.white : _bg,
          padding: EdgeInsets.symmetric(vertical: 20 * buttonScale, horizontal: 18 * buttonScale),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: 30 * buttonScale),
        label: Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 23 * buttonScale, fontWeight: FontWeight.w900)),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({required this.icon, required this.title, required this.text, super.key});
  final String icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final spacing = appState.accessibilitySettings.contentSpacing;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18 * spacing),
      decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white10)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(icon, style: const TextStyle(fontSize: 34)),
        SizedBox(width: 14 * spacing),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 6 * spacing),
          Text(text, style: const TextStyle(fontSize: 18, color: _muted, height: 1.35)),
        ])),
      ]),
    );
  }
}

class WarningCard extends StatelessWidget {
  const WarningCard({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final spacing = appState.accessibilitySettings.contentSpacing;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18 * spacing),
      decoration: BoxDecoration(color: Colors.red.shade900, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.red.shade400, width: 2)),
      child: Text('⚠️ $text', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

class ProgressBanner extends StatelessWidget {
  const ProgressBanner({required this.completed, required this.total, super.key});
  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final value = total == 0 ? 0.0 : completed / total;
    return Container(
      padding: EdgeInsets.all(22 * appState.accessibilitySettings.contentSpacing),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.yellow.shade700, Colors.orange.shade700]),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Seu progresso', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: _bg)),
        const SizedBox(height: 10),
        LinearProgressIndicator(value: value, minHeight: 14, borderRadius: BorderRadius.circular(99), backgroundColor: Colors.black26, color: Colors.greenAccent),
        const SizedBox(height: 10),
        Text('$completed de $total aulas concluídas', style: const TextStyle(color: _bg, fontSize: 20, fontWeight: FontWeight.w900)),
      ]),
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({required this.icon, required this.value, required this.label, super.key});
  final String icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18 * appState.accessibilitySettings.contentSpacing),
      decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(24)),
      child: Column(children: [
        Text(icon, style: const TextStyle(fontSize: 40)),
        Text(value, style: const TextStyle(fontSize: 34, color: _line, fontWeight: FontWeight.w900)),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 17, color: _muted)),
      ]),
    );
  }
}

class EmergencyCard extends StatelessWidget {
  const EmergencyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const WarningCard(text: 'Emergência: SAMU 192 • Bombeiros 193 • Polícia 190 • CVV 188. Em risco imediato, ligue para o serviço adequado.');
  }
}

