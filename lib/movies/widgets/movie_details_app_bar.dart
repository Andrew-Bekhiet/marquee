import 'package:boxy/boxy.dart';
import 'package:marquee/home/widgets/circle_icon_button.dart';
import 'package:marquee/home/widgets/favorite_button.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/utils/movie_display.dart';
import 'package:marquee/movies/widgets/movie_app_bar_boxy.dart';
import 'package:marquee/movies/widgets/movie_card_size.dart';
import 'package:marquee/movies/widgets/movie_hero_backdrop.dart';
import 'package:marquee/movies/widgets/movie_poster_image.dart';
import 'package:marquee/movies/widgets/movie_rating_pill.dart';
import 'package:marquee/shared/marquee_theme.dart';
import 'package:marquee/shared/widgets/marquee_back_button.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const MovieDetailsAppBar({
  required final Movie movie,
  required final bool isFavorite,
  required final VoidCallback onFavorite,
  required final VoidCallback onShare,
  super.key,
}) extends StatelessWidget {
  static const double expandedHeight = 360;

  @override
  Widget build(BuildContext context) => SliverAppBar(
    pinned: true,
    expandedHeight: expandedHeight,
    automaticallyImplyLeading: false,
    backgroundColor: ColorScheme.of(context).surface,
    flexibleSpace: ClipRect(
      child: MovieDetailsAppBarContent(
        movie: movie,
        isFavorite: isFavorite,
        onFavorite: onFavorite,
        onShare: onShare,
      ),
    ),
  );
}

class const MovieDetailsAppBarContent({
  required final Movie movie,
  required final bool isFavorite,
  required final VoidCallback onFavorite,
  final VoidCallback? onShare,
  super.key,
}) extends StatelessWidget {
  static const double _scrimAlpha = 0.45;
  static const double _posterRadius = 12;
  static const double _posterBorderWidth = 2;
  static const double _metaLetterSpacing = 0.5;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    final expansionPercentage = _expansionPercentageOf(context);
    final foregroundColor =
        Color.lerp(
          colorScheme.onSurface,
          colorScheme.onPrimary,
          MovieAppBarBoxy.getTintPercentage(expansionPercentage),
        ) ??
        colorScheme.onSurface;

    final iconButtonStyle = CircleIconButton.defaultButtonStyle.copyWith(
      backgroundColor: WidgetStatePropertyAll(
        colorScheme.scrim.withValues(alpha: _scrimAlpha),
      ),
    );

    final titleStyle = textTheme.titleLarge?.copyWith(color: foregroundColor);
    final titleText = Text(
      movie.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: titleStyle,
    );

    final metaParts = [
      if (movie.releaseDate case final releaseDate?) '${releaseDate.year}',
      if (movie.runtime case final runtime?) '$runtime MIN',
    ];

    return CustomBoxy(
      delegate: MovieAppBarBoxy(
        expansionPercentage: expansionPercentage,
        topPadding: MediaQuery.paddingOf(context).top,
        textDirection: Directionality.of(context),
        titleScale: _titleTextSizeScale(textTheme),
      ),
      children: [
        BoxyId(
          id: MovieAppBarSlot.backdrop,
          child: MovieHeroBackdrop(movie: movie),
        ),
        BoxyId(
          id: MovieAppBarSlot.tint,
          child: ColoredBox(color: colorScheme.primary),
        ),
        BoxyId(
          id: MovieAppBarSlot.poster,
          child: Hero(
            tag: movie.posterHeroTag,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_posterRadius),
                border: Border.all(
                  color: colorScheme.surface,
                  width: _posterBorderWidth,
                ),
              ),
              child: MoviePosterImage(movie: movie, size: MovieCardSize.big),
            ),
          ),
        ),
        BoxyId(
          id: MovieAppBarSlot.rating,
          child: MovieRatingPill(movie: movie),
        ),
        BoxyId(
          id: MovieAppBarSlot.meta,
          child: Text(
            metaParts.join(' · '),
            style: MarqueeTypography.meta.copyWith(
              fontWeight: FontWeight.w500,
              letterSpacing: _metaLetterSpacing,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        BoxyId(
          id: MovieAppBarSlot.title,
          child: Hero(
            tag: movie.titleHeroTag,
            flightShuttleBuilder: (_, _, _, _, _) => Material(
              type: MaterialType.transparency,
              child: DefaultTextStyle(
                style: titleStyle ?? const TextStyle(),
                child: titleText,
              ),
            ),
            child: titleText,
          ),
        ),
        BoxyId(
          id: MovieAppBarSlot.leading,
          child: MarqueeBackButton(
            foregroundColor: foregroundColor,
            iconButtonStyle: iconButtonStyle,
          ),
        ),
        BoxyId(
          id: MovieAppBarSlot.actions,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Symbols.ios_share),
                tooltip: 'Share',
                color: foregroundColor,
                onPressed: onShare,
                style: iconButtonStyle,
              ),
              FavoriteButton(
                onFavorite: onFavorite,
                isFavorite: isFavorite,
                style: iconButtonStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  double _expansionPercentageOf(BuildContext context) {
    final settings = context
        .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    if (settings == null) return 1;

    final collapsibleExtent = settings.maxExtent - settings.minExtent;
    if (collapsibleExtent <= 0) return 1;

    return ((settings.currentExtent - settings.minExtent) / collapsibleExtent)
        .clamp(0.0, 1.0);
  }

  double _titleTextSizeScale(TextTheme textTheme) {
    final expandedFontSize = textTheme.titleLarge?.fontSize;
    final collapsedFontSize = textTheme.titleMedium?.fontSize;
    if (expandedFontSize == null ||
        collapsedFontSize == null ||
        expandedFontSize <= 0) {
      return 1;
    }

    return collapsedFontSize / expandedFontSize;
  }
}
