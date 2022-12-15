// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/photoview_controller.dart';
import '../../../../core/class/my_image.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/constant/sizes.dart';

class BottomHorizontalListPhotosPhotoView extends StatelessWidget {
  final List<MyImage> myImages;
  const BottomHorizontalListPhotosPhotoView({Key? key, required this.myImages})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GetBuilder<MyPhotoViewController>(
      builder: (controller) => Container(
          color: AppColor.black,
          width: double.infinity,
          child: Center(
              child: Container(
                  height: AppSizes.heightScreen / 10,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: myImages.length,
                      itemBuilder: (context, index) {
                        final double imageWidth = (AppSizes.widthScreen / 5) -
                            (4.0 * (myImages.length - 1));
                        final bool thisPhoto = (index == controller.index);
                        var data = myImages[index].data;
                        return GestureDetector(
                            onTap: () {
                              controller.updateIndex(index);
                            },
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: thisPhoto
                                                ? AppColor.amber
                                                : AppColor.white,
                                            width: thisPhoto ? 3 : 0.8)),
                                    width: imageWidth,
                                    child: Image.memory(data))));
                      })))));
}
