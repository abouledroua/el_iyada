import 'package:flutter/material.dart';
import '../../core/constant/color.dart';

class BuildHeaderLists extends StatelessWidget {
  final String tag;
  const BuildHeaderLists({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        color: AppColor.greyShade,
        padding: const EdgeInsets.symmetric(vertical: 4),
        alignment: Alignment.center,
        child: Text(tag,
            softWrap: false,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)));
  }
}
