import 'package:educacao_idoso/features/assistant/models/assistant_request.dart';
import 'package:educacao_idoso/features/assistant/models/assistant_response.dart';

abstract class AssistantService {
  Future<AssistantResponse> answerFor(AssistantRequest request);
}
