import 'package:flutter/material.dart';

//App Font
class AppFonts {
  //Lato

  //FontWeight 400
  static TextStyle light([double fontSize = 14, Color color = Colors.black]) => TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        color: color,
      );

  //FontWeight 500
  static TextStyle regular([double fontSize = 14, Color color = Colors.black]) => TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        color: color,
      );

  //FontWeight 600
  static TextStyle normalBold([double fontSize = 14, Color color = Colors.black]) => TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
        color: color,
      );

  //FontWeight 700
  static TextStyle bold([double fontSize = 14, Color color = Colors.black]) => TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        color: color,
      );

  //FontWeight 800
  static TextStyle ultraBold([double fontSize = 14, Color color = Colors.black]) => TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w800,
        fontSize: fontSize,
        color: color,
      );

  //Inter
  //FontWeight 400
  static TextStyle lightInter([double fontSize = 14, Color color = Colors.black]) => TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        color: color,
      );

  //Fontweight 500
  static TextStyle regularInter([double fontSize = 14, Color color = Colors.black]) => TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        color: color,
      );

  //FontWeight 600
  static TextStyle normalBoldInter([double fontSize = 14, Color color = Colors.black]) => TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
        color: color,
      );

  //FontWeight 700
  static TextStyle boldInter([double fontSize = 14, Color color = Colors.black]) => TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        color: color,
      );

  static const String laTo = 'Lato';
}
