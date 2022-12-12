import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/class/gest_photos.dart';
import 'core/constant/color.dart';
import 'core/services/settingservice.dart';
import 'view/screen/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // hide keyboard on start
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  // force orientation landscape only
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  await initialService();
  GestImages.uploadImages();
  runApp(const MyApp());
}

Future initialService() async {
  await Get.putAsync(() => SettingServices().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EL IYADA',
        home: const WelcomePage(),
        theme: ThemeData(
            primaryColor: AppColor.blue1,
            textTheme: const TextTheme(
                headline1: TextStyle(
                    color: AppColor.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Traditional"),
                headline2: TextStyle(
                    color: AppColor.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Traditional"),
                headline3: TextStyle(
                    color: AppColor.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Traditional"),
                bodyText1: TextStyle(
                    color: AppColor.black,
                    fontSize: 14,
                    fontFamily: "Traditional"),
                bodyText2: TextStyle(
                    color: AppColor.black,
                    fontSize: 11,
                    fontFamily: "Traditional"),
                button: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "Traditional"))));
  }
}
