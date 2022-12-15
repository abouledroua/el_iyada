import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/keyboard_controller.dart';
import '../../controller/list_patients_controller.dart';
import '../../core/constant/color.dart';
import '../../core/constant/sizes.dart';
import '../widget/homepage/statistics.dart';
import '../widget/mywidget.dart';
import 'list_patients.dart';

class SearchPatient extends StatelessWidget {
  const SearchPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListPatientsController controller = Get.find();
    controller.updateQuery("");
    print('AppSizes.widthScreen=${AppSizes.widthScreen}');
    return MyWidget(
        title: "Rechercher un Patient",
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(children: [
              Spacer(),
              GetBuilder<ListPatientsController>(
                  builder: (controller) => Visibility(
                      visible: controller.filter,
                      child: Row(children: [
                        CircularProgressIndicator.adaptive(),
                        SizedBox(width: 20),
                        Text('Recherche en cours ...')
                      ]),
                      replacement: Center(
                        child: SizedBox(
                            width: AppSizes.widthScreen / 2,
                            child: TextFormField(
                                controller: controller.txtName,
                                maxLines: 1,
                                //     autofocus: true,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.search,
                                onFieldSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    controller.search();
                                    Get.to(() => ListPatients());
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: 'Nom du patient',
                                    hintStyle: const TextStyle(fontSize: 14),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    label: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 9),
                                        child: Text('Nom du patient')),
                                    suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                controller.updateQuery("");
                                              },
                                              icon: Icon(Icons.cancel_outlined,
                                                  color: AppColor.red)),
                                          IconButton(
                                              onPressed: () {
                                                if (controller
                                                    .txtName.text.isNotEmpty) {
                                                  controller.search();
                                                  Get.to(() => ListPatients());
                                                }
                                              },
                                              icon: Icon(Icons.search))
                                        ]),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColor.black),
                                        borderRadius:
                                            BorderRadius.circular(16))))),
                      ))),
              Spacer(),
              GetBuilder<KeyboardController>(
                  builder: (controller) => Visibility(
                      visible: !controller.keyboadrShow,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: AppColor.white,
                              backgroundColor: AppColor.black),
                          onPressed: () async {
                            ListPatientsController contr = Get.find();
                            contr.captuerCodeBarre(context);
                          },
                          icon: Icon(Icons.camera),
                          label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Capturer le code barre du patient",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: AppColor.white)))))),
              Spacer(),
              GetBuilder<KeyboardController>(
                  builder: (controller) => Visibility(
                      visible: !controller.keyboadrShow, child: Statistics()))
            ])));
  }
}
