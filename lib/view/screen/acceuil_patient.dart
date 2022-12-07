import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/acceuil_patient_controller.dart';
import '../../controller/list_patients_controller.dart';
import '../../core/class/patient.dart';
import '../../core/constant/color.dart';
import '../widget/mywidget.dart';
import 'page_docs_images.dart';

class AcceuilPatient extends StatelessWidget {
  final String cb;
  const AcceuilPatient({Key? key, required this.cb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AcceilPatientController(cb: cb));
    return MyWidget(
        title: "Fiche Patient",
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(children: [
              SizedBox(height: 8),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: AppColor.yellowClaire,
                  child: myInfos(context)),
              Divider(thickness: 1),
              Spacer(),
              myBtns(context),
              Spacer()
            ])));
  }

  myBtns(BuildContext context) =>
      GetBuilder<ListPatientsController>(builder: (controller) {
        Patient patient = controller.searchPatientByCb(cb: cb);
        return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          if (patient.dateC.isEmpty)
            Text('Aucune Consultation',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: AppColor.red)),
          if (patient.dateC.isNotEmpty)
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    foregroundColor: AppColor.white,
                    backgroundColor: AppColor.blue1),
                onPressed: () {},
                icon: Icon(Icons.medical_information_outlined),
                label: Text("Ordonnances")),
          if (patient.dateC.isNotEmpty)
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    foregroundColor: AppColor.white,
                    backgroundColor: AppColor.pink),
                onPressed: () {},
                icon: Icon(Icons.checklist_sharp),
                label: Text("Bilans")),
          if (patient.dateC.isNotEmpty)
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    foregroundColor: AppColor.white,
                    backgroundColor: AppColor.bleuFacebook),
                onPressed: () {},
                icon: Icon(Icons.perm_device_information_outlined),
                label: Text("Infos Supplémentaires")),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  foregroundColor: AppColor.white,
                  backgroundColor: AppColor.vertPers),
              onPressed: () {
                Get.to(() => PageDocsImages(cb: cb));
              },
              icon: Icon(Icons.document_scanner_rounded),
              label: Text("Documents & Imageries"))
        ]);
      });

  myInfos(BuildContext context) =>
      GetBuilder<ListPatientsController>(builder: (controller) {
        Patient patient = controller.searchPatientByCb(cb: cb);
        return Column(mainAxisSize: MainAxisSize.min, children: [
          infoRow(context: context, libele: 'Nom : ', data: patient.name),
          infoRow(context: context, libele: 'Age : ', data: patient.ageS),
          if (patient.tel.isNotEmpty)
            infoRow(context: context, libele: 'Tel : ', data: patient.tel),
          if (patient.dateC.isNotEmpty)
            infoRow(
                context: context,
                libele: 'Derniére Consultation : ',
                data: patient.dateC),
          if (patient.gs > 0)
            infoRow(
                context: context,
                libele: 'Groupe sanguin : ',
                data: patient.gs == 1
                    ? "A+"
                    : patient.gs == 2
                        ? "A-"
                        : patient.gs == 3
                            ? "B+"
                            : patient.gs == 4
                                ? "B-"
                                : patient.gs == 5
                                    ? "AB+"
                                    : patient.gs == 6
                                        ? "AB-"
                                        : patient.gs == 1
                                            ? "O+"
                                            : "O-")
        ]);
      });

  infoRow(
          {required BuildContext context,
          required String libele,
          required String data}) =>
      Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(libele, style: Theme.of(context).textTheme.headline1),
            FittedBox(
                child: Text(data,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontWeight: FontWeight.normal)))
          ]));
}
