import 'package:cached_network_image/cached_network_image.dart';
import 'package:marquee/home/utils/movie_display.dart';
import 'package:marquee/home/widgets/movie_card_size.dart';
import 'package:marquee/home/widgets/movie_poster_fallback.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:material_ui/material_ui.dart';

class const MoviePosterImage({
  required final Movie movie,
  final MovieCardSize size = MovieCardSize.medium,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    final posterUrl = movie.posterUrl();
    final fallback = MoviePosterFallback(
      code: movie.posterCode,
      fontSize: size.codeFontSize,
    );

    return ClipRRect(
      borderRadius: size.posterRadius,
      child: AspectRatio(
        aspectRatio: MovieCardSize.posterAspectRatio,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (posterUrl == null)
              fallback
            else
              CachedNetworkImage(
                imageUrl: posterUrl,
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
                  colors: [
                    colorScheme.scrim.withValues(alpha: 0),
                    colorScheme.scrim.withValues(alpha: 0.54),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
