import 'package:marquee/home/utils/movie_display.dart';
import 'package:marquee/home/widgets/favorite_button.dart';
import 'package:marquee/home/widgets/movie_card.dart';
import 'package:marquee/home/widgets/movie_card_size.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/shared/marquee_theme.dart';
import 'package:material_ui/material_ui.dart';

class const FeaturedMovieWidget({
  required final Movie movie,
  required final VoidCallback onDetails,
  required final VoidCallback onFavorite,
  super.key,
}) extends StatelessWidget {
  static const double _metaLineHeight = 1.7;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final metaStyle = MarqueeTypography.meta.copyWith(
      height: _metaLineHeight,
      color: colorScheme.onSurfaceVariant,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 14,
      children: [
        MovieCard(movie: movie, size: MovieCardSize.big),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 9,
            children: [
              Text(
                '#1 NOW PLAYING',
                style: MarqueeTypography.eyebrow.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleLarge,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${movie.releaseDate?.year ?? ''}',
                    style: metaStyle,
                  ),
                  if (movie.runtime case final runtime?)
                    Text('$runtime MIN', style: metaStyle),
                  Text('★ ${movie.ratingLabel} / 10', style: metaStyle),
                ],
              ),
              Row(
                spacing: 7,
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: onDetails,
                      child: const Text('Details'),
                    ),
                  ),
                  FavoriteButton(
                    onFavorite: onFavorite,
                    isFavorite: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
