import 'dart:math';
import 'package:flutter/material.dart';

class AppSizes {
  static const double maxWidth = 800;
  static late double minWidth, widthScreen, heightScreen;

  static setSizeScreen(context) {
    widthScreen = MediaQuery.of(context).size.width;
    minWidth = min(MediaQuery.of(context).size.width, maxWidth);
    heightScreen = MediaQuery.of(context).size.height;
  }
}
