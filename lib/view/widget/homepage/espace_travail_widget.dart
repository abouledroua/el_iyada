import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home_page_controller.dart';
import '../../screen/list_patients.dart';

class EspaceTravailWidget extends StatelessWidget {
  const EspaceTravailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        builder: (controller) => Visibility(
            child: ListPatients(),
            visible: controller.page == 1,
            replacement: Visibility(
                child: Text('page Two'),
                visible: controller.page == 2,
                replacement: Text('Page Three'))));
  }
}
