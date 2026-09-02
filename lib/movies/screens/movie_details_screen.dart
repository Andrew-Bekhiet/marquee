import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/movies/cubit/movie_details_cubit.dart';
import 'package:marquee/movies/cubit/movie_details_state.dart';
import 'package:marquee/movies/widgets/movie_details_app_bar.dart';
import 'package:marquee/movies/widgets/movie_details_body.dart';
import 'package:material_ui/material_ui.dart';

class const MovieDetailsScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MovieDetailsCubit>();
    final state = cubit.state;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MovieDetailsAppBar(
            movie: state.movie,
            isFavorite: switch (state) {
              MovieDetailsLoaded(:final isFavorite) => isFavorite,
              _ => false,
            },
            onFavorite: cubit.toggleFavorite,
            onShare: cubit.onShare,
          ),
          switch (state) {
            MovieDetailsLoading() => const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: CircularProgressIndicator()),
            ),
            MovieDetailsError(:final message) => SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
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
            ),
            MovieDetailsLoaded() => MovieDetailsBody(
              state: state,
              onRetry: cubit.load,
            ),
          },
          if (state is MovieDetailsLoaded)
            const SliverToBoxAdapter(
              child: SizedBox(height: 300),
            ),
        ],
      ),
    );
  }
}
