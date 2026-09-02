import 'package:flutter/foundation.dart';
import 'package:marquee/lists/data_sources/movie_list_entries_schema.dart';
import 'package:marquee/lists/data_sources/movie_lists_data_source.dart';
import 'package:marquee/lists/models/movie_list.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SqfliteMovieListsDataSource(final Database _database)
    implements MovieListsDataSource {
  static const _movieListEntriesSchema = MovieListEntriesSchema();

  static const _databaseVersion = 2;

  static Future<SqfliteMovieListsDataSource> open() async {
    final String path;
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      path = 'movie_lists.db';
    } else {
      path = join(await getDatabasesPath(), 'movie_lists.db');
    }

    final database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, _) => _createMovieListEntries(db),
    );

    return SqfliteMovieListsDataSource(database);
  }

  static Future<void> _createMovieListEntries(Database db) => db.execute('''
        CREATE TABLE ${_movieListEntriesSchema.tableName} (
          ${_movieListEntriesSchema.userId} TEXT NOT NULL,
          ${_movieListEntriesSchema.list} TEXT NOT NULL,
          ${_movieListEntriesSchema.movieId} INTEGER NOT NULL,
          ${_movieListEntriesSchema.title} TEXT NOT NULL,
          ${_movieListEntriesSchema.posterPath} TEXT,
          ${_movieListEntriesSchema.voteAverage} REAL NOT NULL,
          ${_movieListEntriesSchema.runtime} INTEGER,
          ${_movieListEntriesSchema.releaseDate} INTEGER,
          ${_movieListEntriesSchema.addedAt} INTEGER NOT NULL,
          PRIMARY KEY (
            ${_movieListEntriesSchema.userId},
            ${_movieListEntriesSchema.list},
            ${_movieListEntriesSchema.movieId}
          )
        )
      ''');

  @override
  Future<List<Movie>> moviesInList({
    required String userId,
    required MovieList list,
  }) async {
    final rows = await _database.query(
      _movieListEntriesSchema.tableName,
      columns: [
        _movieListEntriesSchema.movieId,
        _movieListEntriesSchema.title,
        _movieListEntriesSchema.posterPath,
        _movieListEntriesSchema.voteAverage,
        _movieListEntriesSchema.runtime,
        _movieListEntriesSchema.releaseDate,
      ],
      where:
          '${_movieListEntriesSchema.userId} = ? '
          'AND ${_movieListEntriesSchema.list} = ?',
      whereArgs: [userId, list.name],
      orderBy: '${_movieListEntriesSchema.addedAt} DESC',
    );

    return rows.map(_movieFromRow).toList();
  }

  @override
  Future<Set<MovieList>> listsContainingMovie({
    required String userId,
    required int movieId,
  }) async {
    final rows = await _database.query(
      _movieListEntriesSchema.tableName,
      where:
          '${_movieListEntriesSchema.userId} = ? '
          'AND ${_movieListEntriesSchema.movieId} = ?',
      whereArgs: [userId, movieId],
    );

    return rows
        .map(
          (row) => MovieList.values.byName(
            _getColumnValueAsOrThrow<String>(row, _movieListEntriesSchema.list),
          ),
        )
        .toSet();
  }

  @override
  Future<void> addToList({
    required String userId,
    required MovieList list,
    required Movie movie,
  }) async {
    await _database.insert(
      _movieListEntriesSchema.tableName,
      {
        _movieListEntriesSchema.userId: userId,
        _movieListEntriesSchema.list: list.name,
        ...movie.toDisplayColumns(_movieListEntriesSchema),
        _movieListEntriesSchema.addedAt: DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFromList({
    required String userId,
    required MovieList list,
    required int movieId,
  }) async {
    await _database.delete(
      _movieListEntriesSchema.tableName,
      where:
          '${_movieListEntriesSchema.userId} = ? '
          'AND ${_movieListEntriesSchema.list} = ? '
          'AND ${_movieListEntriesSchema.movieId} = ?',
      whereArgs: [userId, list.name, movieId],
    );
  }

  @override
  Future<void> updateSavedMovie({
    required String userId,
    required Movie movie,
  }) async {
    await _database.update(
      _movieListEntriesSchema.tableName,
      movie.toDisplayColumns(_movieListEntriesSchema),
      where:
          '${_movieListEntriesSchema.userId} = ? '
          'AND ${_movieListEntriesSchema.movieId} = ?',
      whereArgs: [userId, movie.id],
    );
  }

  Movie _movieFromRow(Map<String, Object?> row) {
    final releaseDateMillis = row[_movieListEntriesSchema.releaseDate] as int?;

    return Movie(
      id: _getColumnValueAsOrThrow<int>(row, _movieListEntriesSchema.movieId),
      title: _getColumnValueAsOrThrow<String>(
        row,
        _movieListEntriesSchema.title,
      ),
      posterPath: row[_movieListEntriesSchema.posterPath] as String?,
      voteAverage: _getColumnValueAsOrThrow<double>(
        row,
        _movieListEntriesSchema.voteAverage,
      ),
      runtime: row[_movieListEntriesSchema.runtime] as int?,
      releaseDate: releaseDateMillis == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(releaseDateMillis),
    );
  }

  T _getColumnValueAsOrThrow<T>(Map<String, Object?> row, String key) {
    final value = row[key];

    return value is T ? value : throw StateError('Missing column $key');
  }
}

extension on Movie {
  Map<String, Object?> toDisplayColumns(MovieListEntriesSchema schema) => {
    schema.movieId: id,
    schema.title: title,
    schema.posterPath: posterPath,
    schema.voteAverage: voteAverage,
    schema.runtime: runtime,
    schema.releaseDate: releaseDate?.millisecondsSinceEpoch,
  };
}
