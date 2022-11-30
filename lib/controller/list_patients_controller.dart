// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/class/patient.dart';
import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';
import 'dart:async';

class ListPatientsController extends GetxController {
  bool loading = false, error = false;
  String query = "";
  List<Patient> patients = [];

  updateBooleans({required newloading, required newerror}) {
    loading = newloading;
    error = newerror;
    update();
  }

  Future getPatient() async {
    updateBooleans(newloading: true, newerror: false);
    String serverDir = AppData.getServerDirectory();
    var url = "$serverDir/GET_PATIENTS.php";
    print("url=$url");
    patients.clear();
    Uri myUri = Uri.parse(url);
    http
        .post(myUri, body: {})
        .timeout(Duration(seconds: AppData.timeOut))
        .then((response) async {
          if (response.statusCode == 200) {
            late Patient patient;
            late int sexe;
            late String age, typeAge;
            var responsebody = jsonDecode(response.body);
            for (var m in responsebody) {
              sexe = int.parse(m['SEXE']);
              age = m['AGE'];
              typeAge = m['TYPE'];

              patient = Patient(
                  name: m['NAME'],
                  adresse: m['ADR'],
                  gs: int.parse(m['GS']),
                  tel: m['TEL'],
                  ageS: age +
                      ((typeAge == '1')
                          ? ' an(s)'
                          : (typeAge == 2)
                              ? ' mois'
                              : ' jours'),
                  age: int.parse(m['AGE']),
                  cb: m['CODE_BARRE'],
                  isFemme: (sexe == 2),
                  isHomme: (sexe == 1),
                  sexe: sexe,
                  typeAge: int.parse(m['TYPE']));
              patients.add(patient);
              updateBooleans(newloading: false, newerror: false);
            }
          } else {
            patients.clear();
            updateBooleans(newloading: false, newerror: true);
            AppData.mySnackBar(
                title: 'Liste des Patients',
                message: "Probleme de Connexion avec le serveur !!!",
                color: AppColor.red);
            print('Probleme de Connexion avec le serveur !!!');
          }
        })
        .catchError((error) {
          print("erreur : $error");
          patients.clear();
          updateBooleans(newloading: false, newerror: true);
          AppData.mySnackBar(
              title: 'Liste des Patients',
              message: "Probleme de Connexion avec le serveur !!!",
              color: AppColor.red);
        });
  }

  updateQuery(String newValue) {
    query = newValue;
    update();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    getPatient();
    super.onInit();
  }
}