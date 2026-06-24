import 'dart:io';

import 'package:educacao_idoso/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('salva e carrega perfil do usuário localmente', () async {
    final directory = await Directory.systemTemp.createTemp('educacao_idoso_profile_test');
    final file = File('${directory.path}/profile.json');
    final repository = LocalProfileRepository(file: file);

    await repository.saveProfile(const UserProfile(
      name: 'Maria',
      emergencyPhone: '11999999999',
      trustedContactName: 'Ana',
      preferences: 'Letras grandes',
    ));

    final reloaded = LocalProfileRepository(file: file).loadProfile();

    expect(reloaded.name, 'Maria');
    expect(reloaded.emergencyPhone, '11999999999');
    expect(reloaded.trustedContactLabel, 'Ana (11999999999)');
    expect(reloaded.preferences, 'Letras grandes');

    await directory.delete(recursive: true);
  });
}
