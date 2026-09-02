import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/utils/movie_display.dart';
import 'package:marquee/movies/widgets/movie_card_size.dart';
import 'package:marquee/movies/widgets/movie_poster_image.dart';
import 'package:marquee/shared/marquee_theme.dart';
import 'package:material_ui/material_ui.dart';

class const MovieCard({
  required final Movie movie,
  final MovieCardSize size = MovieCardSize.medium,
  final VoidCallback? onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posterImage = onTap == null
        ? MoviePosterImage(movie: movie, size: size)
        : InkWell(
            borderRadius: size.posterRadius,
            onTap: onTap,
            child: MoviePosterImage(movie: movie, size: size),
          );

    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    if (!size.showsCaption) {
      return SizedBox(width: size.posterWidth, child: posterImage);
    }

    final ratingText = switch (movie.runtimeLabel) {
      '' => '★ ${movie.ratingLabel}',
      _ => '★ ${movie.ratingLabel} · ${movie.runtimeLabel}',
    };

    return SizedBox(
      width: size.posterWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          posterImage,
          const SizedBox(height: 6),
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelLarge,
          ),
          if (size.showsRating) ...[
            const SizedBox(height: 6),
            Text(
              ratingText,
              style: MarqueeTypography.meta.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
