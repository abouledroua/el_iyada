// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/page_docs_images_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListECGWidget extends StatelessWidget {
  const ListECGWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageDocsImagesController>(
        builder: (controller) => RefreshIndicator(
            onRefresh: controller.getImages,
            child: Wrap(
                children: controller.ecg
                    .map((item) {
                      ImageProvider<Object> image = CachedNetworkImageProvider(
                          AppData.getImage(item.chemin, "GALLERY"));
                      return GestureDetector(
                          onTap: () {
                            //    int i = controller.allPhotos.indexOf(item);
                            //   Get.to(() => PhotoViewPage(
                            //      titleAnnonce: "",
                            //     index: i,
                            //    folder: "GALLERY",
                            //   myImages: controller.allPhotos,
                            //  delete: !User.isParent));
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.contain, image: image),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: AppColor.greyShade)),
                                  height: 100,
                                  width: 100)));
                    })
                    .toList()
                    .cast<Widget>())));
  }
}
