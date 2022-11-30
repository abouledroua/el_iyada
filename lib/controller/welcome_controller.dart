// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';
import '../view/screen/homepage.dart';

class WelcomeController extends GetxController {
  String msg = "";
  bool serverError = false;
  late TextEditingController txtServerIp;

  updateMessage({required String newMsg}) {
    msg = newMsg;
    update();
  }

  @override
  void onClose() {
    txtServerIp.dispose();
    super.onClose();
  }

  getConnect() async {
    serverError = false;
    String serverDir = AppData.getServerDirectory();
    var url = "$serverDir/TRY_CONNECT.php";
    print("url=$url");
    Uri myUri = Uri.parse(url);
    http
        .post(myUri, body: {})
        .timeout(Duration(seconds: AppData.timeOut))
        .then((response) async {
          if (response.statusCode == 200) {
            var responsebody = jsonDecode(response.body);
            if (responsebody == "1") {
              Get.off(() => const HomePage());
            }
          } else {
            print('Probleme de Connexion avec le serveur !!!');
            serverError = true;
            update();
          }
        })
        .catchError((error) {
          print("erreur : $error");
          serverError = true;
          update();
        });
  }

/*
  getListRdvToDay() async {
    String serverDir = AppData.getServerDirectory();
    var url = "$serverDir/GET_RDVS_TODAY.php";
    print("url=$url");
    AppData.patients.clear();
    Uri myUri = Uri.parse(url);

    http
        .post(myUri, body: {})
        .timeout(Duration(seconds: AppData.timeOut))
        .then((response) async {
          if (response.statusCode == 200) {
            late Patient patient;
            late int sexe;
            var responsebody = jsonDecode(response.body);
            for (var m in responsebody) {
              sexe = int.parse(m['SEXE']);
              patient = Patient(
                  name: m['NAME'],
                  adresse: m['ADR'],
                  gs: int.parse(m['GS']),
                  tel: m['TEL'],
                  age: int.parse(m['AGE']),
                  cb: m['CODE_BARRE'],
                  isFemme: (sexe == 2),
                  isHomme: (sexe == 1),
                  sexe: sexe,
                  typeAge: int.parse(m['TYPE']));
              AppData.patients.add(patient);
              Get.to(() => const HomePage());
            }
          } else {
            AppData.patients.clear();
            print('Probleme de Connexion avec le serveur !!!');
            serverError = true;
            update();
          }
        })
        .catchError((error) {
          AppData.patients.clear();
          print("erreur : $error");
          serverError = true;
          update();
        });
  }
*/

  tryConnect() async {
    updateMessage(newMsg: 'Connection en cours ...');
    await getConnect();
  }

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    txtServerIp = TextEditingController();
    txtServerIp.text = AppData.serverIP;
    await tryConnect();
    //  AppData.reparerBDD(showToast: false);
    super.onInit();
  }
}
