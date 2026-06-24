abstract class ProgressRepository {
  Set<String> getCompletedLessons();
  Map<String, int> getQuizScores();
  Map<String, DateTime> getCompletionDates();
  void completeLesson(String lessonId, int score);
}

class InMemoryProgressRepository implements ProgressRepository {
  final Set<String> _completedLessons = <String>{};
  final Map<String, int> _quizScores = <String, int>{};
  final Map<String, DateTime> _completionDates = <String, DateTime>{};

  @override
  Set<String> getCompletedLessons() => Set.unmodifiable(_completedLessons);

  @override
  Map<String, int> getQuizScores() => Map.unmodifiable(_quizScores);

  @override
  Map<String, DateTime> getCompletionDates() => _completionDates;

  @override
  void completeLesson(String lessonId, int score) {
    _completedLessons.add(lessonId);
    _quizScores[lessonId] = score;
    _completionDates[lessonId] = DateTime.now();
  }
}

class SqliteProgressRepository implements ProgressRepository {
  static const _databaseName = 'educacao_idoso.db';
  static const _databaseVersion = 1;
  static const _completedLessonsTable = 'completed_lessons';

  Database? _database;
  final Set<String> _completedLessons = <String>{};
  final Map<String, int> _quizScores = <String, int>{};

  Future<void> init() async {
    final databasePath = await getDatabasesPath();
    _database = await openDatabase(
      p.join(databasePath, _databaseName),
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_completedLessonsTable (
            lesson_id TEXT PRIMARY KEY,
            score INTEGER NOT NULL,
            completed_at TEXT NOT NULL
          )
        ''');
      },
    );
    await _loadCompletedLessons();
  }

  Future<void> _loadCompletedLessons() async {
    final db = _database;
    if (db == null) return;

    final rows = await db.query(_completedLessonsTable);
    _completedLessons
      ..clear()
      ..addAll(rows.map((row) => row['lesson_id']! as String));
    _quizScores
      ..clear()
      ..addEntries(
        rows.map(
          (row) => MapEntry(
            row['lesson_id']! as String,
            row['score']! as int,
          ),
        ),
      );
  }

  @override
  Set<String> getCompletedLessons() => Set.unmodifiable(_completedLessons);

  @override
  Map<String, int> getQuizScores() => Map.unmodifiable(_quizScores);

  @override
  void completeLesson(String lessonId, int score) {
    _completedLessons.add(lessonId);
    _quizScores[lessonId] = score;

    final db = _database;
    if (db == null) return;

    unawaited(db.insert(
      _completedLessonsTable,
      <String, Object?>{
        'lesson_id': lessonId,
        'score': score,
        'completed_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    ));
  }
}
