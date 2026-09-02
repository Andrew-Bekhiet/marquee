import 'package:intl/intl.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/utils/movie_display.dart';
import 'package:marquee/shared/marquee_theme.dart';
import 'package:material_ui/material_ui.dart';

class const MovieRatingPill({required final Movie movie, super.key})
    extends StatelessWidget {
  static final NumberFormat _compactNumberFormat = NumberFormat.compact();

  static const EdgeInsetsDirectional _padding = EdgeInsetsDirectional.symmetric(
    vertical: 7,
    horizontal: 12,
  );
  static const BorderRadius _radius = BorderRadius.all(Radius.circular(9));
  static const double _scrimAlpha = 0.55;
  static const double _starSize = 13;
  static const double _ratingSize = 17;
  static const double _rowSpacing = 7;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: _radius,
        color: colorScheme.scrim.withValues(alpha: _scrimAlpha),
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: _rowSpacing,
          children: [
            Text(
              '★',
              style: TextStyle(fontSize: _starSize, color: colorScheme.primary),
            ),
            Text(
              movie.ratingLabel,
              style: MarqueeTypography.posterCode(
                fontSize: _ratingSize,
              ).copyWith(color: colorScheme.onSurface),
            ),
            Text(
              '/10 · ${_compactNumberFormat.format(movie.voteCount)}',
              style: MarqueeTypography.meta.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
