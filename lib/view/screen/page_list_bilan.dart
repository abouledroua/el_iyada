import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/liste_bilans_controller.dart';
import '../../core/constant/color.dart';
import '../widget/info_row.dart';
import '../widget/list_bilans/empty_list_bilan.dart';
import '../widget/list_bilans/list_bilans_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/mywidget.dart';

class PageListBilans extends StatelessWidget {
  final String cb;
  const PageListBilans({Key? key, required this.cb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ListBilanController(cb: cb));
    return MyWidget(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: AppColor.white)),
        actions: [
          IconButton(
              onPressed: () {
                ListBilanController contr = Get.find();
                contr.getBilans();
              },
              icon: Icon(Icons.refresh, color: AppColor.white))
        ],
        title: "Liste des Bilans",
        titleColor: AppColor.white,
        color: AppColor.bilans,
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(children: [
              InfoRow(cb: cb),
              Divider(thickness: 1),
              Expanded(
                  child: GetBuilder<ListBilanController>(
                      builder: (controller) => Visibility(
                          visible: controller.loading,
                          replacement: Visibility(
                              visible: controller.listConsult.isEmpty,
                              replacement: ListBilansWidget(),
                              child: Center(child: EmptyListBilan())),
                          child: const LoadingWidget()))),
              SizedBox(height: 6)
            ])));
  }
}
