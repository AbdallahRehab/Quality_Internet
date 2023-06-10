import 'package:flutter/material.dart';

class AppColors {
  // Color primary = Color(0xff002723);
  Color primary = Color(0xff2F80ED);
  Color accent = Color(0xffe8518b);
  Color appBarBG = Color(0xffFFFFFF);
  Color white = Color(0xffFFFFFF);
  Color grey = Colors.grey;
  Color black = Color(0xff000000);
  Color background = Color(0xffF3F5F8);
}

const String google_api_key = "AIzaSyBElkDmMxsjolcZgbTdEprJOtoq8Oj1RPE";

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
