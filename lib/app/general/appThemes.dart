import 'package:flutter/material.dart';

const darkblue = Color.fromARGB(255, 4, 50, 88);
const lightblue = Color.fromRGBO(66, 163, 181, 1);
const yellow = Color.fromRGBO(246, 176, 66, 1.0);
const putih = Colors.white;
const hitam = Colors.black;
const artinya = Color.fromARGB(255, 81, 80, 80);
const lightgreen = Color.fromARGB(255, 122, 232, 185);

// ThemeData themeLight = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: darkblue,
//     scaffoldBackgroundColor: putih,
//     tabBarTheme: TabBarTheme(
//         unselectedLabelColor: lightblue,
//         labelColor: darkblue,
//         indicatorColor: darkblue),
//     appBarTheme: AppBarTheme(
//       backgroundColor: putih,
//       shadowColor: Colors.white,
//       surfaceTintColor: Colors.white,
//     ),
//   );

// ThemeData themeDark = ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: lightblue,
//     scaffoldBackgroundColor: darkblue,
//     dialogBackgroundColor: darkblue,
//     tabBarTheme: TabBarTheme(
//         unselectedLabelColor: putih,
//         dividerColor: putih,
//         labelColor: lightblue,
//         indicatorColor: lightblue),
//     appBarTheme: AppBarTheme(
//       elevation: 0,
//       backgroundColor: darkblue,
//     ),
// );

class AppThemes {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
        brightness: colorScheme.brightness,
      appBarTheme: AppBarTheme(
        color: colorScheme.primary,
        elevation: 0,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: putih,
    secondary: Color(0xFF03DAC5),
    background: putih,
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static final ColorScheme darkColorScheme = ColorScheme(
    primary: darkblue,
    secondary: Colors.yellow,
    background: darkblue,
    surface: darkblue,
    onBackground:darkblue,
    // White with 0.05 opacity
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );
}
