// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../services/settingservice.dart';
import 'color.dart';
import 'sizes.dart';

class AppData {
  static String webVersion = "1.0";
  static String www = "iyada", serverIP = "";
  static int timeOut = 10;

  static final bool isMobile =
      (defaultTargetPlatform == TargetPlatform.android);
  // static final bool isMobile = (defaultTargetPlatform == TargetPlatform.iOS ||
  //    defaultTargetPlatform == TargetPlatform.android);

  static String getServerIP() => serverIP;

  static int getTimeOut() => timeOut;

  static String getServerDirectory([port = ""]) => ((serverIP == "")
      ? ""
      : "http://$serverIP${port != "" ? ":$port" : ""}/$www");

  static String getImage(pImage, pType) =>
      "${getServerDirectory()}/IMAGE/$pType/$pImage";

  static void setServerIP(ip) async {
    serverIP = ip;
    SettingServices c = Get.find();
    c.sharedPrefs.setString('ServerIp', serverIP);
  }

  static void mySnackBar({required title, required message, required color}) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        maxWidth: AppSizes.minWidth,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: color,
        colorText: AppColor.white);
  }

  static String printDate(DateTime? date) {
    DateTime currentDate = DateTime.now();
    int yy = currentDate.year - date!.year;
    String str = "";
    if (yy > 0) {
      str = DateFormat('yyyy-MM-dd').format(date);
    } else {
      int mm = currentDate.month - date.month;
      int dd = currentDate.day - date.day;
      int hh = currentDate.hour - date.hour;
      int min = currentDate.minute - date.minute;
      if (mm < 0) {
        yy--;
        mm += 12;
      }
      if (dd < 0) {
        mm--;
        dd += 30;
      }
      if (hh < 0) {
        dd--;
        hh += 24;
      }
      if (min < 0) {
        hh--;
        min += 60;
      }
      if (dd > 6) {
        str = DateFormat('dd MMM à HH:mm').format(date);
      } else {
        String ch = "";
        switch (dd) {
          case 0:
            if (hh > 0) {
              ch = "0$hh";
              ch = ch.substring(ch.length - 2);
              str = "Il y'a $ch heure(s)";
            } else {
              if (min > 0) {
                ch = "0$min";
                ch = ch.substring(ch.length - 2);
                str = "Il y'a $ch minute(s)";
              } else {
                str = "Il y a un instant";
              }
            }
            break;
          case 1:
            str = "Hier ${DateFormat('HH:mm').format(date)}";
            break;
          default:
            str = DateFormat('EEE à HH:mm').format(date);
            break;
        }
      }
    }
    return str;
  }

  static String calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int yy = currentDate.year - birthDate.year;
    int mm = currentDate.month - birthDate.month;
    int dd = currentDate.day - birthDate.day;
    if (mm < 0) {
      yy--;
      mm += 12;
    }
    if (dd < 0) {
      mm--;
      dd += 30;
    }
    String age = "";
    if (yy > 1) {
      age = "$yy an(s)";
    } else {
      mm = yy * 12 + mm;
      if (mm > 0) {
        age = "$mm mois";
      } else if (dd > 0) {
        age = "$dd jours";
      }
    }
    return age;
  }

  static void makeExternalRequest(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String extension({required String filename}) =>
      ".${filename.split(".").last}";

  static void reparerBDD({required bool showToast}) {
    String serverDir = getServerDirectory();
    var url = "$serverDir/REPARER_BDD.php";
    print(url);
    Uri myUri = Uri.parse(url);
    http
        .post(myUri, body: {})
        .timeout(Duration(seconds: timeOut))
        .then((response) async {
          if (response.statusCode == 200) {
            var result = response.body;
            if (result != "0") {
              if (showToast) {
                AppData.mySnackBar(
                    title: 'Base de Données',
                    message: "La base de données à été réparer ...",
                    color: AppColor.green);
              }
            } else {
              if (showToast) {
                AppData.mySnackBar(
                    title: 'Base de Données',
                    message:
                        "Probleme lors de la réparation de la base de données !!!",
                    color: AppColor.red);
              }
            }
          } else {
            if (showToast) {
              AppData.mySnackBar(
                  title: 'Base de Données',
                  message: "Probleme de Connexion avec le serveur 5!!!",
                  color: AppColor.red);
            }
          }
        })
        .catchError((error) {
          print("erreur : $error");
          if (showToast) {
            AppData.mySnackBar(
                title: 'Base de Données',
                message: "Probleme de Connexion avec le serveur 6!!!",
                color: AppColor.red);
          }
        });
  }
}
