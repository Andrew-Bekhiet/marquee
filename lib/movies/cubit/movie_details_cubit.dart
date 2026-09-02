import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:marquee/lists/models/movie_list.dart';
import 'package:marquee/lists/models/movie_lists_exception.dart';
import 'package:marquee/lists/repositories/movie_lists_repository.dart';
import 'package:marquee/movies/cubit/movie_details_state.dart';
import 'package:marquee/movies/models/cast_member.dart';
import 'package:marquee/movies/models/credits_response.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/models/movies_exception.dart';
import 'package:marquee/movies/repositories/movies_repository.dart';
import 'package:share_plus/share_plus.dart';

class MovieDetailsCubit(
  final MoviesRepository _moviesRepository,
  final MovieListsRepository _movieListsRepository,
  Movie initialMovie,
) extends Cubit<MovieDetailsState> {
  this : super(MovieDetailsLoading(movie: initialMovie));

  Future<void> load() async {
    emit(MovieDetailsLoading(movie: state.movie));

    try {
      final movieId = state.movie.id;

      bool hasPartialFailure = false;

      List<CastMember> cast;
      try {
        cast = _sortCast(await _moviesRepository.movieCredits(movieId));
      } on MoviesException {
        hasPartialFailure = true;
        cast = const [];
      }

      List<Movie> similarMovies;
      try {
        similarMovies = (await _moviesRepository.similarMovies(movieId)).results
            .where((movie) => movie.id != movieId)
            .toList();
      } on MoviesException {
        hasPartialFailure = true;
        similarMovies = const [];
      }

      final movieDetails = await _moviesRepository.movieDetails(movieId);

      await _movieListsRepository
          .refreshSavedMovie(movieDetails)
          .onError<MovieListsException>((_, _) => null);

      final containedInLists = await _movieListsRepository
          .getListsContainingMovie(movieDetails);

      emit(
        MovieDetailsLoaded(
          movie: movieDetails,
          cast: cast,
          similar: similarMovies,
          containedInLists: containedInLists,
          hasPartialFailure: hasPartialFailure,
        ),
      );
    } on MoviesException catch (exception) {
      emit(MovieDetailsError(movie: state.movie, message: exception.message));
    }
  }

  Future<void> toggleFavorite() => _onToggleAddToList(MovieList.favorites);

  void onShare() {
    final currentState = state;
    if (currentState is! MovieDetailsLoaded) return;

    SharePlus.instance.share(
      ShareParams(
        subject: currentState.movie.title,
        uri: Uri.parse(
          'https://www.themoviedb.org/movie/${currentState.movie.id}',
        ),
      ),
    );
  }

  List<CastMember> _sortCast(CreditsResponse credits) =>
      credits.cast.sorted((a, b) => a.order.compareTo(b.order)).toList();

  Future<void> onWantToWatch() => _onToggleAddToList(MovieList.watchlist);

  Future<void> onAddToWatched() => _onToggleAddToList(MovieList.watched);

  Future<void> onAddToWatching() => _onToggleAddToList(MovieList.watching);

  Future<void> _onToggleAddToList(MovieList list) async {
    final currentState = state;
    if (currentState is! MovieDetailsLoaded) return;

    final isContained = currentState.containedInLists.contains(list);

    try {
      if (isContained) {
        await _movieListsRepository.removeFromList(currentState.movie, list);
      } else {
        await _movieListsRepository.addToList(
          currentState.movie,
          list,
          removeFrom: list.exclusiveWithLists,
        );
      }

      final containedInLists = isContained
          ? currentState.containedInLists.difference({list})
          : currentState.containedInLists
                .union({list})
                .difference(list.exclusiveWithLists);

      emit(
        MovieDetailsLoaded(
          movie: currentState.movie,
          cast: currentState.cast,
          similar: currentState.similar,
          containedInLists: containedInLists,
          hasPartialFailure: currentState.hasPartialFailure,
        ),
      );
    } on MovieListsException catch (exception) {
      emit(
        MovieDetailsError(
          movie: currentState.movie,
          message: exception.message,
        ),
      );
    }
  }
}
