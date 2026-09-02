import 'package:marquee/shared/marquee_theme.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const FavoriteButton({
  required final VoidCallback onFavorite,
  required final bool isFavorite,
  super.key,
}) extends StatelessWidget {
  static const double _favoriteButtonSize = 36;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return IconButton(
      onPressed: onFavorite,
      style: IconButton.styleFrom(
        fixedSize: const Size.square(_favoriteButtonSize),
        shape: const RoundedRectangleBorder(
          borderRadius: MarqueeTheme.buttonRadius,
        ),
        side: BorderSide(color: colorScheme.outline),
      ),
      icon: Icon(
        Symbols.favorite,
        fill: isFavorite ? 1 : 0,
        color: MarqueeTheme.primary,
      ),
    );
  }
}
