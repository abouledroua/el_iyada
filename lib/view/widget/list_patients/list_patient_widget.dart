// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/list_patients_controller.dart';
import 'list_view_patient.dart';

class ListPatientWidget extends StatelessWidget {
  const ListPatientWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListPatientsController>(
        builder: (controller) => Column(children: [
              TextFormField(
                  initialValue: controller.query,
                  onChanged: (value) {
                    controller.updateQuery(value);
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Recherche",
                      prefixIcon: const Icon(Icons.search))),
              const Expanded(child: ListViewPatients())
            ]));
  }
}
