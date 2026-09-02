import 'package:kaisel/kaisel.dart';
import 'package:marquee/home/widgets/circle_icon_button.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const MarqueeBackButton({
  final Color? foregroundColor,
  final Color? backgroundColor,
  final ButtonStyle? iconButtonStyle,
  super.key,
}) extends StatelessWidget {
  static const double _iconSize = 20;

  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: Symbols.arrow_back,
      tooltip: 'Back',
      size: _iconSize,
      onPressed: context.pop,
      style: iconButtonStyle,
    );
  }
}
