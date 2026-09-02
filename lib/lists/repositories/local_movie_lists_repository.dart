import 'dart:async';

import 'package:marquee/auth/repositories/auth_repository.dart';
import 'package:marquee/lists/data_sources/movie_lists_data_source.dart';
import 'package:marquee/lists/models/movie_list.dart';
import 'package:marquee/lists/models/movie_lists_exception.dart';
import 'package:marquee/lists/repositories/movie_lists_repository.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

class LocalMovieListsRepository(
  final MovieListsDataSource _dataSource,
  final AuthRepository _authRepository,
) implements MovieListsRepository {
  final BehaviorSubject<void> _changesSubject = BehaviorSubject.seeded(null);

  @override
  Stream<void> get changes => _changesSubject.shareValue();

  @override
  Future<List<Movie>> getMoviesInList(MovieList list) =>
      _catchAndConvertToDomainException(
        () => _dataSource.moviesInList(userId: _requireUserId(), list: list),
      );

  @override
  Future<Set<MovieList>> getListsContainingMovie(Movie movie) =>
      _catchAndConvertToDomainException(
        () => _dataSource.listsContainingMovie(
          userId: _requireUserId(),
          movieId: movie.id,
        ),
      );

  @override
  Future<void> addToList(Movie movie, MovieList list) =>
      _catchAndConvertToDomainException(() async {
        await _dataSource.addToList(
          userId: _requireUserId(),
          list: list,
          movie: movie,
        );
        _changesSubject.add(null);
      });

  @override
  Future<void> removeFromList(Movie movie, MovieList list) =>
      _catchAndConvertToDomainException(() async {
        await _dataSource.removeFromList(
          userId: _requireUserId(),
          list: list,
          movieId: movie.id,
        );
        _changesSubject.add(null);
      });

  @override
  Future<void> refreshSavedMovie(Movie movie) =>
      _catchAndConvertToDomainException(
        () => _dataSource.updateSavedMovie(
          userId: _requireUserId(),
          movie: movie,
        ),
      );

  String _requireUserId() {
    final uid = _authRepository.currentUser?.uid;

    if (uid == null) {
      throw const MovieListsException('Sign in to use your lists');
    }

    return uid;
  }

  Future<T> _catchAndConvertToDomainException<T>(
    Future<T> Function() action,
  ) async {
    try {
      return await action();
    } on DatabaseException {
      throw const MovieListsException('Could not reach your saved lists.');
    }
  }
}
