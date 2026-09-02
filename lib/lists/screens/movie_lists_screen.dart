import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaisel/kaisel.dart';
import 'package:marquee/home/widgets/movies_grid.dart';
import 'package:marquee/lists/cubit/movie_lists_cubit.dart';
import 'package:marquee/lists/cubit/movie_lists_state.dart';
import 'package:marquee/lists/models/movie_list.dart';
import 'package:marquee/movies/widgets/movie_empty_state.dart';
import 'package:marquee/shared/navigation/marquee_route.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const MovieListsScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MovieListsCubit>();
    final state = cubit.state;

    return Scaffold(
      appBar: AppBar(title: const Text('Your lists'), centerTitle: false),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Row(
              spacing: 8,
              children: [
                for (final list in MovieList.values)
                  ChoiceChip(
                    label: Text(list.label),
                    selected: list == state.selectedList,
                    onSelected: (_) => cubit.onListSelected(list),
                  ),
              ],
            ),
          ),
          Expanded(
            child: switch (state) {
              MovieListsLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              MovieListsError(:final message) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 12,
                  children: [
                    Text(message),
                    FilledButton(
                      onPressed: cubit.load,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              MovieListsLoaded(:final movies) when movies.isEmpty =>
                MovieEmptyState(
                  icon: Symbols.bookmark,
                  message: 'No movies in ${state.selectedList.label} yet.',
                ),
              MovieListsLoaded(:final movies) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MoviesGrid(
                  movies: movies,
                  onMovieTap: (movie) => context.push(MovieDetailsRoute(movie)),
                ),
              ),
            },
          ),
        ],
      ),
    );
  }
}
