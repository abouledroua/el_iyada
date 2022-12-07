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
  bool loading = false, error = false, filter = false;
  String query = "";
  int nbPatient = 0;
  List<Patient> allPatients = [], patientsList = [];
  late TextEditingController txtName;

  updateLoading({required newloading, required newerror}) {
    loading = newloading;
    error = newerror;
    update();
  }

  updateFilter({required bool newValue}) {
    filter = newValue;
    update();
  }

  Future getPatient() async {
    updateLoading(newloading: true, newerror: false);
    nbPatient = 0;
    String serverDir = AppData.getServerDirectory();
    var url = "$serverDir/GET_PATIENTS.php";
    print("url=$url");
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
            allPatients.clear();

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
                  dateC: m['DATE_CONSULT'],
                  isFemme: (sexe == 2),
                  isHomme: (sexe == 1),
                  sexe: sexe,
                  typeAge: int.parse(m['TYPE']));
              allPatients.add(patient);
              nbPatient++;
            }
            search();
            updateLoading(newloading: false, newerror: false);
          } else {
            allPatients.clear();
            nbPatient = 0;
            updateLoading(newloading: false, newerror: true);
            AppData.mySnackBar(
                title: 'Liste des Patients',
                message: "Probleme de Connexion avec le serveur !!!",
                color: AppColor.red);
            print('Probleme de Connexion avec le serveur !!!');
          }
        })
        .catchError((error) {
          print("erreur : $error");
          allPatients.clear();
          nbPatient = 0;
          updateLoading(newloading: false, newerror: true);
          AppData.mySnackBar(
              title: 'Liste des Patients',
              message: "Probleme de Connexion avec le serveur !!!",
              color: AppColor.red);
        });
  }

  updateQuery(String newValue) {
    txtName.text = newValue;
    query = newValue;
    update();
  }

  @override
  void onClose() {
    txtName.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    txtName = TextEditingController();
    getPatient();
    super.onInit();
  }

  search() {
    if (txtName.text.isNotEmpty) {
      updateFilter(newValue: true);
      query = txtName.text;
      patientsList.clear();
      allPatients.forEach((item) {
        if (item.name.toUpperCase().contains(query.toUpperCase())) {
          patientsList.add(item);
        }
      });
      updateFilter(newValue: false);
    }
  }

  searchPatientByCb({required String cb}) {
    for (var item in allPatients) {
      if (item.cb == cb) return item;
    }
  }
}
