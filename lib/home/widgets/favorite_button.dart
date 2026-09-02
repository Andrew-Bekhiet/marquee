import 'package:marquee/shared/marquee_animation_basis.dart';
import 'package:marquee/shared/marquee_theme.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const FavoriteButton({
  required final VoidCallback onFavorite,
  required final bool isFavorite,
  final ButtonStyle? style,
  super.key,
}) extends StatefulWidget {
  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState()
    extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  static const double _buttonSize = 36;

  static const double _restScale = 1;
  static const double _peakScale = 1.35;
  static const double _settleScale = 0.92;

  static const double _riseWeight = 40;
  static const double _settleWeight = 30;
  static const double _returnWeight = 30;

  late final AnimationController _popController = AnimationController(
    vsync: this,
    duration: MarqueeAnimationBasis.pop,
  );

  late final Animation<double> _popScale =
      TweenSequence([
        TweenSequenceItem(
          tween: Tween(begin: _restScale, end: _peakScale),
          weight: _riseWeight,
        ),
        TweenSequenceItem(
          tween: Tween(begin: _peakScale, end: _settleScale),
          weight: _settleWeight,
        ),
        TweenSequenceItem(
          tween: Tween(begin: _settleScale, end: _restScale),
          weight: _returnWeight,
        ),
      ]).animate(
        CurvedAnimation(parent: _popController, curve: Curves.easeInOut),
      );

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return IconButton(
      onPressed: widget.onFavorite,
      tooltip: 'Favourite',
      style:
          widget.style ??
          IconButton.styleFrom(
            fixedSize: const Size.square(_buttonSize),
            shape: const RoundedRectangleBorder(
              borderRadius: MarqueeTheme.buttonRadius,
            ),
            side: BorderSide(color: colorScheme.outline),
          ),
      icon: ScaleTransition(
        scale: _popScale,
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: widget.isFavorite ? 1 : 0),
          duration: MarqueeAnimationBasis.quick,
          curve: MarqueeAnimationBasis.standard,
          builder: (_, fill, _) => Icon(
            Symbols.favorite,
            fill: fill.clamp(0, 1),
            color: MarqueeTheme.primary,
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isFavorite && !oldWidget.isFavorite) {
      _popController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _popController.dispose();
    super.dispose();
  }
}
