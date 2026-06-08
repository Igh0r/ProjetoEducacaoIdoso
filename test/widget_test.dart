import 'package:educacao_idoso/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('exibe tela inicial de boas-vindas', (tester) async {
    await tester.pumpWidget(const EducacaoIdosoApp());

    expect(find.text('Bem-vindo!'), findsOneWidget);
    expect(find.text('Entrar no aplicativo'), findsOneWidget);
  });
}
