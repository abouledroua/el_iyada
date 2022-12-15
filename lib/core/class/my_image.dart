import 'package:flutter/services.dart';

class MyImage {
  String chemin, date_image, libelle, cb;
  int id, type;
  bool error, add, loading, deleting;
  Uint8List data;
  MyImage(
      {required this.chemin,
      required this.cb,
      required this.deleting,
      required this.loading,
      required this.data,
      required this.error,
      required this.add,
      required this.type,
      required this.date_image,
      required this.libelle,
      required this.id});
}
