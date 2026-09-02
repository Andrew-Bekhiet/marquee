import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaisel/kaisel.dart';
import 'package:marquee/movies/cubit/movie_details_cubit.dart';
import 'package:marquee/movies/cubit/movie_details_state.dart';
import 'package:marquee/movies/widgets/movie_cast_avatar.dart';
import 'package:marquee/movies/widgets/movie_details_section.dart';
import 'package:marquee/movies/widgets/movie_empty_state.dart';
import 'package:marquee/movies/widgets/movie_genre_chips.dart';
import 'package:marquee/movies/widgets/movie_list_actions.dart';
import 'package:marquee/movies/widgets/movie_overview.dart';
import 'package:marquee/movies/widgets/similar_movies_row.dart';
import 'package:marquee/shared/navigation/marquee_route.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const MovieDetailsBody({
  required final MovieDetailsLoaded state,
  required final VoidCallback onRetry,
  super.key,
}) extends StatelessWidget {
  static const EdgeInsetsDirectional _padding = EdgeInsetsDirectional.only(
    start: 16,
    end: 16,
    bottom: 24,
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);
    final genres = state.movie.genres ?? const [];

    final cubit = context.read<MovieDetailsCubit>();

    return SliverPadding(
      padding: _padding,
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 18,
          children: [
            MovieListActions(
              containedInLists: state.containedInLists,
              onWantToWatch: cubit.onWantToWatch,
              onAddToWatched: cubit.onAddToWatched,
              onAddToWatching: cubit.onAddToWatching,
            ),
            if (genres.isNotEmpty) MovieGenreChips(genres: genres),
            MovieDetailsSection(
              label: 'OVERVIEW',
              child: state.movie.overview.isNotEmpty
                  ? MovieOverview(overview: state.movie.overview)
                  : const MovieEmptyState(
                      icon: Symbols.notes,
                      message: 'No overview yet.',
                    ),
            ),
            MovieDetailsSection(
              label: 'CAST',
              child: state.cast.isNotEmpty
                  ? SizedBox(
                      height: 96,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.cast.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (_, index) =>
                            MovieCastAvatar(member: state.cast[index]),
                      ),
                    )
                  : const MovieEmptyState(
                      icon: Symbols.person_off,
                      message: 'No cast listed.',
                    ),
            ),
            MovieDetailsSection(
              label: 'SIMILAR',
              child: state.similar.isNotEmpty
                  ? SimilarMoviesRow(
                      movies: state.similar,
                      onMovieTap: (movie) =>
                          context.push(MovieDetailsRoute(movie)),
                    )
                  : const MovieEmptyState(
                      icon: Symbols.movie_off,
                      message: 'Nothing similar found.',
                    ),
            ),
            if (state.hasPartialFailure)
              Row(
                spacing: 9,
                children: [
                  Expanded(
                    child: Text(
                      "Some sections couldn't be loaded.",
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  TextButton(onPressed: onRetry, child: const Text('Retry')),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
