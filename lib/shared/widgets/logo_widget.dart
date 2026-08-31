import 'package:material_ui/material_ui.dart';

class const LogoWidget({
  final double size = defaultSize,
  super.key,
}) extends StatelessWidget {
  static const double defaultSize = 56;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icon/logo.png',
      width: size,
      height: size,
    );
  }
}
