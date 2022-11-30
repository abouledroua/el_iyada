import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/list_rdvs_controller.dart';
import '../widget/list_rdvs/empty_list_rdv.dart';
import '../widget/list_rdvs/list_rdv_widget.dart';
import '../widget/loadingwidget.dart';
import '../widget/mywidget.dart';

class ListRDVs extends StatelessWidget {
  const ListRDVs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyWidget(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
        ],
        title: "Liste des Rendez-vous",
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: GetBuilder<ListRDVsController>(
                builder: (controller) => Visibility(
                    visible: controller.loading,
                    replacement: Visibility(
                        visible: controller.rdvs.isEmpty,
                        replacement: const ListRDVWidget(),
                        child: const EmptyListRDV()),
                    child: const LoadingWidget()))));
  }
}
