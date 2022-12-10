import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/liste_ordonnances_controller.dart';
import '../../core/constant/color.dart';
import '../widget/info_row.dart';
import '../widget/list_ordonnances/empty_list_ordonnance.dart';
import '../widget/list_ordonnances/list_ordonnances_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/mywidget.dart';

class PageListOrdonnances extends StatelessWidget {
  final String cb;
  const PageListOrdonnances({Key? key, required this.cb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ListOrdonnanceController(cb: cb));
    return MyWidget(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: AppColor.white)),
        actions: [
          IconButton(
              onPressed: () {
                ListOrdonnanceController contr = Get.find();
                contr.getOrdonnances();
              },
              icon: Icon(Icons.refresh, color: AppColor.white))
        ],
        title: "Liste des Ordonnances",
        titleColor: AppColor.white,
        color: AppColor.ordonnance,
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(children: [
              InfoRow(cb: cb),
              Divider(thickness: 1),
              Expanded(
                  child: GetBuilder<ListOrdonnanceController>(
                      builder: (controller) => Visibility(
                          visible: controller.loading,
                          replacement: Visibility(
                              visible: controller.listConsult.isEmpty,
                              replacement: ListOrdonnancesWidget(),
                              child: Center(child: EmptyListOrdonnance())),
                          child: const LoadingWidget()))),
              SizedBox(height: 6)
            ])));
  }
}
