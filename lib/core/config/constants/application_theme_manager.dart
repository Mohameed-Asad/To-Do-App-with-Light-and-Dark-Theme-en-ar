import 'package:flutter/material.dart';

class ThemeManager {
  static const Color primaryColor = Color(0xFF5D9CEC);
  static const Color primaryColor2 = Color(0xFFDFECDB);
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 110,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            fontFamily: "Poppins",
            fontSize: 27,
            color: Colors.white,
            fontWeight: FontWeight.w600)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(color: primaryColor, size: 35),
      unselectedIconTheme: IconThemeData(color: Colors.grey, size: 35),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(
            color: Colors.white,
            width: 4,
          )),
    ),
    useMaterial3: true,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.white,
      padding: EdgeInsets.zero,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontFamily: "Poppins",
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(
          fontFamily: "Poppins",
          color: primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
          fontFamily: "Poppins",
          color: primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w700),
      bodySmall: TextStyle(
          fontFamily: "Poppins",
          color: primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w700),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 110,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            fontFamily: "Poppins",
            fontSize: 27,
            color: Colors.white,
            fontWeight: FontWeight.w600)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(color: primaryColor, size: 35),
      unselectedIconTheme: IconThemeData(color: Colors.grey, size: 35),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(
            color: Colors.white.withOpacity(0.8),
            width: 4,
          )),
    ),
    useMaterial3: true,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.black12,
      padding: EdgeInsets.zero,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontFamily: "Poppins",
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(
          fontFamily: "Poppins",
          color: primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
          fontFamily: "Poppins",
          color: primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w700),
      bodySmall: TextStyle(
          fontFamily: "Poppins",
          color: primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w700),
    ),
  );
}
