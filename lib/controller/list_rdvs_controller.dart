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

  Future<bool> onWillPop() async {
    return (await showDialog(
            context: Get.context!,
            builder: (context) => AlertDialog(
                    title: Row(children: [
                      Icon(Icons.exit_to_app_sharp, color: AppColor.red),
                      const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text('Etes-vous sur ?'))
                    ]),
                    content: const Text(
                        "Voulez-vous vraiment quitter l'application ?"),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Get.back(result: false),
                          child: Text('Non',
                              style: TextStyle(color: AppColor.red))),
                      TextButton(
                          onPressed: () => Get.back(result: true),
                          child: Text('Oui',
                              style: TextStyle(color: AppColor.green)))
                    ]))) ??
        false;
  }

  Future getListRdvToday() async {
    if (!loading) {
      updateBooleans(newloading: true, newerror: false);
      int vnbconsult = 0;
      int vnbTotal = 0;
      int vnbRdvs = 0;
      String serverDir = AppData.getServerDirectory();
      var url = "$serverDir/GET_RDVS_TODAY.php";
      print("url=$url");
      rdvs.clear();
      Uri myUri = Uri.parse(url);
      http
          .post(myUri, body: {})
          .timeout(Duration(seconds: AppData.timeOut))
          .then((response) async {
            if (response.statusCode == 200) {
              late RDV rdv;
              late String age, typeAge;
              int nbRdvSaute = 0;
              var responsebody = jsonDecode(response.body);
              for (var m in responsebody) {
                try {
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
                } catch (e) {
                  print('GET_RDVS_TODAY saut?? because of : ${e.toString()}');
                  nbRdvSaute++;
                }
              }
              if (nbRdvSaute > 0) print(' ---- $nbRdvSaute saut??s -----');
              nbconsult = vnbconsult;
              nbRdvs = vnbRdvs;
              nbTotal = vnbTotal;
              updateBooleans(newloading: false, newerror: false);
            } else {
              rdvs.clear();
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
    getListRdvToday();
    super.onInit();
  }
}
