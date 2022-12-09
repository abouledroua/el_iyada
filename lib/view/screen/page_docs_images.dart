import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/keyboard_controller.dart';
import '../../controller/list_patients_controller.dart';
import '../../controller/page_docs_images_controller.dart';
import '../../core/class/patient.dart';
import '../../core/constant/color.dart';
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
        actions: [
          IconButton(
              onPressed: () {
                PageDocsImagesController contr = Get.find();
                contr.addImage();
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                PageDocsImagesController contr = Get.find();
                contr.getImages();
              },
              icon: Icon(Icons.refresh))
        ],
        title: "Documents & Imageries",
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(children: [
              infoRow(context: context),
              Divider(thickness: 1),
              Expanded(child: espaceTravail(context: context)),
              Divider(thickness: 1),
              GetBuilder<KeyboardController>(
                  builder: (controller) => Visibility(
                      visible: !controller.keyboadrShow,
                      child: MenuDocsImages())),
              SizedBox(height: 6)
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

  infoRow({required BuildContext context}) => Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      color: AppColor.yellowClaire,
      child: GetBuilder<ListPatientsController>(builder: (controller) {
        Patient patient = controller.searchPatientByCb(cb: cb);
        return Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text('Nom : ', style: Theme.of(context).textTheme.headline2),
              FittedBox(
                  child: Text(patient.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontWeight: FontWeight.normal)))
            ]));
      }));
}
