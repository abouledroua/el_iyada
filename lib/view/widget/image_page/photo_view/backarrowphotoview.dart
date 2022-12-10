import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/photoview_controller.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/constant/sizes.dart';

class BackArrowButtonPhotoView extends StatelessWidget {
  const BackArrowButtonPhotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPhotoViewController>(
        builder: (controller) => Visibility(
            visible: (controller.index > 0),
            child: Positioned(
                top: AppSizes.heightScreen / 2,
                left: 0,
                child: InkWell(
                    onTap: () {
                      MyPhotoViewController controller = Get.find();
                      controller.updateIndex(controller.index - 1);
                    },
                    child: Ink(
                        color: AppColor.black,
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            size: AppSizes.heightScreen / 15,
                            color: AppColor.white))))));
  }
}
