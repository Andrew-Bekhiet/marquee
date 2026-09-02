import 'package:dio/dio.dart';
import 'package:marquee/movies/models/credits_response.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/models/movies_response.dart';
import 'package:retrofit/retrofit.dart';

part 'tmdb_api.g.dart';

@RestApi()
abstract class TMDBApi {
  static const String _tmdbAccessToken = String.fromEnvironment(
    'TMDB_ACCESS_TOKEN',
  );

  static final _defaultDioClient = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      headers: {
        'Authorization': 'Bearer $_tmdbAccessToken',
        'Accept': 'application/json',
      },
    ),
  );

  factory({Dio? dioClient, String? baseUrl}) =>
      _TMDBApi(dioClient ?? _defaultDioClient, baseUrl: baseUrl);

  @GET('/movie/now_playing')
  Future<MoviesResponse> nowPlaying({@Query('page') int page = 1});

  @GET('/movie/popular')
  Future<MoviesResponse> popular({@Query('page') int page = 1});

  @GET('/movie/{id}')
  Future<Movie> movieDetails(@Path('id') int id);

  @GET('/movie/{id}/credits')
  Future<CreditsResponse> movieCredits(@Path('id') int id);

  @GET('/movie/{id}/similar')
  Future<MoviesResponse> similarMovies(
    @Path('id') int id, {
    @Query('page') int page = 1,
  });

  @GET('/search/movie')
  Future<MoviesResponse> searchMovies(
    @Query('query') String query, {
    @Query('page') int page = 1,
  });
}
