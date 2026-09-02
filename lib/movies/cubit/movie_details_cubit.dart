import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:marquee/movies/cubit/movie_details_state.dart';
import 'package:marquee/movies/models/cast_member.dart';
import 'package:marquee/movies/models/credits_response.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/models/movies_exception.dart';
import 'package:marquee/movies/repositories/movies_repository.dart';
import 'package:share_plus/share_plus.dart';

class MovieDetailsCubit(
  final MoviesRepository _moviesRepository,
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
        similarMovies = (await _moviesRepository.similarMovies(movieId))
            .results;
      } on MoviesException {
        hasPartialFailure = true;
        similarMovies = const [];
      }

      final movieDetails = await _moviesRepository.movieDetails(movieId);

      final previousState = state;
      final isFavorite =
          previousState is MovieDetailsLoaded && previousState.isFavorite;

      emit(
        MovieDetailsLoaded(
          movie: movieDetails,
          cast: cast,
          similar: similarMovies,
          isFavorite: isFavorite,
          hasPartialFailure: hasPartialFailure,
        ),
      );
    } on MoviesException catch (exception) {
      emit(MovieDetailsError(movie: state.movie, message: exception.message));
    }
  }

  void toggleFavorite() {
    final currentState = state;
    if (currentState is! MovieDetailsLoaded) return;

    emit(
      MovieDetailsLoaded(
        movie: currentState.movie,
        cast: currentState.cast,
        similar: currentState.similar,
        isFavorite: !currentState.isFavorite,
        hasPartialFailure: currentState.hasPartialFailure,
      ),
    );
  }

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

  void onWantToWatch() {
    // TODO: implement adding to list
  }

  void onAddToWatched() {
    // TODO: implement adding to list
  }

  void onAddToWatching() {
    // TODO: implement adding to list
  }
}
