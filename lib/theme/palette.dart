import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider =
    StateNotifierProvider<ToggleThemeNotifier, ThemeData>((ref) {
  return ToggleThemeNotifier();
});

class Palette {
  static const whiteColor = Color(0xFFFFFFFF);
  static const blueColor = Color.fromRGBO(29, 161, 242, 1);
  static const blackColor = Color.fromRGBO(1, 1, 1, 1);
  static const darkBlueColor = Color.fromRGBO(34, 48, 60, 1);
  static const darkGreyColor = Color.fromRGBO(101, 119, 134, 1);
  static const lightGreyColor = Color.fromRGBO(170, 184, 194, 1);
  static const extraLightGrey = Color.fromRGBO(225, 232, 237, 1);
  static const extraExtraLightGrey = Color.fromRGBO(245, 248, 250, 1);
  static const redColor = Color.fromRGBO(229, 9, 20, 1);
  static const greenColor = Color.fromRGBO(25, 207, 134, 1);

  static var lightsOutModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,
    dividerColor: darkGreyColor,
    iconTheme: const IconThemeData(
      color: whiteColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: blackColor,
      iconTheme: IconThemeData(
        color: darkGreyColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: blackColor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: whiteColor,
      ),
      bodyMedium: TextStyle(
        color: whiteColor,
      ),
      bodySmall: TextStyle(
        color: whiteColor,
      ),
      titleLarge: TextStyle(
        color: whiteColor,
      ),
      titleMedium: TextStyle(
        color: whiteColor,
      ),
      titleSmall: TextStyle(
        color: whiteColor,
      ),
    ),
    primaryColor: blueColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Palette.blackColor,
      onPrimary: Palette.extraExtraLightGrey,
      secondary: Palette.darkGreyColor,
      onSecondary: Palette.extraExtraLightGrey,
      error: Palette.redColor,
      onError: Palette.whiteColor,
      background: Palette.blackColor,
      onBackground: Palette.extraExtraLightGrey,
      surface: Palette.darkBlueColor,
      onSurface: Palette.darkGreyColor,
      tertiary: Palette.whiteColor,
    ),
  );

  static var lightModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: whiteColor,
    dividerColor: darkGreyColor,
    iconTheme: const IconThemeData(
      color: blackColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: blackColor,
      iconTheme: IconThemeData(
        color: blackColor,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: blackColor,
      ),
      bodyMedium: TextStyle(
        color: blackColor,
      ),
      bodySmall: TextStyle(
        color: blackColor,
      ),
      titleLarge: TextStyle(
        color: blackColor,
      ),
      titleMedium: TextStyle(
        color: blackColor,
      ),
      titleSmall: TextStyle(
        color: blackColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: blueColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Palette.whiteColor,
      onPrimary: Palette.blackColor,
      secondary: Palette.extraLightGrey,
      onSecondary: Palette.blackColor,
      error: Palette.redColor,
      onError: Palette.extraLightGrey,
      background: Palette.whiteColor,
      onBackground: Palette.blackColor,
      surface: Palette.lightGreyColor,
      onSurface: Palette.darkGreyColor,
      tertiary: Palette.blueColor,
    ),
  );

  // static var dimDarkModeAppTheme = ThemeData.dark().copyWith(
  //   scaffoldBackgroundColor: darkBlueColor,
  //   dividerColor: darkGreyColor,
  //   iconTheme: const IconThemeData(
  //     color: whiteColor,
  //   ),
  //   appBarTheme: const AppBarTheme(
  //     backgroundColor: blackColor,
  //     iconTheme: IconThemeData(
  //       color: darkGreyColor,
  //     ),
  //   ),
  //   textTheme: const TextTheme(
  //     bodyLarge: TextStyle(
  //       color: whiteColor,
  //     ),
  //     bodyMedium: TextStyle(
  //       color: whiteColor,
  //     ),
  //     bodySmall: TextStyle(
  //       color: whiteColor,
  //     ),
  //     titleLarge: TextStyle(
  //       color: whiteColor,
  //     ),
  //     titleMedium: TextStyle(
  //       color: whiteColor,
  //     ),
  //     titleSmall: TextStyle(
  //       color: whiteColor,
  //     ),
  //   ),
  //   drawerTheme: const DrawerThemeData(
  //     backgroundColor: darkBlueColor,
  //   ),
  //   primaryColor: blueColor,
  //   colorScheme: const ColorScheme(
  //     brightness: Brightness.dark,
  //     primary: Palette.darkBlueColor,
  //     onPrimary: Palette.extraExtraLightGrey,
  //     secondary: Palette.darkBlueColor,
  //     onSecondary: Palette.whiteColor,
  //     error: Palette.redColor,
  //     onError: Palette.whiteColor,
  //     background: Palette.darkBlueColor,
  //     onBackground: Palette.extraExtraLightGrey,
  //     surface: Palette.darkBlueColor,
  //     onSurface: Palette.whiteColor,
  //   ),
  // );
}

class ToggleThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;
  ToggleThemeNotifier({ThemeMode mode = ThemeMode.dark})
      : _mode = mode,
        super(Palette.lightsOutModeAppTheme);

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');
    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = Palette.lightModeAppTheme;
    } else {
      _mode = ThemeMode.dark;
      state = Palette.lightsOutModeAppTheme;
    }
  }

  ThemeMode get mode => _mode;

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');
    if (theme == 'light') {
      _mode = ThemeMode.dark;
      state = Palette.lightsOutModeAppTheme;
      prefs.setString('theme', 'lightsOut');
      getTheme();
    } else {
      _mode = ThemeMode.light;
      state = Palette.lightModeAppTheme;
      prefs.setString('theme', 'light');
      getTheme();
    }
  }
}
