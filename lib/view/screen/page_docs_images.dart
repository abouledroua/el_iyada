import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/keyboard_controller.dart';
import '../../controller/list_patients_controller.dart';
import '../../controller/page_docs_images_controller.dart';
import '../../core/class/patient.dart';
import '../../core/constant/color.dart';
import '../../view/screen/ecg_patient_view.dart';
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
                      child: MenuDocsImages()))
            ])));
  }

  espaceTravail({required BuildContext context}) =>
      GetBuilder<PageDocsImagesController>(
          builder: (controller) => Visibility(
              visible: controller.page == 1,
              child: Text('page echographie'),
              replacement: Visibility(
                  visible: controller.page == 2,
                  child: Text('page radiologie'),
                  replacement: Visibility(
                      visible: controller.page == 3,
                      child: EcgPatientView(cb: cb),
                      replacement: Text('page des documents')))));

  infoRow({required BuildContext context}) => Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      color: AppColor.yellowClaire,
      child: GetBuilder<ListPatientsController>(builder: (controller) {
        Patient patient = controller.searchPatientByCb(cb: cb);
        return Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text('Nom : ', style: Theme.of(context).textTheme.headline1),
              FittedBox(
                  child: Text(patient.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontWeight: FontWeight.normal)))
            ]));
      }));
}
