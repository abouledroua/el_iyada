import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/data.dart';

class SettingServices extends GetxService {
  late SharedPreferences sharedPrefs;

  Future<SettingServices> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
    String s = sharedPrefs.getString('ServerAdress') ?? "";
    if (s == "") sharedPrefs.setString('ServerAdress', "10.0.2.2");
    AppData.serverIP = sharedPrefs.getString('ServerAdress')!;
    //AppData.serverIP = "33.33.33.33";
    return this;
  }
}
