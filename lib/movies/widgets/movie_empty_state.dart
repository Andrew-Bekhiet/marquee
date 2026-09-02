import 'package:material_ui/material_ui.dart';

class const MovieEmptyState({
  required final String message,
  required final IconData icon,
  super.key,
}) extends StatelessWidget {
  static const double _iconSize = 28;
  static const double _spacing = 8;
  static const EdgeInsetsDirectional _padding = EdgeInsetsDirectional.symmetric(
    vertical: 20,
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Padding(
      padding: _padding,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          spacing: _spacing,
          children: [
            Icon(
              icon,
              size: _iconSize,
              color: colorScheme.onSurfaceVariant,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
