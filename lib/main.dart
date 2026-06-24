import 'package:educacao_idoso/app/theme/app_theme.dart';
import 'package:educacao_idoso/core/state/app_state.dart';
import 'package:educacao_idoso/features/progress/repositories/progress_repository.dart';
import 'package:flutter/material.dart';

export 'app/theme/app_theme.dart';
export 'core/state/app_state.dart';
export 'features/accessibility/models/accessibility_settings.dart';
export 'features/accessibility/services/accessibility_service.dart';
export 'features/accessibility/services/text_to_speech_service.dart';
export 'features/apps/data/app_seed_data.dart';
export 'features/apps/models/app_models.dart';
export 'features/apps/repositories/app_repository.dart';
export 'features/apps/services/app_launch_service.dart';
export 'features/assistant/models/chat_message.dart';
export 'features/assistant/services/assistant_answer_service.dart';
export 'features/learning/data/lesson_seed_data.dart';
export 'features/learning/models/learning_models.dart';
export 'features/learning/models/quiz_attempt.dart';
export 'features/learning/repositories/lesson_repository.dart';
export 'features/learning/services/lesson_session_controller.dart';
export 'features/learning/utils/lesson_utils.dart';
export 'features/profile/models/user_profile.dart';
export 'features/profile/repositories/profile_repository.dart';
export 'features/progress/repositories/progress_repository.dart';
export 'features/progress/services/progress_service.dart';
export 'shared/widgets/shared_widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  appState = AppState(progressRepository: InMemoryProgressRepository());
  runApp(const EducacaoIdosoApp());
}
