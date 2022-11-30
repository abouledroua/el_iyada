// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constant/color.dart';

class MyWidget extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;
  String? title;
  final List<Widget>? actions;
  Color? color;
  Widget? drawer, leading;

  MyWidget({
    Key? key,
    required this.child,
    this.color,
    this.title,
    this.drawer,
    this.actions,
    this.leading,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    title ??= "";
    return SafeArea(
        child: Scaffold(
            appBar: title!.isEmpty
                ? null
                : AppBar(
                    iconTheme: const IconThemeData(color: AppColor.black),
                    elevation: 0,
                    actions: actions,
                    centerTitle: true,
                    backgroundColor: color ?? AppColor.white,
                    leading: leading ??
                        (Navigator.canPop(context)
                            ? IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(Icons.arrow_back))
                            : null),
                    title: FittedBox(
                        child: Text(title!,
                            style: Theme.of(context).textTheme.headline1))),
            floatingActionButton: floatingActionButton,
            drawer: drawer,
            resizeToAvoidBottomInset: true,
            body: child));
  }
}
