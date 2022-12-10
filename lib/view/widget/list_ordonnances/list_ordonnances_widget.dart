// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/liste_ordonnances_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';
import '../loading_widget.dart';
import '../vertical_divider_widget.dart';
import 'empty_list_prescription.dart';

class ListOrdonnancesWidget extends StatelessWidget {
  const ListOrdonnancesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListOrdonnanceController>(builder: (controller) {
      return RefreshIndicator(
          onRefresh: controller.getOrdonnances,
          child: Row(children: [
            listDates(context, controller),
            VerticalDividerWidget(
                height: AppSizes.heightScreen / 2, color: AppColor.greyblack),
            Expanded(child: listDetails(context, controller))
          ]));
    });
  }

  listDetails(BuildContext context, ListOrdonnanceController controller) =>
      Column(children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: FittedBox(
                child: Text('Préscription',
                    style: Theme.of(context).textTheme.headline3))),
        Divider(),
        Expanded(
            child: Visibility(
                visible: controller.loadingDetails,
                replacement: Visibility(
                    visible: controller.listDetailsOrdonnance.isEmpty,
                    replacement: ListView.builder(
                        itemCount: controller.listDetailsOrdonnance.length,
                        itemBuilder: (context, index) => ListTile(
                            contentPadding: EdgeInsets.all(0),
                            horizontalTitleGap: 0,
                            minLeadingWidth: 0,
                            title: Text(
                                "${index + 1} - ${controller.listDetailsOrdonnance[index].prescription}",
                                style: Theme.of(context).textTheme.bodyLarge))),
                    child: const EmptyListPrescription()),
                child: const LoadingWidget()))
      ]);

  listDates(BuildContext context, ListOrdonnanceController controller) =>
      SizedBox(
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
                          controller.updateSelectionDate(index);
                        },
                        child: Ink(
                            padding: EdgeInsets.all(8),
                            color: controller.indexSelected == index
                                ? AppColor.ordonnance
                                : Colors.transparent,
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
                                            .bodyLarge))))))
          ]));
}
