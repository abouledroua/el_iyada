// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/photoview_controller.dart';
import '../../../../core/class/my_image.dart';
import '../../../../core/constant/color.dart';

class BottomPagePhotoView extends StatelessWidget {
  final List<MyImage> myImages;
  const BottomPagePhotoView({Key? key, required this.myImages})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GetBuilder<MyPhotoViewController>(
      builder: (controller) => Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          color: AppColor.black,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            InkWell(
                onTap: () {
                  controller.subQuarter();
                },
                child: Ink(
                    child: Row(children: const [
                  Text("Tourner", style: TextStyle(color: AppColor.white)),
                  Icon(Icons.rotate_left, color: AppColor.white)
                ]))),
            Text("Photo ${controller.index + 1} / ${myImages.length}",
                style: const TextStyle(color: AppColor.white)),
            InkWell(
                onTap: () {
                  controller.addQuarter();
                },
                child: Ink(
                    child: Row(children: const [
                  Text("Tourner", style: TextStyle(color: AppColor.white)),
                  Icon(Icons.rotate_right, color: AppColor.white)
                ])))
          ])));
}
