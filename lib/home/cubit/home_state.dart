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
  final bool isFeaturedFavorite = false,
}) extends HomeState {
  @override
  List<Object?> get props => [
    featured,
    popular,
    popularTotal,
    isFeaturedFavorite,
  ];

  HomeStateLoaded copyWith({
    Movie? featured,
    List<Movie>? popular,
    int? popularTotal,
    bool? isFeaturedFavorite,
  }) => HomeStateLoaded(
    featured: featured ?? this.featured,
    popular: popular ?? this.popular,
    popularTotal: popularTotal ?? this.popularTotal,
    isFeaturedFavorite: isFeaturedFavorite ?? this.isFeaturedFavorite,
  );
}

final class const HomeStateFlash({
  required super.featured,
  required super.popular,
  required super.popularTotal,
  required final String message,
  super.isFeaturedFavorite,
}) extends HomeStateLoaded {
  @override
  List<Object?> get props => [
    featured,
    popular,
    popularTotal,
    isFeaturedFavorite,
    message,
  ];

  factory fromLoaded(HomeStateLoaded state, String message) => HomeStateFlash(
    featured: state.featured,
    popular: state.popular,
    popularTotal: state.popularTotal,
    isFeaturedFavorite: state.isFeaturedFavorite,
    message: message,
  );
}

final class const HomeStateError({required final String message})
    extends HomeState {
  @override
  List<Object?> get props => [message];
}
