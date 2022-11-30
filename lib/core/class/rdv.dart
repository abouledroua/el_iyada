import 'package:azlistview/azlistview.dart';

class RDV extends ISuspensionBean {
  String name, cb, motif;
  int age, numRDV, typeAge, etat, typeReq;
  RDV(
      {required this.cb,
      required this.typeAge,
      required this.age,
      required this.numRDV,
      required this.etat,
      required this.name,
      required this.typeReq,
      required this.motif});

  @override
  String getSuspensionTag() => name[0].toUpperCase();
}
