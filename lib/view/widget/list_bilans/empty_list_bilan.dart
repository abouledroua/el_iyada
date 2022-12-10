import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/liste_bilans_controller.dart';
import '../../../core/constant/color.dart';

class EmptyListBilan extends StatelessWidget {
  const EmptyListBilan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListBilanController controller = Get.find();
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
                          : "Aucun Bilan !!!!",
                      style: TextStyle(
                          fontSize: 22,
                          color: controller.error ? AppColor.red : AppColor.rdv,
                          fontWeight: FontWeight.bold))),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: AppColor.white,
                      backgroundColor: AppColor.rdv),
                  onPressed: () {
                    controller.getBilans();
                  },
                  icon: const Icon(Icons.refresh, color: AppColor.white),
                  label: const Text("Actualiser"))
            ]));
  }
}
