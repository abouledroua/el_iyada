import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/page_docs_images_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';

class MenuDocsImages extends StatelessWidget {
  const MenuDocsImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageDocsImagesController>(
        builder: (controller) => Container(
            height: AppSizes.heightScreen / 7,
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              SizedBox(width: 10),
              myBtn(
                  index: 1,
                  text: 'Echographie (${controller.echo.length})',
                  context: context),
              SizedBox(width: 10),
              myBtn(
                  index: 2,
                  text: 'Radiologie (${controller.radio.length})',
                  context: context),
              SizedBox(width: 10),
              myBtn(
                  index: 3,
                  text: 'ECG (${controller.ecg.length})',
                  context: context),
              SizedBox(width: 10),
              myBtn(
                  index: 4,
                  text: 'Documents (${controller.docs.length})',
                  context: context),
              SizedBox(width: 10)
            ])));
  }

  myBtn(
      {required String text,
      required int index,
      required BuildContext context}) {
    return GetBuilder<PageDocsImagesController>(
        builder: (controller) => Expanded(
            child: InkWell(
                onTap: () {
                  controller.updatePage(index);
                },
                child: Ink(
                    color: controller.page == index
                        ? AppColor.imagerie
                        : AppColor.grey.withOpacity(0.6),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    child: FittedBox(
                        child: Text(text,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontWeight: controller.page == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: controller.page == index
                                        ? AppColor.white
                                        : AppColor.greyblack)))))));
  }
}
