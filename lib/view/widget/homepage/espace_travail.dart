import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/keyboard_controller.dart';
import '../../../core/constant/sizes.dart';
import 'espace_travail_widget.dart';
import 'menu_principal.dart';

class EspaceTravail extends StatelessWidget {
  const EspaceTravail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: EspaceTravailWidget()),
      GetBuilder<KeyboardController>(
          builder: (controller) => Visibility(
              visible: !controller.keyboadrShow,
              child: Container(
                  constraints:
                      BoxConstraints(maxWidth: AppSizes.widthScreen / 5),
                  child: MenuPrincipal())))
    ]);
  }
}
