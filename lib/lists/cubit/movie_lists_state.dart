import 'package:equatable/equatable.dart';
import 'package:marquee/lists/models/movie_list.dart';
import 'package:marquee/movies/models/movie.dart';

sealed class const MovieListsState({required final MovieList selectedList})
    with Equatable {
  @override
  List<Object?> get props => [selectedList];
}

final class const MovieListsLoading({required super.selectedList})
    extends MovieListsState;

final class const MovieListsLoaded({
  required super.selectedList,
  required final List<Movie> movies,
}) extends MovieListsState {
  @override
  List<Object?> get props => [selectedList, movies];
}

final class const MovieListsError({
  required super.selectedList,
  required final String message,
}) extends MovieListsState {
  @override
  List<Object?> get props => [selectedList, message];
}
