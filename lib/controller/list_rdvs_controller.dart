// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/class/rdv.dart';
import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';
import 'dart:async';

class ListRDVsController extends GetxController {
  bool loading = false, error = false;
  String query = "";
  int nbconsult = 0, nbRdvs = 0, nbTotal = 0;
  List<RDV> rdvs = [];

  updateBooleans({required newloading, required newerror}) {
    loading = newloading;
    error = newerror;
    update();
  }

  Future getListRdvToday() async {
    if (!loading) {
      updateBooleans(newloading: true, newerror: false);
      int vnbconsult = 0;
      int vnbTotal = 0;
      int vnbRdvs = 0;
      // nbconsult = 0;
      //  nbRdvs = 0;
      //  nbTotal = 0;
      String serverDir = AppData.getServerDirectory();
      var url = "$serverDir/GET_RDVS_TODAY.php";
      print("url=$url");
      rdvs.clear();
      DateTime currentDate = DateTime.now();
      String today =
          "${currentDate.year}${currentDate.month}${currentDate.day}";
      Uri myUri = Uri.parse(url);
      http
          .post(myUri, body: {"DATE_TODAY": today})
          .timeout(Duration(seconds: AppData.timeOut))
          .then((response) async {
            if (response.statusCode == 200) {
              late RDV rdv;
              late String age, typeAge;
              var responsebody = jsonDecode(response.body);
              for (var m in responsebody) {
                age = m['AGE'];
                typeAge = m['TYPE'];
                rdv = RDV(
                    typeAge: int.parse(m['TYPE']),
                    heure_arrivee: m['H_ARRIV'],
                    motif: m['MOTIFF'],
                    name: m['NAME'],
                    etat: int.parse(m['ETAT_RDV']),
                    ageS: age +
                        ((typeAge == '1')
                            ? ' an(s)'
                            : (typeAge == 2)
                                ? ' mois'
                                : ' jours'),
                    sexe: int.parse(m['SEXE']),
                    age: int.parse(m['AGE']),
                    cb: m['CODE_BARRE'],
                    numReq: int.parse(m['NUM_REQ']));
                rdvs.add(rdv);
                vnbTotal++;
                if (rdv.numReq == 1) {
                  vnbconsult++;
                } else {
                  vnbRdvs++;
                }
              }
              nbconsult = vnbconsult;
              nbRdvs = vnbRdvs;
              nbTotal = vnbTotal;
              updateBooleans(newloading: false, newerror: false);
            } else {
              rdvs.clear();
              //    nbconsult = 0;
              //    nbTotal = 0;
              //    nbRdvs = 0;
              updateBooleans(newloading: false, newerror: true);
              AppData.mySnackBar(
                  title: 'Liste des Rendez-vous',
                  message: "Probleme de Connexion avec le serveur !!!",
                  color: AppColor.red);
              print('Probleme de Connexion avec le serveur !!!');
            }
          })
          .catchError((error) {
            print("erreur : $error");
            rdvs.clear();
            //    nbconsult = 0;
            //  nbTotal = 0;
            //  nbRdvs = 0;
            updateBooleans(newloading: false, newerror: true);
            AppData.mySnackBar(
                title: 'Liste des Rendez-vous',
                message: "Probleme de Connexion avec le serveur !!!",
                color: AppColor.red);
          });
    }
  }

  updateQuery(String newValue) {
    query = newValue;
    update();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    Timer.periodic(Duration(seconds: 20), (timer) => getListRdvToday());
    getListRdvToday();
    super.onInit();
  }
}
