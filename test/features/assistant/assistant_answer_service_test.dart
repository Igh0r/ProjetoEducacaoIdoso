import 'package:educacao_idoso/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('responde dúvidas de segurança e PIX localmente', () {
    expect(assistantAnswerService.answerFor('golpe'), contains('senha'));
    expect(assistantAnswerService.answerFor('PIX'), contains('confira'));
  });
}
