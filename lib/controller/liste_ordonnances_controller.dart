// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/class/consultations.dart';
import '../core/class/details_ordonnance.dart';
import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';

class ListOrdonnanceController extends GetxController {
  late String cb;
  int indexSelected = -1, ab = 1;
  bool loading = false, error = false;
  bool loadingDetailsA = false,
      errorDetailsA = false,
      loadingDetailsB = false,
      errorDetailsB = false;
  List<Consultation> listConsult = [];
  List<DetailsOrdonnance> listOrdA = [], listOrdB = [];

  ListOrdonnanceController({required String cb}) {
    this.cb = cb;
  }

  updateBooleans({required newloading, required newerror}) {
    loading = newloading;
    error = newerror;
    update();
  }

  updateDetailsBooleansA({required newloading, required newerror}) {
    loadingDetailsA = newloading;
    errorDetailsA = newerror;
    update();
  }

  updateDetailsBooleansB({required newloading, required newerror}) {
    loadingDetailsB = newloading;
    errorDetailsB = newerror;
    update();
  }

  updateAB({required int newIndex}) {
    ab = newIndex;
    print('ab = $ab');
    update();
  }

  Future getOrdonnances() async {
    if (!loading) {
      updateBooleans(newloading: true, newerror: false);
      String serverDir = AppData.getServerDirectory();
      var url = "$serverDir/GET_LIST_ORDONNANCES.php";
      print("url=$url");
      Uri myUri = Uri.parse(url);
      http
          .post(myUri, body: {"ID_PATIENT": cb})
          .timeout(Duration(seconds: AppData.timeOut))
          .then((response) async {
            if (response.statusCode == 200) {
              late Consultation ord;
              var responsebody = jsonDecode(response.body);
              listOrdA.clear();
              listOrdB.clear();
              listConsult.clear();
              for (var m in responsebody) {
                try {
                  ord = Consultation(
                      date_consult: m['DATE_ORDONNANCE'],
                      exercice: int.parse(m['EXERCICE']),
                      typeConv: int.parse(m['TYPE_CONV']),
                      idConsult: int.parse(m['ID_CONSULTATION']));
                  listConsult.add(ord);
                } catch (e) {
                  print(
                      'GET_LIST_ORDONNANCES sauté because of : ${e.toString()} ');
                }
              }
              updateBooleans(newloading: false, newerror: false);
              if (listConsult.isNotEmpty) {
                if (indexSelected == -1)
                  updateSelectionDate(0);
                else
                  getDetails();
              }
            } else {
              updateBooleans(newloading: false, newerror: true);
              AppData.mySnackBar(
                  title: 'Liste des Ordonnances',
                  message: "Probleme de Connexion avec le serveur !!!",
                  color: AppColor.red);
              print('Probleme de Connexion avec le serveur !!!');
            }
          })
          .catchError((error) {
            print("erreur : $error");
            updateBooleans(newloading: false, newerror: true);
            AppData.mySnackBar(
                title: 'Liste des Ordonnances',
                message: "Probleme de Connexion avec le serveur !!!",
                color: AppColor.red);
          });
    }
  }

  Future getDetails() async {
    if (listConsult[indexSelected].typeConv == 1) updateAB(newIndex: 1);
    await getPrescriptions(type: 1);
    await getPrescriptions(type: 2);
  }

  Future getPrescriptions({required int type}) async {
    if (((!loadingDetailsA && type == 1) || (!loadingDetailsB && type == 2)) &&
        indexSelected >= 0) {
      if (type == 1)
        updateDetailsBooleansA(newloading: true, newerror: false);
      else
        updateDetailsBooleansB(newloading: true, newerror: false);
      String serverDir = AppData.getServerDirectory();
      var url = "$serverDir/GET_DETAILS_ORDONNANCE.php";
      print("url=$url");
      Uri myUri = Uri.parse(url);
      http
          .post(myUri, body: {
            "TYPE": type.toString(),
            "ID_CONSULTATION": listConsult[indexSelected].idConsult.toString(),
            "EXERCICE": listConsult[indexSelected].exercice.toString(),
          })
          .timeout(Duration(seconds: AppData.timeOut))
          .then((response) async {
            if (response.statusCode == 200) {
              late DetailsOrdonnance ord;
              var responsebody = jsonDecode(response.body);
              if (type == 1)
                listOrdA.clear();
              else
                listOrdB.clear();
              for (var m in responsebody) {
                try {
                  ord = DetailsOrdonnance(
                      type: type,
                      prescription: m['PRESC'],
                      idMedic: int.parse(m['ID_MEDICAMENT']));
                  if (type == 1)
                    listOrdA.add(ord);
                  else
                    listOrdB.add(ord);
                } catch (e) {
                  print(
                      'GET_DETAILS_ORDONNANCE sauté because of : ${e.toString()} , idMedic: ${m['ID_MEDICAMENT']} ? prescription: ${m['PRESC']}');
                }
              }
              if (type == 1)
                updateDetailsBooleansA(newloading: false, newerror: false);
              else
                updateDetailsBooleansB(newloading: false, newerror: false);
            } else {
              if (type == 1)
                updateDetailsBooleansA(newloading: false, newerror: true);
              else
                updateDetailsBooleansB(newloading: false, newerror: true);
              AppData.mySnackBar(
                  title: 'Liste des Ordonnances',
                  message: "Probleme de Connexion avec le serveur !!!",
                  color: AppColor.red);
              print('Probleme de Connexion avec le serveur !!!');
            }
          })
          .catchError((error) {
            print("erreur : $error");
            if (type == 1)
              updateDetailsBooleansA(newloading: false, newerror: true);
            else
              updateDetailsBooleansB(newloading: false, newerror: true);
            AppData.mySnackBar(
                title: 'Liste des Ordonnances',
                message: "Probleme de Connexion avec le serveur !!!",
                color: AppColor.red);
          });
    }
  }

  updateSelectionDate(int newIndex) {
    ab = 1;
    indexSelected = newIndex;
    getDetails();
  }

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    indexSelected = -1;
    ab = 1;
    getOrdonnances();
    super.onInit();
  }
}
