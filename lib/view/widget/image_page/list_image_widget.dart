// ignore_for_file: avoid_print

import 'package:el_iyada/core/constant/color.dart';
import 'package:el_iyada/core/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/page_docs_images_controller.dart';
import '../../../core/class/image.dart';

class ListImagesWidget extends StatelessWidget {
  final int type;
  const ListImagesWidget({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageDocsImagesController>(builder: (controller) {
      List<MyImage> listImage = (type == 1)
          ? controller.echo
          : (type == 2)
              ? controller.ecg
              : (type == 3)
                  ? controller.docs
                  : controller.radio;
      return RefreshIndicator(
          onRefresh: controller.getImages,
          child: ListView(children: [
            Wrap(
                children: listImage
                    .map((item) {
                      double espace = 10;
                      int nbImage = 4;
                      double width =
                          (AppSizes.widthScreen - (espace * nbImage * 2)) /
                              nbImage;
                      return GestureDetector(
                          onTap: () {},
                          child: Padding(
                              padding: EdgeInsets.all(espace),
                              child: Container(
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      color: item.etat == 1
                                          ? AppColor.grey
                                          : AppColor.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 199, 196, 196))),
                                  height: AppSizes.heightScreen / 3,
                                  width: width,
                                  child: Visibility(
                                      visible: item.loading,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: CircularProgressIndicator
                                                  .adaptive())),
                                      replacement: Stack(children: [
                                        Center(child: Image.memory(item.data)),
                                        if (item.etat == 1)
                                          Positioned(
                                              top: -3,
                                              right: -3,
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  width: width / 9,
                                                  height: width / 9,
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive()))
                                      ])))));
                    })
                    .toList()
                    .cast<Widget>())
          ]));
    });
  }
}
