import 'package:equatable/equatable.dart';
import 'package:marquee/movies/models/movie.dart';

sealed class const SearchState({required final String query}) with Equatable {
  @override
  List<Object?> get props => [query];
}

final class const SearchIdle({super.query = ''}) extends SearchState;

final class const SearchLoading({required super.query}) extends SearchState;

final class const SearchResults({
  required super.query,
  required final List<Movie> movies,
  final Set<int> watchlistedIds = const {},
}) extends SearchState {
  @override
  List<Object?> get props => [query, movies, watchlistedIds];
}

final class const SearchError({
  required super.query,
  required final String message,
}) extends SearchState {
  @override
  List<Object?> get props => [query, message];
}
