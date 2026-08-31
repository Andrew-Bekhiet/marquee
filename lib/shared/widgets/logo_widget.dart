import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  static const double defaultSize = 56;

  final double size;

  const LogoWidget({
    this.size = defaultSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icon/logo.png',
      width: size,
      height: size,
    );
  }
}
