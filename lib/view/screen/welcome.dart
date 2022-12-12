// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/keyboard_controller.dart';
import '../../controller/welcome_controller.dart';
import '../../core/constant/color.dart';
import '../../core/constant/data.dart';
import '../../core/constant/image_asset.dart';
import '../../core/constant/sizes.dart';
import '../../core/services/settingservice.dart';
import '../widget/mywidget.dart';
import 'qrcodescanner.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(KeyboardController());
    Get.put(WelcomeController());
    return MyWidget(
        child: ListView(children: [
      SizedBox(height: 25),
      Center(
          child: SizedBox(
              height: AppSizes.heightScreen / 3,
              child: Image.asset(AppImageAsset.logo, fit: BoxFit.cover))),
      SizedBox(height: 25),
      Center(
          child: GetBuilder<WelcomeController>(
              builder: (controller) => Text(
                  controller.serverError
                      ? "Erreur lors de la connexion !!!"
                      : controller.msg,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: controller.serverError
                          ? AppColor.red
                          : AppColor.black)))),
      SizedBox(height: 25),
      GetBuilder<WelcomeController>(
          builder: (controller) => Visibility(
              visible: controller.serverError,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 25),
                        Expanded(
                            child: TextFormField(
                                controller: controller.txtServerIp,
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    hintText: "Adresse du serveur",
                                    hintStyle: const TextStyle(fontSize: 14),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    label: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 9),
                                        child: Text("Adresse du serveur")),
                                    suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons
                                            .supervised_user_circle_outlined)),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: AppColor.black),
                                        borderRadius:
                                            BorderRadius.circular(16))))),
                        SizedBox(width: 25),
                        ElevatedButton.icon(
                            icon: Icon(Icons.qr_code),
                            label: Text("QR Code"),
                            style: ElevatedButton.styleFrom(
                                foregroundColor: AppColor.white,
                                backgroundColor: AppColor.black),
                            onPressed: () async {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const QRViewExample()))
                                  .then((value) async {
                                if (value != null) {
                                  controller.txtServerIp.text = value;
                                  AppData.serverIP = value;
                                  SettingServices c = Get.find();
                                  c.sharedPrefs
                                      .setString('ServerAdress', value);
                                  await controller.tryConnect();
                                }
                              });
                            }),
                        SizedBox(width: 25),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: AppColor.white,
                                backgroundColor: AppColor.green2),
                            onPressed: () async {
                              AppData.serverIP = controller.txtServerIp.text;
                              SettingServices c = Get.find();
                              c.sharedPrefs.setString(
                                  'ServerAdress', controller.txtServerIp.text);
                              await controller.tryConnect();
                            },
                            icon: Icon(Icons.refresh),
                            label: Text("Actualiser")),
                        SizedBox(width: 25)
                      ])))),
      SizedBox(height: 25)
    ]));
  }
}
