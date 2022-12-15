// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/liste_bilans_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';
import '../loading_widget.dart';
import '../vertical_divider_widget.dart';
import 'empty_list_details_bilan.dart';

class ListBilansWidget extends StatelessWidget {
  const ListBilansWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListBilanController>(builder: (controller) {
      return RefreshIndicator(
          onRefresh: controller.getBilans,
          child: Row(children: [
            listDates(context, controller),
            VerticalDividerWidget(
                height: AppSizes.heightScreen / 2, color: AppColor.greyblack),
            Expanded(child: listDetails(context, controller))
          ]));
    });
  }

  listDetails(BuildContext context, ListBilanController controller) =>
      Column(children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: FittedBox(
                child: Text(
                    'Liste des Bilans ${controller.listDetailsBilan.isEmpty ? '' : '(${controller.listDetailsBilan.length})'}',
                    style: Theme.of(context).textTheme.headline3))),
        Divider(),
        Expanded(
            child: Visibility(
                visible: controller.loadingDetails,
                replacement: Visibility(
                    visible: controller.listDetailsBilan.isEmpty,
                    replacement: ListView.builder(
                        itemCount: controller.listDetailsBilan.length,
                        itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                                "${index + 1} - ${controller.listDetailsBilan[index].designation}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(fontWeight: FontWeight.normal)))),
                    child: const EmptyListDetailsBilan()),
                child: const LoadingWidget()))
      ]);

  listDates(BuildContext context, ListBilanController controller) => SizedBox(
      width: 130,
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: FittedBox(
                child: Text('Dates',
                    style: Theme.of(context).textTheme.headline3))),
        Divider(),
        Expanded(
            child: ListView.builder(
                itemCount: controller.listConsult.length,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (!controller.loadingDetails) {
                        controller.updateSelectionDate(index);
                      }
                    },
                    child: Ink(
                        child: Container(
                            decoration: BoxDecoration(
                                color: controller.indexSelected == index
                                    ? AppColor.bilans
                                    : Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                            padding: EdgeInsets.all(8),
                            child: Center(
                                child: Text(
                                    controller.listConsult[index].date_consult,
                                    style: controller.indexSelected == index
                                        ? Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(color: AppColor.white)
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyLarge)))))))
      ]));
}
