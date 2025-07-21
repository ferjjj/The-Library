import 'dart:math';

import 'package:flutter/material.dart';
import 'package:the_library/utils/constants/colors.dart';
import 'package:the_library/utils/constants/image_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(color: pureWhite),
          alignment: Alignment.center,
          child: Container(
            height: min(size.width, size.height) * 0.7,
            width: min(size.width, size.height) * 0.7,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset(iTheLibrarySplash),
            ),
          )),
    );
  }
}
