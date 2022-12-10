import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/photoview_controller.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/constant/sizes.dart';

class NextArrowButtonPhotoView extends StatelessWidget {
  final int nbImages;
  const NextArrowButtonPhotoView({Key? key, required this.nbImages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPhotoViewController>(
        builder: (controller) => Visibility(
            visible: (controller.index < nbImages - 1),
            child: Positioned(
                top: AppSizes.heightScreen / 2,
                right: 0,
                child: InkWell(
                    onTap: () {
                      MyPhotoViewController controller = Get.find();
                      controller.updateIndex(controller.index + 1);
                    },
                    child: Ink(
                        color: AppColor.black,
                        child: Icon(Icons.arrow_forward_ios_rounded,
                            size: AppSizes.heightScreen / 15,
                            color: AppColor.white))))));
  }
}
