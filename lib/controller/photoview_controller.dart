// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constant/sizes.dart';

class MyPhotoViewController extends GetxController {
  int index = 0;
  PageController? pageController;
  int quarterTurns = 0;

  MyPhotoViewController({required this.index});

  updateIndex(newIndex) {
    quarterTurns = 0;
    index = newIndex;
    update();
  }

  addQuarter() {
    quarterTurns++;
    update();
  }

  subQuarter() {
    quarterTurns--;
    update();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    pageController = PageController(initialPage: index);
    super.onInit();
  }
}
