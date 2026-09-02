import 'package:marquee/shared/marquee_theme.dart';
import 'package:material_ui/material_ui.dart';

class const MoviePosterFallback({
  required final String code,
  required final double fontSize,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.surfaceContainerHigh,
            colorScheme.surfaceContainerLowest,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 8, bottom: 7),
        child: Align(
          alignment: AlignmentDirectional.bottomStart,
          child: Text(
            code,
            style: MarqueeTypography.posterCode(
              fontSize: fontSize,
            ).copyWith(color: colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}
