part of 'package:marquee/shared/navigation/marquee_route.dart';

final class const MovieListsRoute() extends MarqueeRoute {
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) =>
        MovieListsCubit(context.read<MovieListsRepository>())..load(),
    child: const MovieListsScreen(),
  );
}
