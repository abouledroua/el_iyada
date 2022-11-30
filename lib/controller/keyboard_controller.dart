// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constant/sizes.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:async';

class KeyboardController extends GetxController {
  late StreamSubscription<bool> keyboardSubscription;
  bool keyboadrShow = false;
  late KeyboardVisibilityController keyboardVisibilityController;

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    keyboardVisibilityController = KeyboardVisibilityController();
    keyboadrShow = keyboardVisibilityController.isVisible;
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      keyboadrShow = visible;
      print('Keyboard visibility update. Is visible: $visible');
      update();
    });
    super.onInit();
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }
}
