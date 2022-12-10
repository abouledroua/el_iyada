import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/liste_bilans_controller.dart';
import '../../../core/constant/color.dart';

class EmptyListDetailsBilan extends StatelessWidget {
  const EmptyListDetailsBilan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListBilanController controller = Get.find();
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              controller.error ? "Erreur de connexion !!!" : "Aucun Bilan !!!!",
              style: TextStyle(
                  fontSize: 22,
                  color: controller.error ? AppColor.red : AppColor.rdv,
                  fontWeight: FontWeight.bold)),
          if (controller.error) SizedBox(height: 10),
          if (controller.error)
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    foregroundColor: AppColor.white,
                    backgroundColor: AppColor.rdv),
                onPressed: () {
                  controller.getBilans();
                },
                icon: const Icon(Icons.refresh, color: AppColor.white),
                label: const Text("Actualiser"))
        ]);
  }
}
