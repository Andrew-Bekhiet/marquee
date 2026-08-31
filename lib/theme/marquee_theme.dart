import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class MarqueeTheme {
  static const Color primary = Color(0xFFEAC362);

  static const BorderRadius fieldRadius = BorderRadius.all(
    Radius.circular(14.0),
  );
  static const double wordmarkTracking = 4.0;

  static const ColorScheme _scheme = ColorScheme.dark(
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

  static ThemeData _createTheme() {
    final textTheme = GoogleFonts.spaceGroteskTextTheme(
      ThemeData.dark().textTheme,
    ).apply(bodyColor: _scheme.onSurface, displayColor: _scheme.onSurface);

    return ThemeData(
      colorScheme: _scheme,
      scaffoldBackgroundColor: _scheme.surface,
      textTheme: textTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _scheme.surfaceContainer,
        labelStyle: TextStyle(color: _scheme.onSurfaceVariant),
        floatingLabelStyle: const TextStyle(color: primary),
        errorStyle: GoogleFonts.jetBrainsMono(
          fontSize: 12,
          color: _scheme.error,
        ),
        border: OutlineInputBorder(
          borderRadius: fieldRadius,
          borderSide: BorderSide(color: _scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: fieldRadius,
          borderSide: BorderSide(color: _scheme.outlineVariant),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: fieldRadius,
          borderSide: BorderSide(color: primary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: fieldRadius,
          borderSide: BorderSide(color: _scheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: fieldRadius,
          borderSide: BorderSide(color: _scheme.error, width: 1.6),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          shape: const RoundedRectangleBorder(borderRadius: fieldRadius),
          textStyle: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _scheme.surfaceContainerHigh,
        contentTextStyle: textTheme.bodyMedium,
        shape: const RoundedRectangleBorder(
          borderRadius: fieldRadius,
        ),
      ),
    );
  }

  static TextStyle mono({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? _scheme.onSurface,
      letterSpacing: letterSpacing,
    );
  }
}
