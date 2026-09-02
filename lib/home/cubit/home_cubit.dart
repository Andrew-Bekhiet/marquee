import 'package:bloc/bloc.dart';
import 'package:marquee/home/cubit/home_state.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/models/movies_exception.dart';
import 'package:marquee/movies/repositories/movies_repository.dart';

class HomeCubit(final MoviesRepository _moviesRepository)
    extends Cubit<HomeState> {
  this : super(const HomeStateLoading());

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

      emit(
        HomeStateLoaded(
          featured: featuredMovieWithDetails,
          popular: popular.results,
          popularTotal: popular.totalResults,
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
}
