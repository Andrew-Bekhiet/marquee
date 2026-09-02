import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:marquee/lists/models/movie_list.dart';
import 'package:marquee/lists/models/movie_lists_exception.dart';
import 'package:marquee/lists/repositories/movie_lists_repository.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/models/movies_exception.dart';
import 'package:marquee/movies/repositories/movies_repository.dart';
import 'package:marquee/search/cubit/search_state.dart';

class SearchCubit(
  final MoviesRepository _moviesRepository,
  final MovieListsRepository _movieListsRepository,
) extends Cubit<SearchState> {
  static const Duration _debounceDelay = Duration(milliseconds: 350);

  Timer? _debounce;

  int _latestRequest = 0;

  this : super(const SearchIdle());

  void onQueryChanged(String query) {
    _debounce?.cancel();

    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      _latestRequest++;
      emit(SearchIdle(query: query));

      return;
    }

    emit(SearchLoading(query: query));
    _debounce = Timer(_debounceDelay, () => search(query));
  }

  Future<void> search(String query) async {
    _debounce?.cancel();

    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      _latestRequest++;
      emit(SearchIdle(query: query));

      return;
    }

    final request = ++_latestRequest;

    emit(SearchLoading(query: query));

    try {
      final results = await _moviesRepository.searchMovies(trimmed);
      final watchlistedIds = await _watchlistedIdsFor(results.results);
      if (request != _latestRequest) return;

      emit(
        SearchResults(
          query: query,
          movies: results.results,
          watchlistedIds: watchlistedIds,
        ),
      );
    } on MoviesException catch (exception) {
      if (request != _latestRequest) return;

      emit(SearchError(query: query, message: exception.message));
    }
  }

  Future<void> onAddToWatchlist(Movie movie) async {
    final currentState = state;
    if (currentState is! SearchResults) return;

    final isWatchlisted = currentState.watchlistedIds.contains(movie.id);

    try {
      if (isWatchlisted) {
        await _movieListsRepository.removeFromList(
          movie,
          MovieList.watchlist,
        );
      } else {
        await _movieListsRepository.addToList(movie, MovieList.watchlist);
      }

      final watchlistedIds = isWatchlisted
          ? currentState.watchlistedIds.difference({movie.id})
          : currentState.watchlistedIds.union({movie.id});

      emit(
        SearchResults(
          query: currentState.query,
          movies: currentState.movies,
          watchlistedIds: watchlistedIds,
        ),
      );
    } on MovieListsException catch (exception) {
      emit(
        SearchError(query: currentState.query, message: exception.message),
      );
    }
  }

  Future<Set<int>> _watchlistedIdsFor(List<Movie> movies) async {
    try {
      final watchlist = await _movieListsRepository.getMoviesInList(
        MovieList.watchlist,
      );

      return watchlist
          .map((movie) => movie.id)
          .toSet()
          .intersection(
            movies.map((movie) => movie.id).toSet(),
          );
    } on MovieListsException {
      return const {};
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();

    return super.close();
  }
}
