part of 'package:marquee/shared/navigation/marquee_route.dart';

final class MovieDetailsRoute(final Movie movie) extends MarqueeRoute {
  @override
  List<Object?> get props => [movie.id];

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => MovieDetailsCubit(
      context.read<MoviesRepository>(),
      context.read<MovieListsRepository>(),
      movie,
    )..load(),
    child: const MovieDetailsScreen(),
  );
}
