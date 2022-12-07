// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../controller/list_patients_controller.dart';
import '../../../core/class/patient.dart';
import '../../../core/constant/color.dart';
import '../../screen/acceuil_patient.dart';

class BuildListItemListPatient extends StatelessWidget {
  final Patient item;
  const BuildListItemListPatient({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
          title: Text(item.name,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: item.sexe == 2 ? AppColor.pink : AppColor.black)),
          trailing:
              Text(item.dateC, style: Theme.of(context).textTheme.bodyText1),
          subtitle: Row(children: [
            Text("${item.ageS}",
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            if (item.tel.isNotEmpty)
              Text("  --  ${item.tel}", style: const TextStyle(fontSize: 11))
          ]),
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          onTap: () {
            ListPatientsController controller = Get.find();
            int i = controller.patientsList.indexOf(item);
            print("item:${item.name}, index =$i, cb:${item.cb}");
            // hide keyboard on start
            SystemChannels.textInput.invokeMethod('TextInput.hide');

            Get.to(() => AcceuilPatient(cb: item.cb));
          })
    ]);
  }
}
