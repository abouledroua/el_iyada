// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/sizes.dart';
import '../../controller/gest_photos_controller.dart';

class BottomBarUploadImagesWidget extends StatelessWidget {
  const BottomBarUploadImagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetBuilder<GestImagesController>(
      builder: (controller) => Visibility(
          visible: controller.myImages.isNotEmpty,
          child: Container(
              height: AppSizes.heightScreen / 10,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                  'Envoi de ${controller.nbImages} image(s) en cours ....',
                  style: Theme.of(context).textTheme.bodyLarge))));
}
