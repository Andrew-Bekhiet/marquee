import 'package:cached_network_image/cached_network_image.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/utils/movie_display.dart';
import 'package:marquee/shared/marquee_theme.dart';
import 'package:material_ui/material_ui.dart';

class const SearchResultPoster({
  required final Movie movie,
  super.key,
}) extends StatelessWidget {
  static const double _codeInset = 4;
  static const double _codeFontSize = 9;
  static const int _posterImageWidth = 185;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final posterUrl = movie.posterUrl(width: _posterImageWidth);
    final fallback = ColoredBox(color: colorScheme.surfaceContainerHigh);

    return ClipRRect(
      borderRadius: MarqueeTheme.thumbnailRadius,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (posterUrl == null)
            fallback
          else
            CachedNetworkImage(
              imageUrl: posterUrl,
              fit: BoxFit.cover,
              errorWidget: (_, _, _) => fallback,
              placeholder: (_, _) => fallback,
            ),
          PositionedDirectional(
            start: _codeInset,
            bottom: _codeInset,
            child: Text(
              movie.posterCode,
              style: MarqueeTypography.posterCode(
                fontSize: _codeFontSize,
              ).copyWith(color: colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}
