import 'dart:convert';
import 'dart:io';

import 'package:educacao_idoso/features/profile/models/user_profile.dart';

abstract class ProfileRepository {
  UserProfile loadProfile();
  Future<void> saveProfile(UserProfile profile);
}

class InMemoryProfileRepository implements ProfileRepository {
  InMemoryProfileRepository([this._profile = const UserProfile()]);

  UserProfile _profile;

  @override
  UserProfile loadProfile() => _profile;

  @override
  Future<void> saveProfile(UserProfile profile) async {
    _profile = profile;
  }
}

class LocalProfileRepository implements ProfileRepository {
  LocalProfileRepository({File? file}) : _file = file ?? _defaultFile;

  final File _file;
  UserProfile? _cache;

  static File get _defaultFile {
    final home = Platform.environment['HOME'] ?? Directory.systemTemp.path;
    return File('$home/.educacao_idoso/user_profile.json');
  }

  @override
  UserProfile loadProfile() {
    if (_cache != null) return _cache!;
    if (!_file.existsSync()) return _cache = const UserProfile();
    try {
      final decoded = jsonDecode(_file.readAsStringSync());
      if (decoded is Map<String, Object?>) {
        return _cache = UserProfile.fromJson(decoded);
      }
      if (decoded is Map) {
        return _cache =
            UserProfile.fromJson(Map<String, Object?>.from(decoded));
      }
    } on FormatException {
      // If local data is corrupt, keep the app usable and let the next save repair it.
    } on FileSystemException {
      // Local persistence is best-effort; the in-memory profile still works this session.
    }
    return _cache = const UserProfile();
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    _cache = profile;
    await _file.parent.create(recursive: true);
    await _file.writeAsString(jsonEncode(profile.toJson()));
  }
}
