import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/utils/movie_display.dart';
import 'package:marquee/search/widgets/search_result_poster.dart';
import 'package:marquee/shared/marquee_theme.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const SearchResultTile({
  required final Movie movie,
  required final bool isWatchlisted,
  required final VoidCallback onTap,
  required final VoidCallback onWatchlistToggled,
  super.key,
}) extends StatelessWidget {
  static const double _posterWidth = 44;
  static const double _posterHeight = 64;

  static const double _actionSize = 34;
  static const double _rowSpacing = 12;
  static const double _captionSpacing = 4;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final metaParts = [
      if (movie.releaseDate case final releaseDate?) '${releaseDate.year}',
      if (movie.runtime case final runtime?) '$runtime MIN',
      '★ ${movie.ratingLabel}',
    ];

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          spacing: _rowSpacing,
          children: [
            SizedBox(
              width: _posterWidth,
              height: _posterHeight,
              child: SearchResultPoster(movie: movie),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: _captionSpacing,
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium,
                  ),
                  Text(
                    metaParts.join(' · ').toUpperCase(),
                    style: MarqueeTypography.meta.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            IconButton.outlined(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                fixedSize: const Size.square(_actionSize),
                foregroundColor: colorScheme.onSurfaceVariant,
                side: BorderSide(color: colorScheme.outline),
              ),
              icon: Icon(isWatchlisted ? Symbols.check : Symbols.add),
              onPressed: onWatchlistToggled,
              tooltip: isWatchlisted
                  ? 'Remove from watchlist'
                  : 'Add to watchlist',
            ),
          ],
        ),
      ),
    );
  }
}
