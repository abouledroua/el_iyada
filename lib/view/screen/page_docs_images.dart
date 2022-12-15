import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/keyboard_controller.dart';
import '../../controller/page_docs_images_controller.dart';
import '../../core/constant/color.dart';
import '../widget/bottom_bar_upload_images_widget.dart';
import '../widget/info_row.dart';
import 'image_patient_view.dart';
import '../widget/docs&images/menu_docs_images.dart';
import '../widget/mywidget.dart';

class PageDocsImages extends StatelessWidget {
  final String cb;
  const PageDocsImages({Key? key, required this.cb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PageDocsImagesController(cb: cb));
    return MyWidget(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: AppColor.white)),
        actions: [
          IconButton(
              onPressed: () {
                PageDocsImagesController contr = Get.find();
                contr.addImage();
              },
              icon: Icon(Icons.upload, color: AppColor.white)),
          IconButton(
              onPressed: () {
                LaunchApp.openApp(
                    androidPackageName: 'com.android.chrome', openStore: true);
              },
              icon: Icon(Icons.image_search_outlined, color: AppColor.white)),
          IconButton(
              onPressed: () {
                PageDocsImagesController contr = Get.find();
                contr.getImages();
              },
              icon: Icon(Icons.refresh, color: AppColor.white))
        ],
        title: "Documents & Imageries Médical",
        titleColor: AppColor.white,
        color: AppColor.imagerie,
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(children: [
              InfoRow(cb: cb),
              Divider(thickness: 1),
              Expanded(child: espaceTravail(context: context)),
              Divider(thickness: 1),
              GetBuilder<KeyboardController>(
                  builder: (controller) => Visibility(
                      visible: !controller.keyboadrShow,
                      child: MenuDocsImages())),
              SizedBox(height: 3),
              BottomBarUploadImagesWidget(),
            ])));
  }

  espaceTravail({required BuildContext context}) =>
      GetBuilder<PageDocsImagesController>(
          builder: (controller) => Visibility(
              visible: controller.page == 1,
              child: ImagePatientView(cb: cb, type: 1),
              replacement: Visibility(
                  visible: controller.page == 2,
                  child: ImagePatientView(cb: cb, type: 4),
                  replacement: Visibility(
                      visible: controller.page == 3,
                      child: ImagePatientView(cb: cb, type: 2),
                      replacement: ImagePatientView(cb: cb, type: 3)))));
}
