import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/page_docs_images_controller.dart';
import '../widget/image_page/empty_list_image.dart';
import '../widget/image_page/list_ecg_widget.dart';
import '../widget/loading_widget.dart';

class EcgPatientView extends StatelessWidget {
  final String cb;
  const EcgPatientView({Key? key, required this.cb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageDocsImagesController>(
        builder: (controller) => Visibility(
            visible: controller.loading,
            replacement: Visibility(
                visible: controller.ecg.isEmpty,
                replacement: const ListECGWidget(),
                child: const EmptyListImage()),
            child: const LoadingWidget()));
  }
}
