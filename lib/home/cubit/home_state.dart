import 'package:equatable/equatable.dart';
import 'package:marquee/movies/models/movie.dart';

sealed class const HomeState() with Equatable {
  @override
  List<Object?> get props => [];
}

final class const HomeStateLoading() extends HomeState;

final class const HomeStateLoaded({
  required final Movie featured,
  required final List<Movie> popular,
  required final int popularTotal,
}) extends HomeState {
  @override
  List<Object?> get props => [featured, popular, popularTotal];
}

final class const HomeStateError({required final String message})
    extends HomeState {
  @override
  List<Object?> get props => [message];
}
