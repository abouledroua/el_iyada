import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';
import '../vertical_divider_widget.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColor.blue1),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text('Nombre de Rendez-vous',
              style: TextStyle(color: AppColor.white, fontSize: 12)),
          Text('1028',
              style: TextStyle(
                  color: AppColor.amber,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          VerticalDividerWidget(color: AppColor.white),
          Text('Nombre de Consultations',
              style: TextStyle(color: AppColor.white, fontSize: 10)),
          Text('1028',
              style: TextStyle(
                  color: AppColor.greenClair,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          VerticalDividerWidget(color: AppColor.white),
          Text('Nombre de Patient Restants',
              style: TextStyle(color: AppColor.white, fontSize: 10)),
          Text('1028',
              style: TextStyle(
                  color: AppColor.brown,
                  fontSize: 20,
                  fontWeight: FontWeight.bold))
        ]));
  }
}
