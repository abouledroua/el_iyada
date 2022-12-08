import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/page_docs_images_controller.dart';
import '../widget/image_page/empty_list_image.dart';
import '../widget/image_page/list_image_widget.dart';
import '../widget/loading_widget.dart';

class ImagePatientView extends StatelessWidget {
  final String cb;
  final int type;
  const ImagePatientView({Key? key, required this.cb, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageDocsImagesController>(builder: (controller) {
      bool empty = false;
      switch (type) {
        case 1:
          empty = controller.echo.isEmpty;
          break;
        case 2:
          empty = controller.ecg.isEmpty;
          break;
        case 3:
          empty = controller.docs.isEmpty;
          break;
        case 4:
          empty = controller.radio.isEmpty;
          break;
      }
      return Visibility(
          visible: controller.loading,
          replacement: Visibility(
              visible: empty,
              replacement: ListImagesWidget(type: type),
              child: const EmptyListImage()),
          child: const LoadingWidget());
    });
  }
}
