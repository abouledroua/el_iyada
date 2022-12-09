import 'package:flutter/services.dart';

class MyImage {
  String chemin, date_image, libelle;
  int id, type, etat;
  bool loading;
  Uint8List data;
  MyImage(
      {required this.chemin,
      required this.etat,
      required this.loading,
      required this.data,
      required this.type,
      required this.date_image,
      required this.libelle,
      required this.id});
}
