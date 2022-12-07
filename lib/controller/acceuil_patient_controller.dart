// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/class/patient.dart';
import '../core/constant/sizes.dart';

class AcceilPatientController extends GetxController {
  String msg = "";
  late Patient patient;
  late String cb;
  bool serverError = false;

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
