// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';

class WelcomeController extends GetxController {
  String msg = "";

  updateMessage({required String newMsg}) {
    msg = newMsg;
    update();
  }

  close() {
    //  Get.offAllNamed(AppRoute.login);
  }

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    updateMessage(newMsg: 'Connection en cours ...');
    await AppData.getListPatient().then((value) {
      if (value) {
        updateMessage(newMsg: 'Chargement en cours ...');
      }
    });
    //  AppData.reparerBDD(showToast: false);
    super.onInit();
  }
}
