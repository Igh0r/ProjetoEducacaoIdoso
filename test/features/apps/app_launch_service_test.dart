import 'package:educacao_idoso/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ações sensíveis exigem confirmação', () {
    final bank = appRepository.getGroups().expand((group) => group.apps).firstWhere((app) => app.label == 'Banco');

    expect(appLaunchService.plan(bank).requiresConfirmation, isTrue);
  });
}
