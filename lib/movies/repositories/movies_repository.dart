import 'package:marquee/movies/models/credits_response.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/models/movies_response.dart';

abstract class const MoviesRepository() {
  Future<MoviesResponse> nowPlaying({int page = 1});

  Future<MoviesResponse> popular({int page = 1});

  Future<Movie> movieDetails(int id);

  Future<CreditsResponse> movieCredits(int id);

  Future<MoviesResponse> similarMovies(int id, {int page = 1});

  Future<MoviesResponse> searchMovies(String query, {int page = 1});
}
