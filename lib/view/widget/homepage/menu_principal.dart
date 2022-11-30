import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home_page_controller.dart';
import '../../../core/constant/color.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppColor.cyanClair,
                        AppColor.white,
                        AppColor.greenClair
                      ]),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: AppColor.black.withOpacity(0.1),
                        offset: const Offset(0, 10))
                  ]),
              child: Buttons()))
    ]);
  }

  Buttons() {
    HomePageController contr = Get.find();
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      MenuButton(
          color: AppColor.patient,
          icon: Icons.search,
          text: "Patients",
          onPressed: () {
            contr.updatePage(newPage: 1);
          }),
      MenuButton(
          color: AppColor.orange,
          icon: Icons.today,
          text: "Rendez-vous",
          onPressed: () {
            contr.updatePage(newPage: 2);
          }),
      MenuButton(
          color: AppColor.black,
          icon: Icons.refresh,
          text: "Actualiser",
          onPressed: () {
            contr.updatePage(newPage: 3);
          })
    ]);
  }

  TextButton MenuButton(
          {required IconData icon,
          required Function() onPressed,
          required String text,
          required Color color}) =>
      TextButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: color),
          label: Text(text, style: TextStyle(color: color, fontSize: 16)));
}
