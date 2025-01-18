import 'package:flutter/material.dart';

class WidgetSupport {
  static TextStyle boldTextStyle({FontWeight? fontWeight, double? fontSize, required Color color}) {
    return TextStyle(color: color, fontSize: fontSize ?? 20, fontWeight: fontWeight ?? FontWeight.w500, fontFamily: 'Poppins');
  }
}
