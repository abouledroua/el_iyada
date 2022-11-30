import 'package:azlistview/azlistview.dart';

class RDV extends ISuspensionBean {
  String name, cb, motif, ageS, heure_arrivee;
  int age, typeAge, etat, numReq, sexe;
  RDV(
      {required this.cb,
      required this.typeAge,
      required this.heure_arrivee,
      required this.ageS,
      required this.age,
      required this.etat,
      required this.sexe,
      required this.name,
      required this.numReq,
      required this.motif});

  @override
  String getSuspensionTag() => name[0].toUpperCase();
}
