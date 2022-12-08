// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  List<Uint8List> ecgData = [], echoData = [], radioData = [], docsData = [];
  List<bool> ecgLoading = [],
      echoLoading = [],
      radioLoading = [],
      docsLoading = [];

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
              ecgData.clear();
              ecgLoading.clear();

              echo.clear();
              echoData.clear();
              echoLoading.clear();

              radio.clear();
              radioData.clear();
              radioLoading.clear();

              docs.clear();
              docsData.clear();
              docsLoading.clear();

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
              if (echo.isNotEmpty ||
                  ecg.isNotEmpty ||
                  docs.isNotEmpty ||
                  radio.isNotEmpty) {
                if (echo.isNotEmpty) {
                  for (var i = 0; i < echo.length; i++) {
                    echoData.add(base64Decode(''));
                    echoLoading.add(true);
                    getImageData(chemin: echo[i].chemin, index: i, type: 1);
                  }
                }
                if (radio.isNotEmpty) {
                  for (var i = 0; i < radio.length; i++) {
                    radioData.add(base64Decode(''));
                    radioLoading.add(true);
                    getImageData(chemin: radio[i].chemin, index: i, type: 4);
                  }
                }
                if (ecg.isNotEmpty) {
                  for (var i = 0; i < ecg.length; i++) {
                    ecgData.add(base64Decode(''));
                    ecgLoading.add(true);
                    getImageData(chemin: ecg[i].chemin, index: i, type: 2);
                  }
                }
                if (docs.isNotEmpty) {
                  for (var i = 0; i < docs.length; i++) {
                    docsData.add(base64Decode(''));
                    docsLoading.add(true);
                    getImageData(chemin: docs[i].chemin, index: i, type: 3);
                  }
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

  getImageData(
      {required String chemin, required int type, required int index}) async {
    String serverDir = AppData.getServerDirectory();
    var url = "$serverDir/SHOW_IMAGE.php";
    print("url=$url");
    Uri myUri = Uri.parse(url);
    chemin = chemin.replaceAll("\\", "\\\\");
    http
        .post(myUri, body: {"CHEMIN": chemin})
        .timeout(Duration(seconds: AppData.timeOut))
        .then((response) async {
          if (response.statusCode == 200) {
            String img64 = jsonDecode(response.body);
            Uint8List decodedBytes = base64Decode(img64);
            switch (type) {
              case 1:
                print('maj echoData .....');
                echoData[index] = decodedBytes;
                echoLoading[index] = false;
                break;
              case 2:
                print('maj ecgData .....');
                ecgData[index] = decodedBytes;
                ecgLoading[index] = false;
                break;
              case 3:
                print('maj docsData .....');
                docsData[index] = decodedBytes;
                docsLoading[index] = false;
                break;
              case 4:
                print('maj radioData .....');
                radioData[index] = decodedBytes;
                radioLoading[index] = false;
                break;
            }
            update();
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
