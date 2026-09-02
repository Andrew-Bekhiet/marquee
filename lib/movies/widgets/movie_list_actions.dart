import 'package:marquee/lists/models/movie_list.dart';
import 'package:marquee/shared/marquee_animation_basis.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const MovieListActions({
  required final Set<MovieList> containedInLists,
  required final VoidCallback onWantToWatch,
  required final VoidCallback onAddToWatched,
  required final VoidCallback onAddToWatching,
  super.key,
}) extends StatelessWidget {
  static const BorderRadius _buttonRadius = BorderRadius.all(
    Radius.circular(11),
  );
  static const double _buttonHeight = 44;
  static const double _iconSize = 16;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);
    final isInWatchlist = containedInLists.contains(MovieList.watchlist);

    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: onWantToWatch,
            icon: AnimatedSwitcher(
              duration: MarqueeAnimationBasis.enter,
              switchInCurve: MarqueeAnimationBasis.standard,
              switchOutCurve: MarqueeAnimationBasis.standard,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              ),
              child: Icon(
                isInWatchlist ? Symbols.check : Symbols.add,
                key: ValueKey(isInWatchlist),
                size: _iconSize,
              ),
            ),
            label: AnimatedSwitcher(
              duration: MarqueeAnimationBasis.enter,
              switchInCurve: MarqueeAnimationBasis.standard,
              switchOutCurve: MarqueeAnimationBasis.standard,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              ),
              child: Text(
                isInWatchlist ? 'In your watchlist' : 'Want to watch',
                key: ValueKey(isInWatchlist),
              ),
            ),
            style: FilledButton.styleFrom(
              animationDuration: MarqueeAnimationBasis.quick,
              minimumSize: const Size.fromHeight(_buttonHeight),
              shape: const RoundedRectangleBorder(
                borderRadius: _buttonRadius,
              ),
              textStyle: textTheme.titleSmall,
              backgroundColor: isInWatchlist
                  ? colorScheme.secondaryContainer
                  : colorScheme.primary,
            ),
          ),
        ),
        PopupMenuButton(
          style: IconButton.styleFrom(
            fixedSize: const Size.square(_buttonHeight),
            shape: const RoundedRectangleBorder(borderRadius: _buttonRadius),
            side: BorderSide(color: colorScheme.outline),
          ),
          iconSize: _iconSize,
          itemBuilder: (_) => [
            PopupMenuItem(
              onTap: onAddToWatched,
              child: Row(
                children: [
                  const Expanded(child: Text('Add to Watched')),
                  if (containedInLists.contains(MovieList.watched))
                    const Icon(Symbols.check, size: _iconSize),
                ],
              ),
            ),
            PopupMenuItem(
              onTap: onAddToWatching,
              child: Row(
                children: [
                  const Expanded(child: Text('Add to watching')),
                  if (containedInLists.contains(MovieList.watching))
                    const Icon(Symbols.check, size: _iconSize),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
