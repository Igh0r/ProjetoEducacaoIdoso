part of 'package:educacao_idoso/main.dart';

abstract class AppRepository {
  List<AppGroup> getGroups();
}

class InMemoryAppRepository implements AppRepository {
  const InMemoryAppRepository();

  @override
  List<AppGroup> getGroups() => appGroups;
}

const appRepository = InMemoryAppRepository();
