import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
  static Color appColor = fromHex('#000000');
  static Color secondaryColor = fromHex('#F8F8F8');
  static Color appIconColor = fromHex('#797F7E');
  static Color yellowColor = fromHex('#000000');
  static Color backgroundColor = fromHex('#4d18cc');
  static Color purple = Colors.purple;
  static Color red = Colors.red;
  static Color green = Colors.green;
  static Color grey = Colors.grey;
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
