import 'package:flutter/material.dart';

const Color pureWhite = Color(0xFFFFFFFF);
const Color muteBlack = Color(0xFF404040);
const Color mediumGray = Color.fromARGB(255, 85, 85, 85);
const Color lightGrey = Color(0xFFA6A6A6);

const Color primaryYellow = Color(0xFFE2C184);
const Color primaryGreen = Color(0xFF84A99D);
const Color primaryBlue = Color(0xFF75A6B0);
const Color primaryPink = Color(0xFFD8A6C2);

BoxShadow lightShadow({Color? color}) {
  return BoxShadow(
      color: color ?? muteBlack.withOpacity(0.35),
      blurRadius: 15,
      spreadRadius: -5);
}
