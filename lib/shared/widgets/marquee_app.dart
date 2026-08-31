import 'package:marquee/auth/widgets/auth_gate.dart';
import 'package:marquee/theme/marquee_theme.dart';
import 'package:material_ui/material_ui.dart';

class const MarqueeApp({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marquee',
      debugShowCheckedModeBanner: false,
      theme: MarqueeTheme.theme,
      home: const AuthGate(),
    );
  }
}
