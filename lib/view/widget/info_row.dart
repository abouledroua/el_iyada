import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/list_patients_controller.dart';
import '../../core/class/patient.dart';
import '../../core/constant/color.dart';

class InfoRow extends StatelessWidget {
  final String cb;
  const InfoRow({Key? key, required this.cb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        color: AppColor.yellowClaire,
        child: GetBuilder<ListPatientsController>(builder: (controller) {
          Patient patient = controller.searchPatientByCb(cb: cb);
          return Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Nom : ', style: Theme.of(context).textTheme.headline2),
                FittedBox(
                    child: Text(patient.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontWeight: FontWeight.normal))),
                Text("     --     ${patient.ageS}",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontWeight: FontWeight.normal))
              ]));
        }));
  }
}
