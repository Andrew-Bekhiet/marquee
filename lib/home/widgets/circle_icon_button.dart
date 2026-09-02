import 'package:material_ui/material_ui.dart';

class const CircleIconButton({
  required final IconData icon,
  required final VoidCallback onPressed,
  final String? tooltip,
  final double size = 40,
  final double iconSize = _defaultIconSize,
  final ButtonStyle? style,
  super.key,
}) extends StatelessWidget {
  static const double _defaultIconSize = 20;
  static final defaultButtonStyle = IconButton.styleFrom(
    shape: const CircleBorder(),
    fixedSize: const Size.square(40),
    iconSize: _defaultIconSize,
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      color: colorScheme.onSurfaceVariant,
      onPressed: onPressed,
      style:
          style ??
          defaultButtonStyle.copyWith(
            side: WidgetStatePropertyAll(
              BorderSide(color: colorScheme.outline),
            ),
          ),
    );
  }
}
