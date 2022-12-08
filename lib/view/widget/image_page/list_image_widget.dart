// ignore_for_file: avoid_print

import 'package:el_iyada/core/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../controller/page_docs_images_controller.dart';
import '../../../core/class/image.dart';

class ListImagesWidget extends StatelessWidget {
  final int type;
  const ListImagesWidget({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageDocsImagesController>(builder: (controller) {
      List<MyImage> listImage = [];
      List<Uint8List> listData = [];
      List<bool> listLoading = [];
      switch (type) {
        case 1:
          listImage = controller.echo;
          listLoading = controller.echoLoading;
          listData = controller.echoData;
          break;
        case 2:
          listImage = controller.ecg;
          listLoading = controller.ecgLoading;
          listData = controller.ecgData;
          break;
        case 3:
          listImage = controller.docs;
          listLoading = controller.docsLoading;
          listData = controller.docsData;
          break;
        case 4:
          listImage = controller.radio;
          listLoading = controller.radioLoading;
          listData = controller.radioData;
          break;
      }
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
                      int index = listImage.indexOf(item);
                      Uint8List imgData = listData[index];
                      bool loadingData = listLoading[index];
                      return GestureDetector(
                          onTap: () {},
                          child: Padding(
                              padding: EdgeInsets.all(espace),
                              child: Container(
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 199, 196, 196))),
                                  height: AppSizes.heightScreen / 3,
                                  width: width,
                                  child: Visibility(
                                      visible: loadingData,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: CircularProgressIndicator
                                                  .adaptive())),
                                      replacement: Image.memory(imgData)))));
                    })
                    .toList()
                    .cast<Widget>())
          ]));
    });
  }
}
