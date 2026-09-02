import 'package:marquee/lists/models/movie_list.dart';
import 'package:marquee/movies/models/movie.dart';

abstract class const MovieListsDataSource() {
  Future<List<Movie>> moviesInList({
    required String userId,
    required MovieList list,
  });

  Future<Set<MovieList>> listsContainingMovie({
    required String userId,
    required int movieId,
  });

  Future<void> addToList({
    required String userId,
    required MovieList list,
    required Movie movie,
  });

  Future<void> removeFromList({
    required String userId,
    required MovieList list,
    required int movieId,
  });

  Future<void> updateSavedMovie({required String userId, required Movie movie});
}
