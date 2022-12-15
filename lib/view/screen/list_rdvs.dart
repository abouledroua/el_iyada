import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/keyboard_controller.dart';
import '../../controller/list_patients_controller.dart';
import '../../controller/list_rdvs_controller.dart';
import '../widget/homepage/statistics.dart';
import '../widget/list_rdvs/empty_list_rdv.dart';
import '../widget/list_rdvs/list_rdv_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/mywidget.dart';
import 'search_patient.dart';

class ListRDVs extends StatelessWidget {
  const ListRDVs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyWidget(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.open_in_browser)),
          IconButton(
              onPressed: () {
                ListPatientsController contr = Get.find();
                contr.captuerCodeBarre(context);
              },
              icon: Icon(Icons.camera)),
          IconButton(
              onPressed: () {
                Get.to(() => SearchPatient());
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                ListRDVsController controller = Get.find();
                controller.getListRdvToday();
                ListPatientsController contr = Get.find();
                contr.getPatient();
              },
              icon: Icon(Icons.refresh))
        ],
        title: "Liste des Rendez-vous",
        child: GetBuilder<ListRDVsController>(
            builder: (controller) => WillPopScope(
                onWillPop: controller.onWillPop,
                child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Column(children: [
                      Expanded(
                          child: Visibility(
                              visible: controller.loading,
                              replacement: Visibility(
                                  visible: controller.rdvs.isEmpty,
                                  replacement: const ListRDVWidget(),
                                  child: const EmptyListRDV()),
                              child: const LoadingWidget())),
                      GetBuilder<KeyboardController>(
                          builder: (controller) => Visibility(
                              visible: !controller.keyboadrShow,
                              child: Statistics()))
                    ])))));
  }
}
