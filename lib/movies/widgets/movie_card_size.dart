import 'package:marquee/shared/marquee_theme.dart';
import 'package:material_ui/material_ui.dart';

enum MovieCardSize({
  required final double posterWidth,
  required final bool showsCaption,
  required final bool showsRating,
  required final double codeFontSize,
  required final BorderRadius posterRadius,
}) {
  big(
    posterWidth: 132,
    showsCaption: false,
    showsRating: true,
    codeFontSize: 20,
    posterRadius: MarqueeTheme.fieldRadius,
  ),
  medium(
    posterWidth: 116,
    showsCaption: true,
    showsRating: true,
    codeFontSize: 13,
    posterRadius: MarqueeTheme.posterRadius,
  ),
  small(
    posterWidth: 92,
    showsCaption: true,
    showsRating: false,
    codeFontSize: 13,
    posterRadius: MarqueeTheme.posterRadius,
  );

  double get posterHeight => posterWidth / posterAspectRatio;

  // the lint reports on both numbers, but this is more readable than using
  //one decimal number
  // ignore: solid_lints/no_magic_number
  static const double posterAspectRatio = 2 / 3;
}
