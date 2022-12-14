// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/liste_ordonnances_controller.dart';
import '../../../core/class/consultations.dart';
import '../../../core/class/details_ordonnance.dart';
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

  listDetails(BuildContext context, ListOrdonnanceController controller) {
    Consultation item = controller.listConsult[controller.indexSelected];
    List<DetailsOrdonnance> listOrd =
        controller.ab == 1 ? controller.listOrdA : controller.listOrdB;
    return Column(children: [
      Visibility(
          visible: item.typeConv == 1,
          child: FittedBox(
              child: Text(
                  'Préscription  ${listOrd.isEmpty ? '' : '(${listOrd.length})'}',
                  style: Theme.of(context).textTheme.headline3)),
          replacement: Column(children: [
            FittedBox(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                        controller.ab == 1
                            ? "Prescriptions relatives au traitement de l'affection de longue durée reconnue"
                            : "Prescriptions SANS RAPPORT avec l'affection de longue durée"
                                '${listOrd.isEmpty ? '' : '(${listOrd.length})'}',
                        style: Theme.of(context).textTheme.headline3))),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: AppColor.white,
                      backgroundColor: controller.ab == 1
                          ? AppColor.pink
                          : AppColor.grey.withOpacity(0.4)),
                  onPressed: () {
                    controller.updateAB(newIndex: 1);
                  },
                  child: Text('A')),
              SizedBox(width: 25),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: AppColor.white,
                      backgroundColor: controller.ab == 2
                          ? AppColor.pink
                          : AppColor.grey.withOpacity(0.4)),
                  onPressed: () {
                    controller.updateAB(newIndex: 2);
                  },
                  child: Text('B'))
            ])
          ])),
      Divider(),
      Expanded(
          child: Visibility(
              visible: (controller.loadingDetailsA && controller.ab == 1) ||
                  (controller.loadingDetailsB && controller.ab == 2),
              replacement: Visibility(
                  visible: listOrd.isEmpty,
                  replacement: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: listOrd.length,
                      itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                              "${index + 1} - ${listOrd[index].prescription}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(fontWeight: FontWeight.normal)))),
                  child: const EmptyListPrescription()),
              child: const LoadingWidget()))
    ]);
  }

  listDates(BuildContext context, ListOrdonnanceController controller) =>
      SizedBox(
          width: 170,
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
                            child: Container(
                                decoration: BoxDecoration(
                                    color: controller.indexSelected == index
                                        ? AppColor.ordonnance
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15))),
                                padding: EdgeInsets.all(8),
                                child: Center(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                      if (controller
                                              .listConsult[index].typeConv ==
                                          2)
                                        Icon(Icons.double_arrow_rounded),
                                      if (controller
                                              .listConsult[index].typeConv ==
                                          2)
                                        SizedBox(width: 15),
                                      Text(
                                          controller
                                              .listConsult[index].date_consult,
                                          style:
                                              controller.indexSelected == index
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .headline3!
                                                      .copyWith(
                                                          color: AppColor.white)
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge)
                                    ])))))))
          ]));
}
