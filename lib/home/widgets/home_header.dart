import 'package:marquee/home/widgets/circle_icon_button.dart';
import 'package:marquee/shared/marquee_theme.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const HomeHeader({
  required final String dateLabel,
  required final VoidCallback onSearch,
  required final VoidCallback onSignOut,
  super.key,
}) extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4);

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return AppBar(
      centerTitle: false,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateLabel.toUpperCase(),
            style: MarqueeTypography.eyebrow.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            'In cinemas',
            style: textTheme.headlineSmall,
          ),
        ],
      ),
      titleSpacing: 16,
      actionsPadding: const EdgeInsetsDirectional.only(end: 16),
      actions: [
        CircleIconButton(icon: Symbols.search, onPressed: onSearch),
        CircleIconButton(
          icon: Symbols.logout,
          onPressed: onSignOut,
          tooltip: 'Sign out',
        ),
      ],
    );
  }
}
