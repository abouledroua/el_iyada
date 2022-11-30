import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/list_patients_controller.dart';
import '../../../core/constant/color.dart';

class EmptyListPatient extends StatelessWidget {
  const EmptyListPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListPatientsController controller = Get.find();
    return Container(
        color: AppColor.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                      controller.error
                          ? "Erreur de connexion !!!"
                          : "Aucun Patient !!!!",
                      style: TextStyle(
                          fontSize: 22,
                          color:
                              controller.error ? AppColor.red : AppColor.green,
                          fontWeight: FontWeight.bold))),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: AppColor.white,
                      backgroundColor: AppColor.patient),
                  onPressed: () {
                    controller.getPatient();
                  },
                  icon: const Icon(Icons.refresh, color: AppColor.white),
                  label: const Text("Actualiser"))
            ]));
  }
}
