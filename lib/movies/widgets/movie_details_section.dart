import 'package:marquee/shared/marquee_theme.dart';
import 'package:material_ui/material_ui.dart';

class const MovieDetailsSection({
  required final String label,
  required final Widget child,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 9,
      children: [
        Text(
          label,
          style: MarqueeTypography.eyebrow.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        child,
      ],
    );
  }
}
