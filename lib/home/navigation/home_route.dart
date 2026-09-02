part of 'package:marquee/shared/navigation/marquee_route.dart';

final class const HomeRoute() extends HomeBranchRoute {
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => HomeCubit(
      context.read<MovieListsRepository>(),
      context.read<MoviesRepository>(),
    )..load(),
    child: const HomeScreen(),
  );
}
