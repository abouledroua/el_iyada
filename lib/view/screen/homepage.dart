import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_page_controller.dart';
import '../../controller/keyboard_controller.dart';
import '../../controller/list_patients_controller.dart';
import '../widget/homepage/espace_travail.dart';
import '../widget/homepage/statistics.dart';
import '../widget/mywidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    Get.put(ListPatientsController());
    return MyWidget(
        child: Column(children: [
      Expanded(child: EspaceTravail()),
      GetBuilder<KeyboardController>(
          builder: (controller) => Visibility(
              visible: !controller.keyboadrShow, child: Statistics()))
    ]));
  }
}
