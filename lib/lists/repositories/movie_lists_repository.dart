import 'package:marquee/lists/models/movie_list.dart';
import 'package:marquee/movies/models/movie.dart';

abstract class const MovieListsRepository() {
  Stream<void> get changes;

  Future<List<Movie>> getMoviesInList(MovieList list);

  Future<Set<MovieList>> getListsContainingMovie(Movie movie);

  Future<void> addToList(
    Movie movie,
    MovieList list, {
    Set<MovieList> removeFrom = const {},
  });

  Future<void> removeFromList(Movie movie, MovieList list);

  Future<void> refreshSavedMovie(Movie movie);
}
