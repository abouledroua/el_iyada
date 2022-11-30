// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/list_rdvs_controller.dart';
import '../../../core/class/rdv.dart';
import 'build_list_item_rdv.dart';

class ListRDVWidget extends StatelessWidget {
  const ListRDVWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListRDVsController>(builder: (controller) {
      List<RDV> items = controller.rdvs;
      return RefreshIndicator(
          onRefresh: controller.getListRdvToday,
          child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, i) {
                RDV item = items[i];
                if ((controller.query.isEmpty) ||
                    (item.name
                        .toUpperCase()
                        .contains(controller.query.toUpperCase()))) {
                  return BuildListItemListRDV(item: item);
                } else {
                  return Container();
                }
              }));
    });
  }
}
