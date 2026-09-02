import 'package:equatable/equatable.dart';
import 'package:marquee/movies/models/cast_member.dart';
import 'package:marquee/movies/models/movie.dart';

sealed class const MovieDetailsState({required final Movie movie})
    with Equatable {
  @override
  List<Object?> get props => [movie];
}

final class const MovieDetailsLoading({required super.movie})
    extends MovieDetailsState;

final class const MovieDetailsLoaded({
  required super.movie,
  final List<CastMember> cast = const [],
  final List<Movie> similar = const [],
  final bool isFavorite = false,
  final bool hasPartialFailure = false,
}) extends MovieDetailsState {
  @override
  List<Object?> get props => [
    movie,
    cast,
    similar,
    isFavorite,
    hasPartialFailure,
  ];
}

final class const MovieDetailsError({
  required super.movie,
  required final String message,
}) extends MovieDetailsState {
  @override
  List<Object?> get props => [movie, message];
}
