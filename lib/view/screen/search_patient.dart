import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/list_patients_controller.dart';
import '../../core/constant/color.dart';
import '../widget/mywidget.dart';

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
            child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                    child: GetBuilder<ListPatientsController>(
                        builder: (controller) => TextFormField(
                            controller: controller.txtName,
                            maxLines: 1,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.search,
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
                                          onPressed: () {},
                                          icon: Icon(Icons.cancel_outlined,
                                              color: AppColor.red)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.search))
                                    ]),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.black),
                                    borderRadius:
                                        BorderRadius.circular(16)))))))));
  }
}
