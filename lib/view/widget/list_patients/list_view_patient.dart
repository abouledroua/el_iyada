import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/list_patients_controller.dart';
import '../../../core/class/patient.dart';
import 'buildlistitemlistenfant.dart';

class ListViewPatients extends StatelessWidget {
  const ListViewPatients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListPatientsController>(builder: (controller) {
      List<Patient> items = controller.patients;
      return RefreshIndicator(
          onRefresh: controller.getPatient,
          child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, i) {
                Patient item = items[i];
                if ((controller.query.isEmpty) ||
                    (item.name
                        .toUpperCase()
                        .contains(controller.query.toUpperCase()))) {
                  return BuildListItemListPatient(item: item);
                } else {
                  return Container();
                }
              }));
    });
  }
}
