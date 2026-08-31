import 'package:flutter/material.dart';
import 'package:marquee/auth/widgets/auth_gate.dart';
import 'package:marquee/theme/marquee_theme.dart';

class MarqueeApp extends StatelessWidget {
  const MarqueeApp({super.key});

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
