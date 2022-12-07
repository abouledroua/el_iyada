// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/class/image.dart';
import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';

class PageDocsImagesController extends GetxController {
  late String cb;
  late int page = 1;
  bool loading = false, error = false;
  List<MyImage> ecg = [], echo = [], radio = [], docs = [];

  PageDocsImagesController({required String cb}) {
    this.cb = cb;
    page = 1;
  }

  updateBooleans({required newloading, required newerror}) {
    loading = newloading;
    error = newerror;
    update();
  }

  Future getImages() async {
    if (!loading) {
      updateBooleans(newloading: true, newerror: false);
      String serverDir = AppData.getServerDirectory();
      var url = "$serverDir/GET_IMAGES.php";
      print("url=$url");
      Uri myUri = Uri.parse(url);
      http
          .post(myUri, body: {"ID_PATIENT": cb})
          .timeout(Duration(seconds: AppData.timeOut))
          .then((response) async {
            if (response.statusCode == 200) {
              late MyImage img;
              late int type;
              var responsebody = jsonDecode(response.body);
              ecg.clear();
              echo.clear();
              radio.clear();
              docs.clear();
              for (var m in responsebody) {
                type = int.parse(m['TYPE']);
                img = MyImage(
                    type: int.parse(m['TYPE']),
                    chemin: m['CHEMIN'],
                    date_image: m['DATE_IMAGE'],
                    libelle: m['LIBELE'],
                    id: int.parse(m['ID']),
                    thumb: m['THUMB']);
                switch (type) {
                  case 1:
                    echo.add(img);
                    break;
                  case 2:
                    ecg.add(img);
                    break;
                  case 3:
                    docs.add(img);
                    break;
                  case 4:
                    radio.add(img);
                    break;
                }
              }
              updateBooleans(newloading: false, newerror: false);
            } else {
              updateBooleans(newloading: false, newerror: true);
              AppData.mySnackBar(
                  title: 'Liste des Imgaes',
                  message: "Probleme de Connexion avec le serveur !!!",
                  color: AppColor.red);
              print('Probleme de Connexion avec le serveur !!!');
            }
          })
          .catchError((error) {
            print("erreur : $error");
            updateBooleans(newloading: false, newerror: true);
            AppData.mySnackBar(
                title: 'Liste des Imgaes',
                message: "Probleme de Connexion avec le serveur !!!",
                color: AppColor.red);
          });
    }
  }

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    getImages();
    super.onInit();
  }

  void updatePage(int index) {
    page = index;
    update();
  }
}
