import 'package:flutter/material.dart';

Widget height20 = const SizedBox(
  height: 20,
);

List<Color> backgroundColors = [
  const Color(0xFFCCE5FF), // light blue
  const Color(0xFFD7F9E9), // pale green
  const Color(0xFFFFF8E1), // pale yellow
  const Color(0xFFF5E6CC), // beige
  const Color(0xFFFFD6D6), // light pink
  const Color(0xFFE5E5E5), // light grey
  const Color(0xFFFFF0F0), // pale pink
  const Color(0xFFE6F9FF), // pale blue
  const Color(0xFFD4EDDA), // mint green
  const Color(0xFFFFF3CD), // pale orange
];

class Appcolors {
  //  D A R K T H E M E
  static Color backgroundDark = Colors.grey.shade900;
  static const iconColorDark = Colors.white; //white
  static const textDark = Colors.grey; //grey
  static Color containerDark = Colors.grey.shade800.withOpacity(.8);

//  L I G H T T H E M E
  static Color backgroundLight = const Color(0xFFE5E5E5);
  static Color iconColorLight = Colors.black;
  static const textLight = Colors.black;
  static Color containerLight = Colors.white.withOpacity(.5);
}
