class Patient {
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
}
