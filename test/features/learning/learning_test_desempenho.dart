import 'package:flutter_test/flutter_test.dart';
// Ajuste o import abaixo de acordo com o nome real do seu arquivo de serviço em lib/features/learning
import 'package:projetoeducacaoidoso/features/learning/services/lesson_session_controller.dart'; 

void main() {
  group('Testes de Desempenho - Módulo de Aprendizado (RF03)', () {
    
    test('Validar carregamento de aulas em menos de 3 segundos (RNF02)', () async {
      // Instancia o serviço localizado na feature 'learning'
      final learningService = LessonSessionController();
      
      // Inicia o cronômetro para medir o desempenho técnico
      final stopwatch = Stopwatch()..start();
      
      // Simula a ação de permitir acesso às aulas cadastradas (RF03)
      // fetchLessons() representa a chamada real para buscar as aulas
      final result = await learningService.fetchLessons();
      
      stopwatch.stop();
      
      // Validação do Requisito Funcional: Verifica se os dados foram retornados
      expect(result, isNotNull, reason: 'O sistema deve retornar a lista de aulas cadastradas.');
      
      // Validação do Requisito Não Funcional (RNF02): Tempo de resposta
      final int tempoDecorrido = stopwatch.elapsedMilliseconds;
      print('Tempo de resposta para acesso às aulas: ${tempoDecorrido}ms');
      
      expect(tempoDecorrido, lessThan(3000), 
        reason: 'ALERTA: O tempo de resposta ($tempoDecorrido ms) excedeu o limite de 3s definido no RNF02.');
    });
  });
}