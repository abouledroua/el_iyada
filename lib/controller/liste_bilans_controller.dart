// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/class/consultations.dart';
import '../core/class/details_bilan.dart';
import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';

class ListBilanController extends GetxController {
  late String cb;
  int indexSelected = -1;
  bool loading = false, error = false;
  bool loadingDetails = false, errorDetails = false;
  List<Consultation> listConsult = [];
  List<DetailsBilan> listDetailsBilan = [];

  ListBilanController({required String cb}) {
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

  Future getBilans() async {
    if (!loading) {
      updateBooleans(newloading: true, newerror: false);
      String serverDir = AppData.getServerDirectory();
      var url = "$serverDir/GET_LIST_BILANS.php";
      print("url=$url");
      Uri myUri = Uri.parse(url);
      http
          .post(myUri, body: {"ID_PATIENT": cb})
          .timeout(Duration(seconds: AppData.timeOut))
          .then((response) async {
            if (response.statusCode == 200) {
              late Consultation ord;
              var responsebody = jsonDecode(response.body);
              listDetailsBilan.clear();
              listConsult.clear();
              for (var m in responsebody) {
                try {
                  ord = Consultation(
                      date_consult: m['DATE_CONSULTATION'],
                      exercice: int.parse(m['EXERCICE']),
                      idConsult: int.parse(m['ID_CONSULTATION']));
                  listConsult.add(ord);
                } catch (e) {}
              }
              updateBooleans(newloading: false, newerror: false);
              if (listConsult.isNotEmpty) {
                if (indexSelected == -1)
                  updateSelectionDate(0);
                else
                  getDetailsBilan();
              }
            } else {
              updateBooleans(newloading: false, newerror: true);
              AppData.mySnackBar(
                  title: 'Liste des Bilans',
                  message: "Probleme de Connexion avec le serveur !!!",
                  color: AppColor.red);
              print('Probleme de Connexion avec le serveur !!!');
            }
          })
          .catchError((error) {
            print("erreur : $error");
            updateBooleans(newloading: false, newerror: true);
            AppData.mySnackBar(
                title: 'Liste des Bilans',
                message: "Probleme de Connexion avec le serveur !!!",
                color: AppColor.red);
          });
    }
  }

  Future getDetailsBilan() async {
    if (!loadingDetails && indexSelected >= 0) {
      updateDetailsBooleans(newloading: true, newerror: false);
      String serverDir = AppData.getServerDirectory();
      var url = "$serverDir/GET_DETAILS_BILAN.php";
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
              late DetailsBilan ord;
              var responsebody = jsonDecode(response.body);
              listDetailsBilan.clear();
              for (var m in responsebody) {
                try {
                  ord = DetailsBilan(
                      designation: m['BILAN'],
                      idBilan: int.parse(m['ID_BILAN']));
                  listDetailsBilan.add(ord);
                } catch (e) {}
              }
              updateDetailsBooleans(newloading: false, newerror: false);
            } else {
              updateDetailsBooleans(newloading: false, newerror: true);
              AppData.mySnackBar(
                  title: 'Liste des Bilans',
                  message: "Probleme de Connexion avec le serveur !!!",
                  color: AppColor.red);
              print('Probleme de Connexion avec le serveur !!!');
            }
          })
          .catchError((error) {
            print("erreur : $error");
            updateDetailsBooleans(newloading: false, newerror: true);
            AppData.mySnackBar(
                title: 'Liste des Bilans',
                message: "Probleme de Connexion avec le serveur !!!",
                color: AppColor.red);
          });
    }
  }

  updateSelectionDate(int newIndex) {
    indexSelected = newIndex;
    getDetailsBilan();
  }

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    indexSelected = -1;
    getBilans();
    super.onInit();
  }
}
