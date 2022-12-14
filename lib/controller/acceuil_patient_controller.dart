// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constant/sizes.dart';

class AcceilPatientController extends GetxController {
  late String cb;

  AcceilPatientController({required String cb}) {
    this.cb = cb;
  }

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    super.onInit();
  }
}
