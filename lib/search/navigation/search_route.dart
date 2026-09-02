part of 'package:marquee/shared/navigation/marquee_route.dart';

final class const SearchRoute() extends MarqueeRoute {
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => SearchCubit(
      context.read<MoviesRepository>(),
      context.read<MovieListsRepository>(),
    ),
    child: const SearchScreen(),
  );
}
