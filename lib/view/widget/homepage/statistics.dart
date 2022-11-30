import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/list_rdvs_controller.dart';
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
          GetBuilder<ListRDVsController>(
              builder: (controller) => Visibility(
                  visible: !controller.loading,
                  child: Text('${controller.nbTotal}',
                      style: TextStyle(
                          color: AppColor.amber,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  replacement: CircularProgressIndicator.adaptive())),
          VerticalDividerWidget(color: AppColor.white),
          Text('Nombre de Consultations',
              style: TextStyle(color: AppColor.white, fontSize: 12)),
          GetBuilder<ListRDVsController>(
              builder: (controller) => Visibility(
                  visible: !controller.loading,
                  child: Text('${controller.nbconsult}',
                      style: TextStyle(
                          color: AppColor.greenClair,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  replacement: CircularProgressIndicator.adaptive())),
          VerticalDividerWidget(color: AppColor.white),
          Text('Nombre de Patient Restants',
              style: TextStyle(color: AppColor.white, fontSize: 12)),
          GetBuilder<ListRDVsController>(
              builder: (controller) => Visibility(
                  visible: !controller.loading,
                  child: Text('${controller.nbRdvs}',
                      style: TextStyle(
                          color: AppColor.orangeClaire,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  replacement: CircularProgressIndicator.adaptive()))
        ]));
  }
}
