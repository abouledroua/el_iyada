import 'package:flutter/services.dart';

class MyImageUpload {
  String chemin, cb;
  int type;
  Uint8List data;
  MyImageUpload(
      {required this.chemin,
      required this.cb,
      required this.data,
      required this.type});
}
