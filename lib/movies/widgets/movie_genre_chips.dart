import 'package:marquee/movies/models/genre.dart';
import 'package:material_ui/material_ui.dart';

class const MovieGenreChips({
  required final List<Genre> genres,
  super.key,
}) extends StatelessWidget {
  static const BorderRadius _radius = BorderRadius.all(Radius.circular(7));

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Wrap(
      spacing: 7,
      runSpacing: 7,
      children: [
        for (final genre in genres)
          DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHigh,
              borderRadius: _radius,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
              child: Text(genre.name, style: textTheme.labelLarge),
            ),
          ),
      ],
    );
  }
}
