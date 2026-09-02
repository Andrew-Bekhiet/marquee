import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:marquee/home/cubit/home_state.dart';
import 'package:marquee/lists/models/movie_list.dart';
import 'package:marquee/lists/models/movie_lists_exception.dart';
import 'package:marquee/lists/repositories/movie_lists_repository.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/models/movies_exception.dart';
import 'package:marquee/movies/repositories/movies_repository.dart';

class HomeCubit(
  final MovieListsRepository _movieListsRepository,
  final MoviesRepository _moviesRepository,
) extends Cubit<HomeState> {
  StreamSubscription<void>? _changesSubscription;

  this : super(const HomeStateLoading()) {
    _changesSubscription = _movieListsRepository.changes.listen(
      (_) => _refreshFeaturedFavorite(),
    );
  }

  Future<void> load() async {
    emit(const HomeStateLoading());

    try {
      final (nowPlaying, popular) = await (
        _moviesRepository.nowPlaying(),
        _moviesRepository.popular(),
      ).wait;

      if (nowPlaying.results.isEmpty) {
        emit(
          const HomeStateError(message: 'No movies are playing right now.'),
        );

        return;
      }

      final featuredMovie = nowPlaying.results.first;
      final featuredMovieWithDetails = await _fetchMovieDetails(featuredMovie);
      final isFeaturedFavorite = await _isFavorite(featuredMovieWithDetails);

      emit(
        HomeStateLoaded(
          featured: featuredMovieWithDetails,
          popular: popular.results
              .where((movie) => movie.id != featuredMovieWithDetails.id)
              .toList(),
          popularTotal: popular.totalResults,
          isFeaturedFavorite: isFeaturedFavorite,
        ),
      );
    } on MoviesException catch (exception) {
      emit(HomeStateError(message: exception.message));
    } catch (_) {
      emit(const HomeStateError(message: 'Something went wrong.'));
    }
  }

  Future<Movie> _fetchMovieDetails(Movie featured) async {
    try {
      return await _moviesRepository.movieDetails(featured.id);
    } catch (_) {
      return featured;
    }
  }

  Future<bool> _isFavorite(Movie movie) async {
    try {
      final lists = await _movieListsRepository.getListsContainingMovie(
        movie,
      );

      return lists.contains(MovieList.favorites);
    } on MovieListsException {
      return false;
    }
  }

  Future<void> _refreshFeaturedFavorite() async {
    final currentState = state;
    if (currentState is! HomeStateLoaded) return;

    final isFeaturedFavorite = await _isFavorite(currentState.featured);
    if (isFeaturedFavorite == currentState.isFeaturedFavorite) return;

    emit(currentState.copyWith(isFeaturedFavorite: isFeaturedFavorite));
  }

  Future<void> toggleFavorite(Movie featured) async {
    final currentState = state;
    if (currentState is! HomeStateLoaded) return;

    try {
      if (currentState.isFeaturedFavorite) {
        await _movieListsRepository.removeFromList(
          featured,
          MovieList.favorites,
        );
      } else {
        await _movieListsRepository.addToList(featured, MovieList.favorites);
      }

      emit(
        currentState.copyWith(
          isFeaturedFavorite: !currentState.isFeaturedFavorite,
        ),
      );
    } on MovieListsException catch (exception) {
      emit(HomeStateFlash.fromLoaded(currentState, exception.message));
      emit(currentState);
    }
  }

  @override
  Future<void> close() async {
    await _changesSubscription?.cancel();

    return super.close();
  }
}
