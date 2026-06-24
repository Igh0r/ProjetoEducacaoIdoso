import 'package:educacao_idoso/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pumpMainNavigation(WidgetTester tester) async {
  appState
    ..textScale = 1
    ..highContrast = true;

  await tester.pumpWidget(const EducacaoIdosoApp());
  await tester.tap(find.text('Entrar no aplicativo'));
  await tester.pumpAndSettle();
}

Future<void> _tapNavigationDestination(WidgetTester tester, String label) async {
  await tester.tap(find.text(label).last);
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('navega entre as abas principais do MainNavigation', (tester) async {
    await _pumpMainNavigation(tester);

    expect(find.text('O que vamos aprender hoje?'), findsOneWidget);

    await _tapNavigationDestination(tester, 'Apps');
    expect(find.text('📱 Meus Aplicativos'), findsOneWidget);

    await _tapNavigationDestination(tester, 'Ajuda');
    expect(find.text('🤖 Assistente Digital'), findsOneWidget);

    await _tapNavigationDestination(tester, 'Progresso');
    expect(find.text('📊 Meu Progresso'), findsOneWidget);

    await _tapNavigationDestination(tester, 'Perfil');
    expect(find.text('👤 Meu Perfil'), findsOneWidget);

    await _tapNavigationDestination(tester, 'Aprender');
    expect(find.text('O que vamos aprender hoje?'), findsOneWidget);
  });

  testWidgets('abre uma categoria e uma aula', (tester) async {
    await _pumpMainNavigation(tester);

    await tester.tap(find.text('Tecnologia'));
    await tester.pumpAndSettle();

    expect(find.text('💻 Tecnologia'), findsOneWidget);
    expect(find.text('Usando WhatsApp'), findsOneWidget);

    await tester.tap(find.text('Usando WhatsApp'));
    await tester.pumpAndSettle();

    expect(find.text('Usando WhatsApp'), findsWidgets);
    expect(find.text('Passo 1 de 4'), findsOneWidget);
    expect(find.text('O que é o WhatsApp?'), findsOneWidget);
  });

  testWidgets('avança passos, responde quiz e conclui aula', (tester) async {
    await _pumpMainNavigation(tester);

    await tester.tap(find.text('Tecnologia'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Usando WhatsApp'));
    await tester.pumpAndSettle();

    for (final label in ['Próximo', 'Próximo', 'Próximo', 'Fazer quiz']) {
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
    }

    expect(find.text('🧠 Hora do quiz!'), findsOneWidget);
    await tester.tap(find.text('Começar quiz'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Mensagens, fotos, áudios e chamadas'));
    await tester.pumpAndSettle();
    expect(find.text('Muito bem!'), findsOneWidget);
    await tester.tap(find.text('Próxima pergunta'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Segurar o microfone, falar e soltar'));
    await tester.pumpAndSettle();
    expect(find.text('Muito bem!'), findsOneWidget);
    await tester.tap(find.text('Ver resultado'));
    await tester.pumpAndSettle();

    expect(find.text('Aula concluída!'), findsOneWidget);
    expect(find.text('Resultado do quiz: 2/2'), findsOneWidget);
    expect(appState.completedLessons, contains('tech-1'));
    expect(appState.quizScores['tech-1'], 2);
  });

  testWidgets('altera tamanho do texto e alto contraste no Perfil', (tester) async {
    await _pumpMainNavigation(tester);
    await _tapNavigationDestination(tester, 'Perfil');

    final slider = find.byType(Slider);
    expect(slider, findsOneWidget);
    await tester.drag(slider, const Offset(300, 0));
    await tester.pumpAndSettle();
    expect(appState.textScale, greaterThan(1));

    expect(appState.highContrast, isTrue);
    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    expect(appState.highContrast, isFalse);
  });

  testWidgets('toca em app no lançador e exibe mensagem de lançamento', (tester) async {
    await _pumpMainNavigation(tester);
    await _tapNavigationDestination(tester, 'Apps');

    await tester.tap(find.text('WhatsApp'));
    await tester.pump();

    expect(find.text('Abrindo WhatsApp...'), findsOneWidget);
  });
}
