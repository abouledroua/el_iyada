// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/welcome_controller.dart';
import '../../core/constant/image_asset.dart';
import '../../core/constant/sizes.dart';
import '../widget/mywidget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(WelcomeController());
    return MyWidget(child: OrientationBuilder(builder: (context, orientation) {
      print(orientation);
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
                child: SizedBox(
                    height: AppSizes.heightScreen / 2,
                    child: Image.asset(AppImageAsset.logo, fit: BoxFit.cover))),
            Center(
                child: GetBuilder<WelcomeController>(
                    builder: (controller) => Text(controller.msg,
                        style: Theme.of(context).textTheme.headline2)))
          ]);
    }));
  }
}
