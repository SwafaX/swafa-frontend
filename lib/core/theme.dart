import 'package:flutter/material.dart';

class FontSizes {
  static const small = 12.0;
  static const standard = 14.0;
  static const medium = 16.0;
  static const large = 20.0;
}

class DefaultColors {
  // Primary Colors
  static const Color primary50 = Color(0xFFF4F4F4);
  static const Color primary100 = Color(0xFFCDCDCD);
  static const Color primary200 = Color(0xFFA6A6A6);
  static const Color primary300 = Color(0xFF7F7F7F);
  static const Color primary400 = Color(0xFF585858);
  static const Color primary500 = Color(0xFF323232);
  static const Color primary600 = Color(0xFF282828);
  static const Color primary700 = Color(0xFF1E1E1E);
  static const Color primary800 = Color(0xFF141414);
  static const Color primary900 = Color(0xFF090909);

  // Secondary Colors
  static const Color secondary50 = Color(0xFFD9D9D9);
  static const Color secondary100 = Color(0xFFDDDCE1);
  static const Color secondary200 = Color(0xFFC3C1CA);
  static const Color secondary300 = Color(0xFFA9A5B3);
  static const Color secondary400 = Color(0xFF8F8A9C);
  static const Color secondary500 = Color(0xFF756F86);
  static const Color secondary600 = Color(0xFF5D586B);
  static const Color secondary700 = Color(0xFF464250);
  static const Color secondary800 = Color(0xFF2E2C35);
  static const Color secondary900 = Color(0xFF17161A);

  // Neutral Colors
  static const Color neutral50 = Color(0xFFF2F2F3);
  static const Color neutral100 = Color(0xFFE2E4E9);
  static const Color neutral200 = Color(0xFFC4CAD4);
  static const Color neutral300 = Color(0xFFA7AFBE);
  static const Color neutral400 = Color(0xFF8A94A8);
  static const Color neutral500 = Color(0xFF6C7A93);
  static const Color neutral600 = Color(0xFF576175);
  static const Color neutral700 = Color(0xFF414958);
  static const Color neutral800 = Color(0xFF2B313B);
  static const Color neutral900 = Color(0xFF15181D);
  // Success Colors
  static const Color successBackground = Color(0xFFCBF7D7);
  static const Color successOnBackground = Color(0xFF34C759);

  // Error Colors
  static const Color errorBackground = Color(0xFFFFD7D9);
  static const Color errorOnBackground = Color(0xFFFF3B30);

  // Shade Colors
  static const Color shade = Color(0xFFB2B8BE);

}

class AppTheme {
  static ThemeData get swafaTheme {
    return ThemeData(
      fontFamily: 'Inter',
      primaryColor: const Color(0xFF323232),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        titleSmall: TextStyle(
          fontSize: FontSizes.standard,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: FontSizes.medium,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontSize: FontSizes.large,
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontSize: FontSizes.small,
          color: Colors.white,
        ),
      ),
    );
  }
}
