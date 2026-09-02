import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/models/movies_response.dart';

abstract class const MoviesRepository() {
  Future<MoviesResponse> nowPlaying({int page = 1});

  Future<MoviesResponse> popular({int page = 1});

  Future<Movie> movieDetails(int id);
}
