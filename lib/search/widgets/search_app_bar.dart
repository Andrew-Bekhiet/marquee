import 'package:marquee/shared/marquee_theme.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const SearchAppBar({
  required final String initialQuery,
  required final ValueChanged<String> onQueryChanged,
  required final ValueChanged<String> onSubmitted,
  super.key,
}) extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 12);

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final border = OutlineInputBorder(
      borderRadius: MarqueeTheme.fieldRadius,
      borderSide: BorderSide(color: colorScheme.primary),
    );

    return AppBar(
      titleSpacing: 0,
      actionsPadding: const EdgeInsetsDirectional.only(end: 12),
      title: TextFormField(
        initialValue: initialQuery,
        autofocus: true,
        textInputAction: TextInputAction.search,
        onChanged: onQueryChanged,
        onFieldSubmitted: onSubmitted,
        style: textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: 'Search films, people, genres',
          prefixIcon: const Icon(Symbols.search),
          isDense: true,
          enabledBorder: border,
          focusedBorder: border,
        ),
      ),
    );
  }
}
