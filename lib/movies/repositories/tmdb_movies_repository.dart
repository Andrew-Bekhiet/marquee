import 'package:dio/dio.dart';
import 'package:marquee/movies/api/tmdb_api.dart';
import 'package:marquee/movies/models/credits_response.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/models/movies_exception.dart';
import 'package:marquee/movies/models/movies_response.dart';
import 'package:marquee/movies/repositories/movies_repository.dart';

class TmdbMoviesRepository(final TMDBApi _api) implements MoviesRepository {
  @override
  Future<MoviesResponse> nowPlaying({int page = 1}) =>
      _catchAndConvertToDomainException(() => _api.nowPlaying(page: page));

  @override
  Future<MoviesResponse> popular({int page = 1}) =>
      _catchAndConvertToDomainException(() => _api.popular(page: page));

  @override
  Future<Movie> movieDetails(int id) =>
      _catchAndConvertToDomainException(() => _api.movieDetails(id));

  @override
  Future<CreditsResponse> movieCredits(int id) =>
      _catchAndConvertToDomainException(() => _api.movieCredits(id));

  @override
  Future<MoviesResponse> similarMovies(int id, {int page = 1}) =>
      _catchAndConvertToDomainException(
        () => _api.similarMovies(id, page: page),
      );

  Future<T> _catchAndConvertToDomainException<T>(
    Future<T> Function() action,
  ) async {
    try {
      return await action();
    } on DioException catch (exception) {
      throw MoviesException(
        exception.message ?? 'Failed to reach The Movie Database.',
      );
    }
  }
}
