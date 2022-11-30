import 'package:azlistview/azlistview.dart';

class Patient extends ISuspensionBean {
  String name, adresse, cb, tel, ageS, dateC;
  int age, sexe, typeAge, gs;
  bool isHomme, isFemme;
  Patient(
      {required this.cb,
      required this.typeAge,
      required this.dateC,
      required this.age,
      required this.ageS,
      required this.gs,
      required this.tel,
      required this.name,
      required this.isHomme,
      required this.isFemme,
      required this.adresse,
      required this.sexe});

  @override
  String getSuspensionTag() => name[0].toUpperCase();
}
