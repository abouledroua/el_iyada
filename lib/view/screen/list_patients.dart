import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/list_patients_controller.dart';
import '../widget/list_patients/empty_list_patient.dart';
import '../widget/list_patients/list_view_patient.dart';
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
              FocusScope.of(context).unfocus();
            },
            child: GetBuilder<ListPatientsController>(
                builder: (controller) => Visibility(
                    visible: controller.loading,
                    replacement: Visibility(
                        visible: controller.patientsList.isEmpty,
                        replacement: const ListViewPatients(),
                        child: const EmptyListPatient()),
                    child: const LoadingWidget()))));
  }
}
