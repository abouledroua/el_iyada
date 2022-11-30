// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constant/sizes.dart';

class HomePageController extends GetxController {
  int page = 1;

  updatePage({required int newPage}) {
    page = newPage;
    update();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    super.onInit();
  }
}
