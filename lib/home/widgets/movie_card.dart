import 'package:marquee/home/utils/movie_display.dart';
import 'package:marquee/home/widgets/movie_card_size.dart';
import 'package:marquee/home/widgets/movie_poster_image.dart';
import 'package:marquee/movies/models/movie.dart';
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

    final runtime = movie.runtimeLabel;
    final text = runtime.isEmpty
        ? '★ ${movie.ratingLabel}'
        : '★ ${movie.ratingLabel} · $runtime';

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
          const SizedBox(height: 6),
          Text(
            text,
            style: MarqueeTypography.meta.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
