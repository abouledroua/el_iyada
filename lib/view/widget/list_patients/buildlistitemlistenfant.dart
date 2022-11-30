// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../controller/list_patients_controller.dart';
import '../../../core/class/patient.dart';
import '../buildheaderlists.dart';

class BuildListItemListPatient extends StatelessWidget {
  final Patient item;
  const BuildListItemListPatient({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tag = item.getSuspensionTag();
    final offstage = !item.isShowSuspension;
    return Column(children: [
      Offstage(offstage: offstage, child: BuildHeaderLists(tag: tag)),
      ListTile(
          title: Text(item.name, style: Theme.of(context).textTheme.headline3),
          subtitle: Row(children: [
            Text("${item.ageS}",
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            Visibility(
                visible: item.tel.isNotEmpty,
                child: Text("  --  ${item.tel}",
                    style: const TextStyle(fontSize: 11)))
          ]),
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          onTap: () {
            ListPatientsController controller = Get.find();
            int i = controller.patients.indexOf(item);
            print("item:${item.name}, index =$i");
            // hide keyboard on start
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            //      Get.bottomSheet(BottomSheetWidgetListEnfant(ind: i),
            //         isScrollControlled: true,
            //        enterBottomSheetDuration: const Duration(milliseconds: 600),
            //       exitBottomSheetDuration: const Duration(milliseconds: 600));
          })
    ]);
  }
}
