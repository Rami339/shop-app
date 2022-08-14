import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/constants.dart';

ThemeData lightMode = ThemeData(
  primaryColor: Colors.white70,
  scaffoldBackgroundColor: secondColor,

  appBarTheme: const AppBarTheme(
    backgroundColor: secondColor,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: secondColor,
  ),

  colorScheme: ThemeData().colorScheme.copyWith(
        primary: defaultColor,

      ),
  textTheme: const TextTheme(
    headline6: TextStyle(
      fontSize: 30,
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: secondColor,
    unselectedItemColor: Colors.grey,
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.grey,
  ),

);

ThemeData darkMode = ThemeData(
  primaryColor: const Color(0x5E595858),

  scaffoldBackgroundColor: const Color(0xFF333739),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF333739),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: Color(0xFF333739),
  ),
  textTheme: const TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
      subtitle1: TextStyle(color: Colors.white)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xff333739),
    unselectedItemColor: Colors.grey,
  ),
  colorScheme: ThemeData().colorScheme.copyWith(
        primary: defaultColor,
      ),
  dividerTheme: const DividerThemeData(
    color: Colors.grey,
  ),

);
