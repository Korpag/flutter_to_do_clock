import 'package:flutter/material.dart';

import 'package:flutter_to_do_clock/utils/constants/constants.dart';

ThemeData appTheme() => ThemeData(
    colorScheme: const ColorScheme.light(
        primary: appPrimaryColor,
        onPrimary: appTertiaryColor,
        onSurface: appPrimaryColor),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: appPrimaryColor)),
    canvasColor: appPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: appPrimaryColor,
    primaryColor: appPrimaryColor,
    textTheme: TextTheme(
      headline3: const TextStyle(
          fontFamily: 'Montserrat',
          color: appTertiaryColor,
          fontSize: appHeadLine3,
          fontWeight: FontWeight.w700),
      headline4: const TextStyle(
          fontFamily: 'Montserrat',
          color: appTertiaryColor,
          fontSize: appHeadLine4,
          fontWeight: FontWeight.w700),
      headline5: TextStyle(
          fontFamily: 'Montserrat',
          color: appTertiaryColorWithOp,
          fontSize: appHeadLine5,
          fontWeight: FontWeight.w700),
      headline6: TextStyle(
          fontFamily: 'Montserrat',
          color: appTertiaryColorWithOp,
          fontSize: appHeadLine6,
          fontWeight: FontWeight.w700),
      headline2: const TextStyle(
          fontFamily: 'Montserrat',
          color: appTertiaryColor,
          fontSize: appHeadLine6,
          fontWeight: FontWeight.w700),
      headline1: const TextStyle(
          fontFamily: 'Montserrat',
          color: appSecondaryColor,
          fontSize: appHeadLine4,
          fontWeight: FontWeight.w500),
      subtitle2: TextStyle(
          fontFamily: 'Montserrat',
          color: appTertiaryColor.withOpacity(0.5),
          fontSize: appHeadLine6,
          fontWeight: FontWeight.w700
          ),
      subtitle1: const TextStyle(
          fontFamily: 'Montserrat',
          color: appSecondaryColor,
          fontSize: appSubTitle1,
          fontWeight: FontWeight.w500),
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: appSecondaryColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: appSecondaryColor)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: appSecondaryColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: appSecondaryColor))));
