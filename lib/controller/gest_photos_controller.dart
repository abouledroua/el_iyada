// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/constant/sizes.dart';
import 'page_docs_images_controller.dart';
import '../core/constant/data.dart';
import '../core/class/image_upload.dart';

class GestImagesController extends GetxController {
  List<MyImageUpload> myImages = [];
  int nbImages = 0;
  bool _uploading = false;
  Duration delayDuration = Duration(seconds: 4);

  uploadImages() async {
    if (!_uploading && myImages.isNotEmpty) {
      _uploading = true;
      print("     *******************  uploading image ****************");
      send(myImages[0]);
    } else {
      print(_uploading
          ? "Someone else is uploading ..."
          : "waiting for images ...");
    }
    Timer(delayDuration, uploadImages);
  }

  send(MyImageUpload image) async {
    String serverDir = AppData.getServerDirectory();
    final String url = "$serverDir/UPLOAD_GALLERY.php";
    print(url);
    Uri myUri = Uri.parse(url);
    var body = {};
    body['data'] = uint8ListTob64(image.data);
    body['CODEBARRE'] = image.cb;
    body['TYPE'] = image.type.toString();
    body['ext'] = AppData.extension(filename: image.chemin);
    http.post(myUri, body: body).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        try {
          var responsebody = jsonDecode(response.body);
          if (responsebody == "1") {
            PageDocsImagesController controller = Get.find();
            controller.getImages();
          } else {
            addImage(myImages[0]);
          }
        } catch (e) {
          addImage(myImages[0]);
        }
        removeImage(0);
      } else {
        print("ImageGallery : Error Uploading Image");
      }
      _uploading = false;
    }).catchError((error) {
      print("ImageGallery : erreur : $error");
    });
  }

  String uint8ListTob64(Uint8List? imageData) {
    String base64String = base64Encode(imageData!);
    return base64String;
  }

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    uploadImages();
    super.onInit();
  }

  void addImage(MyImageUpload image) {
    print('add new image');
    myImages.add(image);
    nbImages = myImages.length;
    update();
  }

  void removeImage(int i) {
    print('removing image');
    myImages.removeAt(i);
    nbImages = myImages.length;
    update();
  }
}
