import 'package:flutter/material.dart';

part 'app/theme/app_theme.dart';
part 'features/learning/models/learning_models.dart';
part 'features/assistant/models/chat_message.dart';
part 'features/apps/models/app_models.dart';
part 'features/learning/data/lesson_seed_data.dart';
part 'features/apps/data/app_seed_data.dart';
part 'features/learning/repositories/lesson_repository.dart';
part 'features/learning/utils/lesson_utils.dart';
part 'features/progress/repositories/progress_repository.dart';
part 'features/progress/services/progress_service.dart';
part 'features/assistant/services/assistant_answer_service.dart';
part 'features/apps/services/app_launch_service.dart';
part 'core/state/app_state.dart';
part 'shared/widgets/shared_widgets.dart';
part 'features/auth/presentation/login_page.dart';
part 'features/navigation/presentation/main_navigation.dart';
part 'features/learning/presentation/learning_pages.dart';
part 'features/apps/presentation/app_launcher_page.dart';
part 'features/assistant/presentation/assistant_page.dart';
part 'features/progress/presentation/progress_page.dart';
part 'features/profile/presentation/profile_page.dart';

void main() => runApp(const EducacaoIdosoApp());
