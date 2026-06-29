import 'package:flutter_test/flutter_test.dart';
import 'package:educacao_idoso/features/learning/repositories/lesson_repository.dart';

void main() {
  group('Testes de Desempenho - Módulo de Aprendizado (RF03)', () {
    
    test('Validar carregamento de aulas em menos de 3 segundos (RNF02)', () async {
      // Inicia o cronômetro para medir o desempenho técnico
      final stopwatch = Stopwatch()..start();
      
      // Acessa as aulas cadastradas por meio do repositório da feature.
      final result = lessonRepository.getCategories();
      
      stopwatch.stop();
      
      // Validação do Requisito Funcional: Verifica se os dados foram retornados
      expect(result, isNotEmpty, reason: 'O sistema deve retornar a lista de aulas cadastradas.');
      
      // Validação do Requisito Não Funcional (RNF02): Tempo de resposta
      final int tempoDecorrido = stopwatch.elapsedMilliseconds;
      print('Tempo de resposta para acesso às aulas: ${tempoDecorrido}ms');
      
      expect(tempoDecorrido, lessThan(3000), 
        reason: 'ALERTA: O tempo de resposta ($tempoDecorrido ms) excedeu o limite de 3s definido no RNF02.');
    });
  });
}
