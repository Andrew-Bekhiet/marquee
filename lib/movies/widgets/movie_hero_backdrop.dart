import 'package:cached_network_image/cached_network_image.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/utils/movie_display.dart';
import 'package:marquee/movies/widgets/movie_poster_fallback.dart';
import 'package:material_ui/material_ui.dart';

class const MovieHeroBackdrop({required final Movie movie, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final backdropUrl = movie.backdropUrl();
    final fallback = MoviePosterFallback(
      code: movie.posterCode,
      fontSize: 28,
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        if (backdropUrl == null)
          fallback
        else
          CachedNetworkImage(
            imageUrl: backdropUrl,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 300),
            errorWidget: (_, _, _) => fallback,
            placeholder: (_, __) => fallback,
          ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.4, 1],
              colors: [
                colorScheme.surface.withValues(alpha: 0.35),
                colorScheme.surface.withValues(alpha: 0.1),
                colorScheme.surface,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
