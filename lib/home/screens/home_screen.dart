import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kaisel/kaisel.dart';
import 'package:marquee/auth/cubit/authentication_cubit.dart';
import 'package:marquee/home/cubit/home_cubit.dart';
import 'package:marquee/home/cubit/home_state.dart';
import 'package:marquee/home/widgets/featured_movie_widget.dart';
import 'package:marquee/home/widgets/home_header.dart';
import 'package:marquee/home/widgets/home_navigation_bar.dart';
import 'package:marquee/home/widgets/movies_grid.dart';
import 'package:marquee/shared/marquee_theme.dart';
import 'package:marquee/shared/navigation/marquee_route.dart';
import 'package:material_ui/material_ui.dart';

class const HomeScreen({super.key}) extends StatelessWidget {
  static final _shortDateFormat = DateFormat('EEE d MMM');
  static final _compactNumberFormat = NumberFormat.compact();

  static void _noDestinationYet() {
    // TODO: wire up when a destination screen exists.
  }
  static void _onDestinationChanged(int _) {
    // TODO: wire up the other nav destinations.
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final cubit = context.watch<HomeCubit>();
    final state = cubit.state;

    return Scaffold(
      appBar: switch (state) {
        HomeStateLoading() || HomeStateError() => null,
        HomeStateLoaded() => HomeHeader(
          dateLabel: _shortDateFormat.format(DateTime.now()).toUpperCase(),
          onSearch: _noDestinationYet,
          onSignOut: context.read<AuthenticationCubit>().logout,
        ),
      },
      body: switch (state) {
        HomeStateLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
        HomeStateError(:final message) => Center(
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
        HomeStateLoaded(
          :final featured,
          :final popular,
          :final popularTotal,
        ) =>
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              FeaturedMovieWidget(
                movie: featured,
                onDetails: () => context.push(MovieDetailsRoute(featured)),
                onFavorite: _noDestinationYet,
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular this week',
                    style: textTheme.titleMedium,
                  ),
                  Text(
                    '${_compactNumberFormat.format(popularTotal)}'
                            ' TITLES'
                        .toUpperCase(),
                    style: MarqueeTypography.meta.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              MoviesGrid(
                movies: popular,
                onMovieTap: (movie) => context.push(MovieDetailsRoute(movie)),
              ),
              const SizedBox(height: 20),
            ],
          ),
      },
      // TODO: refactor to use kaisel shell route
      bottomNavigationBar: const HomeNavigationBar(
        selectedIndex: 0,
        onDestinationSelected: _onDestinationChanged,
      ),
    );
  }
}
