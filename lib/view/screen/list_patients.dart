import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/list_patients_controller.dart';
import '../widget/list_patients/empty_list_patient.dart';
import '../widget/list_patients/list_patient_widget.dart';
import '../widget/loadingwidget.dart';
import '../widget/mywidget.dart';

class ListPatients extends StatelessWidget {
  const ListPatients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyWidget(
        //   drawer: AppData.myDrawer(context),
        //  actions: controller.myActions(),
        title: "Liste des Patients",
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: GetBuilder<ListPatientsController>(
              builder: (controller) => Visibility(
                  visible: controller.loading,
                  replacement: Visibility(
                      visible: controller.patients.isEmpty,
                      replacement: const ListPatientWidget(),
                      child: const EmptyListPatient()),
                  child: const LoadingWidget())),
        ));
  }
}
