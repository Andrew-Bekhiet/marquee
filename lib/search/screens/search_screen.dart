import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaisel/kaisel.dart';
import 'package:marquee/movies/widgets/movie_empty_state.dart';
import 'package:marquee/search/cubit/search_cubit.dart';
import 'package:marquee/search/cubit/search_state.dart';
import 'package:marquee/search/widgets/search_app_bar.dart';
import 'package:marquee/search/widgets/search_result_tile.dart';
import 'package:marquee/shared/marquee_theme.dart';
import 'package:marquee/shared/navigation/marquee_route.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const SearchScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SearchCubit>();
    final state = cubit.state;
    final colorScheme = ColorScheme.of(context);

    return Scaffold(
      appBar: SearchAppBar(
        initialQuery: state.query,
        onQueryChanged: cubit.onQueryChanged,
        onSubmitted: cubit.search,
      ),
      body: switch (state) {
        SearchIdle() => const MovieEmptyState(
          icon: Symbols.search,
          message: 'Search for a film by title.',
        ),
        SearchLoading() => const Center(child: CircularProgressIndicator()),
        SearchError(:final message) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              Text(message),
              FilledButton(
                onPressed: () => cubit.search(state.query),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        SearchResults(:final movies) when movies.isEmpty => MovieEmptyState(
          icon: Symbols.search_off,
          message: 'No films match "${state.query}".',
        ),
        SearchResults(:final movies, :final watchlistedIds) => Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 16,
                top: 6,
                end: 16,
                bottom: 10,
              ),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  '${movies.length} RESULTS',
                  style: MarqueeTypography.meta.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: movies.length,
                itemBuilder: (itemContext, index) {
                  final movie = movies[index];

                  return SearchResultTile(
                    movie: movie,
                    isWatchlisted: watchlistedIds.contains(movie.id),
                    onTap: () => itemContext.push(MovieDetailsRoute(movie)),
                    onWatchlistToggled: () => cubit.onAddToWatchlist(movie),
                  );
                },
              ),
            ),
          ],
        ),
      },
    );
  }
}
