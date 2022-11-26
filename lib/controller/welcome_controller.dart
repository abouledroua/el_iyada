import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constant/sizes.dart';

class WelcomeController extends GetxController {
  String msg = "Chargement ...";

  @override
  void onReady() {
    Timer(const Duration(seconds: 3), close);
    super.onReady();
  }

  updateMessage({required String newMsg}) {
    msg = newMsg;
    update();
  }

  close() {
    //  Get.offAllNamed(AppRoute.login);
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    //  AppData.reparerBDD(showToast: false);
    super.onInit();
  }
}
