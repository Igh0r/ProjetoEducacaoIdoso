import 'package:educacao_idoso/features/apps/data/app_seed_data.dart';
import 'package:educacao_idoso/features/apps/models/app_models.dart';

abstract class AppRepository {
  List<AppGroup> getGroups();
}

class InMemoryAppRepository implements AppRepository {
  const InMemoryAppRepository();

  @override
  List<AppGroup> getGroups() => appGroups;
}

const appRepository = InMemoryAppRepository();
