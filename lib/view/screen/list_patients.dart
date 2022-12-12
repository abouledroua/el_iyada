import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/list_patients_controller.dart';
import '../widget/list_patients/empty_list_patient.dart';
import '../widget/list_patients/list_view_patient.dart';
import '../widget/loading_widget.dart';
import '../widget/mywidget.dart';

class ListPatients extends StatelessWidget {
  const ListPatients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyWidget(
        leading: IconButton(
            onPressed: () {
              ListPatientsController contr = Get.find();
              contr.onWillPop();
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                ListPatientsController contr = Get.find();
                contr.captuerCodeBarre(context);
              },
              icon: Icon(Icons.camera)),
          IconButton(
              onPressed: () {
                ListPatientsController contr = Get.find();
                contr.widgetListPatientOpen = false;
                contr.getPatient();
                contr.widgetListPatientOpen = true;
              },
              icon: Icon(Icons.refresh))
        ],
        title: "Liste des Patients",
        child: GestureDetector(onTap: () {
          FocusScope.of(context).unfocus();
        }, child: GetBuilder<ListPatientsController>(builder: (controller) {
          controller.widgetListPatientOpen = true;
          return WillPopScope(
              onWillPop: controller.onWillPop,
              child: Visibility(
                  visible: controller.loading,
                  replacement: Visibility(
                      visible: controller.patientsList.isEmpty,
                      replacement: const ListViewPatients(),
                      child: const EmptyListPatient()),
                  child: Center(child: const LoadingWidget())));
        })));
  }
}
