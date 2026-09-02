import 'package:flutter/material.dart' as legacy;
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/shared/widgets/marquee_back_button.dart';
import 'package:material_ui/material_ui.dart';

abstract final class const MarqueeTheme._() {
  static const Color primary = Color(0xFFEAC362);

  static const BorderRadius fieldRadius = BorderRadius.all(
    Radius.circular(14.0),
  );
  static const BorderRadius posterRadius = BorderRadius.all(
    Radius.circular(11.0),
  );
  static const BorderRadius buttonRadius = BorderRadius.all(
    Radius.circular(9.0),
  );
  static const BorderRadius thumbnailRadius = BorderRadius.all(
    Radius.circular(7.0),
  );

  static const double wordmarkTracking = 4.0;

  static const double _screenTitleSize = 26.0;
  static const double _screenTitleHeight = 1.1;
  static const double _screenTitleTracking = -0.78;
  static const double _featuredTitleSize = 22.0;
  static const double _featuredTitleHeight = 1.08;
  static const double _featuredTitleTracking = -0.66;
  static const double _sectionTitleSize = 15.0;
  static const double _cardTitleSize = 11.5;
  static const double _cardTitleHeight = 1.25;
  static const double _navLabelSize = 10.0;
  static const double _buttonLabelSize = 12.5;

  static const double _navIconSize = 20.0;
  static const double _navBarHeight = 64.0;

  static const ColorScheme _colorScheme = ColorScheme.dark(
    primary: primary,
    onPrimary: Color(0xFF3A2E00),
    primaryContainer: Color(0xFF4C3E0E),
    onPrimaryContainer: Color(0xFFF7E2AC),
    secondary: Color(0xFFD5C8AE),
    onSecondary: Color(0xFF383021),
    tertiary: Color(0xFFADC7E5),
    onTertiary: Color(0xFF14293D),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    surface: Color(0xFF100F0D),
    onSurface: Color(0xFFECE6DB),
    surfaceContainerLowest: Color(0xFF0B0A09),
    surfaceContainer: Color(0xFF1A1917),
    surfaceContainerHigh: Color(0xFF2B2926),
    surfaceContainerHighest: Color(0xFF373431),
    onSurfaceVariant: Color(0xFF9C958A),
    outline: Color(0xFF4A463F),
    outlineVariant: Color(0xFF2E2B27),
  );

  static final ThemeData theme = _createTheme();

  static TextTheme _marqueeScale(TextTheme base) {
    return base.copyWith(
      headlineSmall: base.headlineSmall?.copyWith(
        fontSize: _screenTitleSize,
        fontWeight: FontWeight.w700,
        height: _screenTitleHeight,
        letterSpacing: _screenTitleTracking,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: _featuredTitleSize,
        fontWeight: FontWeight.w700,
        height: _featuredTitleHeight,
        letterSpacing: _featuredTitleTracking,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontSize: _sectionTitleSize,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontSize: _cardTitleSize,
        fontWeight: FontWeight.w500,
        height: _cardTitleHeight,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontSize: _navLabelSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static ThemeData _createTheme() {
    final textTheme = _marqueeScale(
      GoogleFonts.spaceGroteskTextTheme(ThemeData.dark().textTheme.toLegacy())
          .apply(
            bodyColor: _colorScheme.onSurface,
            displayColor: _colorScheme.onSurface,
          )
          .toModern(),
    );

    return ThemeData(
      colorScheme: _colorScheme,
      scaffoldBackgroundColor: _colorScheme.surface,
      textTheme: textTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _colorScheme.surfaceContainer,
        labelStyle: TextStyle(color: _colorScheme.onSurfaceVariant),
        floatingLabelStyle: const TextStyle(color: primary),
        errorStyle: MarqueeTypography.meta.copyWith(
          color: _colorScheme.error,
        ),
        border: OutlineInputBorder(
          borderRadius: fieldRadius,
          borderSide: BorderSide(color: _colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: fieldRadius,
          borderSide: BorderSide(color: _colorScheme.outlineVariant),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: fieldRadius,
          borderSide: BorderSide(color: primary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: fieldRadius,
          borderSide: BorderSide(color: _colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: fieldRadius,
          borderSide: BorderSide(color: _colorScheme.error, width: 1.6),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(36),
          shape: const RoundedRectangleBorder(borderRadius: buttonRadius),
          textStyle: textTheme.labelLarge?.copyWith(
            fontSize: _buttonLabelSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: _navBarHeight,
        backgroundColor: _colorScheme.surfaceContainer,
        indicatorColor: MarqueeTheme.primary,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => textTheme.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected)
                ? MarqueeTheme.primary
                : _colorScheme.onSurfaceVariant,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: _navIconSize,
            color: states.contains(WidgetState.selected)
                ? _colorScheme.onPrimary
                : _colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _colorScheme.surfaceContainerHigh,
        contentTextStyle: textTheme.bodyMedium,
        shape: const RoundedRectangleBorder(
          borderRadius: fieldRadius,
        ),
      ),
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (_) => const MarqueeBackButton(),
      ),
    );
  }
}

abstract final class const MarqueeTypography._() {
  static const double _eyebrowSize = 9.5;
  static const double _eyebrowTracking = 1.33;
  static const double _metaSize = 10.0;

  static final TextStyle eyebrow = _mono(
    fontSize: _eyebrowSize,
    fontWeight: FontWeight.w700,
    letterSpacing: _eyebrowTracking,
  );

  static final TextStyle meta = _mono(fontSize: _metaSize);

  static TextStyle posterCode({required double fontSize}) =>
      _mono(fontSize: fontSize, fontWeight: FontWeight.w700);

  static TextStyle _mono({
    required double fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }
}

extension LegacyTextThemeToModern on legacy.TextTheme {
  TextTheme toModern() {
    return TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }
}

extension ModernTextThemeToLegacy on TextTheme {
  legacy.TextTheme toLegacy() {
    return legacy.TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }
}
