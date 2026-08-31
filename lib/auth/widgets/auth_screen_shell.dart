import 'package:flutter/material.dart';
import 'package:marquee/shared/widgets/logo_widget.dart';
import 'package:marquee/theme/marquee_theme.dart';

class AuthScreenShell extends StatelessWidget {
  static const double _maxContentWidth = 420.0;

  final Widget body;
  final String title;
  final String subtitle;
  final Widget? footer;

  const AuthScreenShell({
    required this.body,
    required this.title,
    required this.subtitle,
    super.key,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxContentWidth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12,
                children: [
                  Row(
                    spacing: 12,
                    children: [
                      const LogoWidget(),
                      Text(
                        'MARQUEE',
                        style: TextTheme.of(context).titleSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          letterSpacing: MarqueeTheme.wordmarkTracking,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 20),
                  body,
                  ?footer,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
