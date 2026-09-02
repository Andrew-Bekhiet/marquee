import 'package:material_ui/material_ui.dart';

abstract final class const MarqueeAnimationBasis._() {
  static const Curve standard = Cubic(0.2, 0.8, 0.2, 1);
  static const Curve spring = Cubic(0.34, 1.56, 0.64, 1);

  static const Duration pop = Duration(milliseconds: 420);
  static const Duration enter = Duration(milliseconds: 350);
  static const Duration quick = Duration(milliseconds: 200);
  static const Duration fade = Duration(milliseconds: 400);
}
