import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/data.dart';

class SettingServices extends GetxService {
  late SharedPreferences sharedPrefs;

  Future<SettingServices> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
    AppData.serverIP = sharedPrefs.getString('ServerAdress') ?? "10.0.2.2";
    return this;
  }
}
