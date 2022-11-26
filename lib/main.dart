import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/services/settingservice.dart';
import 'view/screen/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  await initialService();
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
            primaryColor: Colors.blue,
            textTheme: const TextTheme(
                headline1: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Traditional"),
                headline2: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Traditional"),
                bodyText1: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontFamily: "Traditional"),
                bodyText2: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: "Traditional"),
                button: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "Traditional"))));
  }
}
