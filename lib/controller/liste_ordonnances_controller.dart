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
  int indexSelected = -1;
  bool loading = false, error = false;
  bool loadingDetails = false, errorDetails = false;
  List<Consultation> listConsult = [];
  List<DetailsOrdonnance> listDetailsOrdonnance = [];

  ListOrdonnanceController({required String cb}) {
    this.cb = cb;
  }

  updateBooleans({required newloading, required newerror}) {
    loading = newloading;
    error = newerror;
    update();
  }

  updateDetailsBooleans({required newloading, required newerror}) {
    loadingDetails = newloading;
    errorDetails = newerror;
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
              listDetailsOrdonnance.clear();
              listConsult.clear();
              for (var m in responsebody) {
                ord = Consultation(
                    date_consult: m['DATE_ORDONNANCE'],
                    exercice: int.parse(m['EXERCICE']),
                    idConsult: int.parse(m['ID_CONSULTATION']));
                listConsult.add(ord);
              }
              updateBooleans(newloading: false, newerror: false);
              if (listConsult.isNotEmpty) {
                if (indexSelected == -1)
                  updateSelectionDate(0);
                else
                  getDetailsOrdonnances();
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

  Future getDetailsOrdonnances() async {
    if (!loadingDetails && indexSelected >= 0) {
      updateDetailsBooleans(newloading: true, newerror: false);
      String serverDir = AppData.getServerDirectory();
      var url = "$serverDir/GET_DETAILS_ORDONNANCE.php";
      print("url=$url");
      Uri myUri = Uri.parse(url);
      http
          .post(myUri, body: {
            "ID_CONSULTATION": listConsult[indexSelected].idConsult.toString(),
            "EXERCICE": listConsult[indexSelected].exercice.toString(),
          })
          .timeout(Duration(seconds: AppData.timeOut))
          .then((response) async {
            if (response.statusCode == 200) {
              late DetailsOrdonnance ord;
              var responsebody = jsonDecode(response.body);
              listDetailsOrdonnance.clear();
              for (var m in responsebody) {
                try {
                  ord = DetailsOrdonnance(
                      prescription: m['PRESC'],
                      idMedic: int.parse(m['ID_MEDICAMENT']));
                  listDetailsOrdonnance.add(ord);
                } catch (e) {}
              }
              updateDetailsBooleans(newloading: false, newerror: false);
            } else {
              updateDetailsBooleans(newloading: false, newerror: true);
              AppData.mySnackBar(
                  title: 'Liste des Ordonnances',
                  message: "Probleme de Connexion avec le serveur !!!",
                  color: AppColor.red);
              print('Probleme de Connexion avec le serveur !!!');
            }
          })
          .catchError((error) {
            print("erreur : $error");
            updateDetailsBooleans(newloading: false, newerror: true);
            AppData.mySnackBar(
                title: 'Liste des Ordonnances',
                message: "Probleme de Connexion avec le serveur !!!",
                color: AppColor.red);
          });
    }
  }

  updateSelectionDate(int newIndex) {
    indexSelected = newIndex;
    getDetailsOrdonnances();
  }

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    indexSelected = -1;
    getOrdonnances();
    super.onInit();
  }
}
