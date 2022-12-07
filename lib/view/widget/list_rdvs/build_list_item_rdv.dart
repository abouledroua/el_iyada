// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../controller/list_rdvs_controller.dart';
import '../../../core/class/rdv.dart';
import '../../../core/constant/color.dart';
import '../../screen/acceuil_patient.dart';

class BuildListItemListRDV extends StatelessWidget {
  final RDV item;
  const BuildListItemListRDV({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
          tileColor: item.numReq == 1
              ? AppColor.greenClair
              : item.heure_arrivee == ""
                  ? AppColor.redClair
                  : AppColor.yellowClaire,
          title: Text(item.name,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: item.sexe == 2 ? AppColor.pink : AppColor.black)),
          trailing: Text(item.heure_arrivee,
              style: Theme.of(context).textTheme.bodyText1),
          subtitle: Row(children: [
            Text("${item.ageS}",
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            if (item.motif.isNotEmpty)
              Text("  --  ${item.motif}", style: const TextStyle(fontSize: 11))
          ]),
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          onTap: () {
            ListRDVsController controller = Get.find();
            int i = controller.rdvs.indexOf(item);
            print("item:${item.name}, index =$i");
            // hide keyboard on start
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            Get.to(() => AcceuilPatient(cb: item.cb));
          })
    ]);
  }
}
