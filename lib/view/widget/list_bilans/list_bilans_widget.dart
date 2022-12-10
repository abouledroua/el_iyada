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
                child: Text('Liste des Bilans',
                    style: Theme.of(context).textTheme.headline3))),
        Divider(),
        Expanded(
            child: Visibility(
                visible: controller.loadingDetails,
                replacement: Visibility(
                    visible: controller.listDetailsBilan.isEmpty,
                    replacement: ListView.builder(
                        itemCount: controller.listDetailsBilan.length,
                        itemBuilder: (context, index) => ListTile(
                            contentPadding: EdgeInsets.all(0),
                            horizontalTitleGap: 0,
                            minLeadingWidth: 0,
                            title: Text(
                                "${index + 1} - ${controller.listDetailsBilan[index].designation}",
                                style: Theme.of(context).textTheme.bodyLarge))),
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
                      controller.updateSelectionDate(index);
                    },
                    child: Ink(
                        padding: EdgeInsets.all(8),
                        color: controller.indexSelected == index
                            ? AppColor.bilans
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
