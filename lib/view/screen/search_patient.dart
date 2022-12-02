import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/keyboard_controller.dart';
import '../../controller/list_patients_controller.dart';
import '../../core/constant/color.dart';
import '../widget/homepage/statistics.dart';
import '../widget/mywidget.dart';
import 'qrcodescanner.dart';

class SearchPatient extends StatelessWidget {
  const SearchPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyWidget(
        title: "Rechercher un Patient",
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(children: [
              Spacer(),
              GetBuilder<ListPatientsController>(
                  builder: (controller) => Visibility(
                      visible: controller.filter,
                      child: Row(children: [
                        CircularProgressIndicator.adaptive(),
                        SizedBox(width: 20),
                        Text('Recherche en cours ...')
                      ]),
                      replacement: Row(children: [
                        Spacer(flex: 3),
                        Expanded(
                            flex: 8,
                            child: TextFormField(
                                controller: controller.txtName,
                                maxLines: 1,
                                //     autofocus: true,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.search,
                                onFieldSubmitted: (value) =>
                                    controller.search(),
                                decoration: InputDecoration(
                                    hintText: 'Nom du patient',
                                    hintStyle: const TextStyle(fontSize: 14),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    label: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 9),
                                        child: Text('Nom du patient')),
                                    suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                controller.updateQuery("");
                                              },
                                              icon: Icon(Icons.cancel_outlined,
                                                  color: AppColor.red)),
                                          IconButton(
                                              onPressed: () {
                                                controller.search();
                                              },
                                              icon: Icon(Icons.search))
                                        ]),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColor.black),
                                        borderRadius:
                                            BorderRadius.circular(16))))),
                        Spacer(flex: 3),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: AppColor.white,
                                backgroundColor: AppColor.black),
                            onPressed: () async {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const QRViewExample()))
                                  .then((data) async {
                                if (data != null) {
                                  print('cb = ' + data);
                                  String cbNew = data;
                                  cbNew = cbNew.substring(0, cbNew.length - 1);
                                  print('cb = ' + cbNew);
                                  ListPatientsController contr = Get.find();
                                  int i, cbValue = int.parse(cbNew);
                                  print('cb = $cbValue');
                                  for (var item in contr.allPatients) {
                                    i = int.parse(item.cb);
                                    if (i == cbValue) {
                                      print('i found it !!!!');
                                      contr.updateQuery(item.name);
                                      break;
                                    }
                                  }
                                }
                              });
                            },
                            icon: Icon(Icons.bar_chart_rounded),
                            label: Text("Code Barre")),
                        Spacer()
                      ]))),
              Spacer(),
              GetBuilder<KeyboardController>(
                  builder: (controller) => Visibility(
                      visible: !controller.keyboadrShow, child: Statistics()))
            ])));
  }
}
