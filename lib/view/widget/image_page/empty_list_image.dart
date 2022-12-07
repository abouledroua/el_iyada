import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/page_docs_images_controller.dart';
import '../../../core/constant/color.dart';

class EmptyListImage extends StatelessWidget {
  const EmptyListImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageDocsImagesController controller = Get.find();
    return Container(
        color: AppColor.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                      controller.error
                          ? "Erreur de connexion !!!"
                          : "Aucune Image !!!!",
                      style: TextStyle(
                          fontSize: 22,
                          color: controller.error ? AppColor.red : AppColor.rdv,
                          fontWeight: FontWeight.bold))),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: AppColor.white,
                      backgroundColor: AppColor.rdv),
                  onPressed: () {
                    controller.getImages();
                  },
                  icon: const Icon(Icons.refresh, color: AppColor.white),
                  label: const Text("Actualiser"))
            ]));
  }
}
