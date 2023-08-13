import 'package:flutter/material.dart';

import '../../widgets/constants.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Appcolors.backgroundDark,
  textTheme: const TextTheme(
    //heading and icon color
    titleLarge: TextStyle(
      color: Appcolors.iconColorDark,
      fontSize: 25,
    ),
    //textform text color
    titleSmall: TextStyle(
      color: Appcolors.textDark,
    ),

    //contoller when typing
    titleMedium: TextStyle(color: Appcolors.iconColorDark),

    ////list tile text color
    bodyMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        height: 1.5,
        color: Colors.black),
  ),

  //container
  colorScheme: ColorScheme.dark(
    primary: Appcolors.containerDark,
  ),
);
//

//L I G H T    T H E M E

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Appcolors.backgroundLight,
  textTheme: TextTheme(
    //heading and icon color
    titleLarge: TextStyle(
      color: Appcolors.iconColorLight,
      fontSize: 25,
    ),
    //textform text color
    titleSmall: const TextStyle(
      color: Appcolors.textLight,
    ),

    //contoller when typing
    titleMedium: TextStyle(color: Appcolors.iconColorLight),

    ////list tile text color
    bodyMedium: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        height: 1.5,
        color: Colors.black),
  ),

  //container
  colorScheme: ColorScheme.light(
    primary: Appcolors.containerLight,
  ),
);
