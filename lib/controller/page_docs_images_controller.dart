// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'gest_photos_controller.dart';
import '../core/class/my_image.dart';
import '../core/class/image_upload.dart';
import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';
import '../view/widget/image_page/selectcameragellerywidget.dart';

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
                try {
                  type = int.parse(m['TYPE']);
                  img = MyImage(
                      cb: cb,
                      error: false,
                      add: false,
                      deleting: false,
                      data: base64Decode(''),
                      loading: true,
                      type: int.parse(m['TYPE']),
                      chemin: m['CHEMIN'],
                      date_image: m['DATE_IMAGE'],
                      libelle: m['LIBELE'],
                      id: int.parse(m['ID']));
                  switch (type) {
                    case 1:
                      echo.add(img);
                      getImageData(
                          chemin: img.chemin, index: echo.length - 1, type: 1);
                      break;
                    case 2:
                      ecg.add(img);
                      getImageData(
                          chemin: img.chemin, index: ecg.length - 1, type: 2);
                      break;
                    case 3:
                      docs.add(img);
                      getImageData(
                          chemin: img.chemin, index: docs.length - 1, type: 3);
                      break;
                    case 4:
                      radio.add(img);
                      getImageData(
                          chemin: img.chemin, index: radio.length - 1, type: 4);
                      break;
                  }
                } catch (e) {
                  print('GET_IMAGES sauté because of : ${e.toString()} ');
                }
              }
              updateBooleans(newloading: false, newerror: false);
            } else {
              updateBooleans(newloading: false, newerror: true);
              AppData.mySnackBar(
                  title: 'Liste des Images',
                  message: "Probleme de Connexion avec le serveur !!!",
                  color: AppColor.red);
              print('Probleme de Connexion avec le serveur !!!');
            }
          })
          .catchError((error) {
            print("erreur : $error");
            updateBooleans(newloading: false, newerror: true);
            AppData.mySnackBar(
                title: 'Liste des Images',
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
    http.post(myUri, body: {"CHEMIN": chemin})
        //   .timeout(Duration(seconds: AppData.timeOut))
        .then((response) async {
      if (response.statusCode == 200) {
        String img64 = jsonDecode(response.body);
        Uint8List decodedBytes = base64Decode(img64);
        updateData(
            index: index, type: type, decodedBytes: decodedBytes, error: false);
        update();
      } else {
        updateData(
            index: index,
            type: type,
            decodedBytes: base64Decode(''),
            error: true);
        updateBooleans(newloading: false, newerror: true);
        //     AppData.mySnackBar(
        //        title: 'Liste des Images',
        //        message: "Probleme de Connexion avec le serveur 2 !!!",
        //        color: AppColor.red);
        print('Probleme de Connexion avec le serveur !!!');
      }
    }).catchError((error) {
      print("erreur : $error");
      updateData(
          index: index,
          type: type,
          decodedBytes: base64Decode(''),
          error: true);
      updateBooleans(newloading: false, newerror: true);
      //    AppData.mySnackBar(
      //      title: 'Liste des Images',
      //     message: "Probleme de Connexion avec le serveur 1 !!!",
      //     color: AppColor.red);
    });
  }

  updateData(
      {required int type,
      required int index,
      required Uint8List decodedBytes,
      required bool error}) {
    switch (type) {
      case 1:
        if (!error) echo[index].data = decodedBytes;
        echo[index].loading = false;
        echo[index].error = error;
        break;
      case 2:
        if (!error) ecg[index].data = decodedBytes;
        ecg[index].loading = false;
        ecg[index].error = error;
        break;
      case 3:
        if (!error) docs[index].data = decodedBytes;
        docs[index].loading = false;
        docs[index].error = error;
        break;
      case 4:
        if (!error) radio[index].data = decodedBytes;
        radio[index].loading = false;
        radio[index].error = error;
        break;
    }
  }

  updateDeleting({required int type, required int index, required bool del}) {
    switch (type) {
      case 1:
        echo[index].deleting = del;
        break;
      case 2:
        ecg[index].deleting = del;
        break;
      case 3:
        docs[index].deleting = del;
        break;
      case 4:
        radio[index].deleting = del;
        break;
    }
  }

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    getImages();
    super.onInit();
  }

  updatePage(int index) {
    page = index;
    update();
  }

  pickPhoto({required ImageSource source, required int type}) async {
    late ImagePicker imagePicker = ImagePicker();
    if (source == ImageSource.camera) {
      XFile? image = await imagePicker.pickImage(source: source);
      await traiterImage(image: image, type: type);
    } else {
      List<XFile>? images = await imagePicker.pickMultiImage();
      for (var image in images) {
        await traiterImage(image: image, type: type);
      }
    }
  }

  traiterImage({required XFile? image, required int type}) async {
    if (image != null) {
      Uint8List imageData = await image.readAsBytes();
      MyImageUpload upoadImage = MyImageUpload(
          cb: cb, chemin: image.path, data: imageData, type: type);
      GestImagesController contr = Get.find();
      contr.addImage(upoadImage);
      MyImage myImage = MyImage(
          cb: cb,
          error: false,
          deleting: false,
          data: imageData,
          loading: false,
          add: true,
          chemin: "",
          type: type,
          date_image: "",
          libelle: "LIELE",
          id: 111);
      switch (type) {
        case 1:
          echo.add(myImage);
          break;
        case 2:
          ecg.add(myImage);
          break;
        case 3:
          docs.add(myImage);
          break;
        case 4:
          radio.add(myImage);
          break;
      }
      update();
    }
  }

  addImage() {
    int type = 0;
    switch (page) {
      case 1:
        type = 1;
        break;
      case 2:
        type = 4;
        break;
      case 3:
        type = 2;
        break;
      case 4:
        type = 3;
        break;
    }
    Get.bottomSheet(
        SelectCameraGalleryWidget(onTapCamera: () {
          pickPhoto(source: ImageSource.camera, type: type);
          Get.back();
        }, onTapGallery: () {
          pickPhoto(source: ImageSource.gallery, type: type);
          Get.back();
        }),
        isScrollControlled: true,
        enterBottomSheetDuration: const Duration(milliseconds: 600),
        exitBottomSheetDuration: const Duration(milliseconds: 600));
  }

  Future deleteImage(
      {required String chemin,
      required int type,
      required int id,
      required int index,
      required String cb}) async {
    updateDeleting(del: true, index: index, type: type);
    String serverDir = AppData.getServerDirectory();
    var url = "$serverDir/DELETE_IMAGE.php";
    print("url=$url");
    Uri myUri = Uri.parse(url);
    chemin = chemin.replaceAll("\\", "\\\\");
    http.post(myUri, body: {
      "CHEMIN": chemin,
      "ID": id.toString(),
      "ID_MALADE": cb,
    }).then((response) async {
      if (response.statusCode == 200) {
        try {
          var responsebody = jsonDecode(response.body);
          if (responsebody == "1") {
            switch (type) {
              case 1:
                echo.removeAt(index);
                update();
                break;
              case 2:
                ecg.removeAt(index);
                update();
                break;
              case 3:
                docs.removeAt(index);
                update();
                break;
              case 4:
                radio.removeAt(index);
                update();
                break;
            }
          } else {
            updateDeleting(del: false, index: index, type: type);
          }
        } catch (e) {
          updateDeleting(del: false, index: index, type: type);
        }
      } else {
        updateDeleting(del: false, index: index, type: type);
        print('Probleme de Connexion avec le serveur !!!');
      }
    }).catchError((error) {
      updateDeleting(del: false, index: index, type: type);
      print("erreur : $error");
    });
  }
}
