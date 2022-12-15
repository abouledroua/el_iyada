import 'package:flutter/material.dart';

class AppSizes {
  static late double widthScreen, heightScreen;

  static setSizeScreen(context) {
    widthScreen = MediaQuery.of(context).size.width;
    heightScreen = MediaQuery.of(context).size.height;
  }
}
