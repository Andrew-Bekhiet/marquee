import 'package:material_ui/material_ui.dart';

class const CircleIconButton({
  required final IconData icon,
  required final VoidCallback onPressed,
  final String? tooltip,
  final double size = 40,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      color: colorScheme.onSurfaceVariant,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        shape: CircleBorder(side: BorderSide(color: colorScheme.outline)),
        fixedSize: Size.square(size),
        iconSize: 20,
      ),
    );
  }
}
