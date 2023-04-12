import 'package:flutter/material.dart';


class Palette{
  static const whiteColor = Color(0xFFFFFFFF);
  static const blueColor = Color.fromRGBO(29, 161, 242, 1);
  static const blackColor = Color.fromRGBO(20, 23, 26, 1);
  static const darkBlueColor = Color.fromRGBO(34, 48, 60, 1);
  static const darkGreyColor = Color.fromRGBO(101, 119, 134, 1);
  static const lightGreyColor = Color.fromRGBO(170, 184, 194, 1);
  static const extraLightGrey = Color.fromRGBO(225, 232, 237, 1);
  static const extraExtraLightGrey = Color.fromRGBO(245, 248, 250, 1);
  static const redColor = Color.fromRGBO(229, 9, 20, 1);

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
  );

  static var dimDarkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkBlueColor,
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
    drawerTheme: const DrawerThemeData(
      backgroundColor: darkBlueColor,
    ),
    primaryColor: blueColor,
  );

}
