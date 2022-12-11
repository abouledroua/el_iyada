// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../controller/page_docs_images_controller.dart';
import '../constant/data.dart';
import 'image_upload.dart';

class GestImages {
  static List<MyImageUpload> myImages = [];
  static bool _uploading = false;
  static const delayDuration = Duration(seconds: 4);

  static uploadImages() async {
    if (!_uploading && myImages.isNotEmpty) {
      print("     *******************  uploading image ****************");
      send(myImages[0]);
    } else {
      print(_uploading
          ? "Someone else is uploading ..."
          : "waiting for images ...");
    }
    Timer(delayDuration, uploadImages);
  }

  static void send(MyImageUpload image) async {
    String serverDir = AppData.getServerDirectory();
    final String url = "$serverDir/UPLOAD_GALLERY.php";
    print(url);
    Uri myUri = Uri.parse(url);
    var body = {};
    body['data'] = uint8ListTob64(image.data);
    body['ID_MALADE'] = image.cb;
    body['TYPE'] = image.type.toString();
    body['ext'] = AppData.extension(filename: image.chemin);
    http.post(myUri, body: body).then((result) {
      if (result.statusCode == 200) {
        print(result.body);
        PageDocsImagesController controller = Get.find();
        controller.getImages();
      } else {
        print("ImageGallery : Error Uploading Image");
      }
      _uploading = false;
    }).catchError((error) {
      print("ImageGallery : erreur : $error");
    });
    myImages.removeAt(0);
  }

  static String uint8ListTob64(Uint8List? imageData) {
    String base64String = base64Encode(imageData!);
    return base64String;
  }
}
