import 'package:flutter/material.dart';

class VerticalDividerWidget extends StatelessWidget {
  final Color? color;
  final double? height, width;
  const VerticalDividerWidget(
      {Key? key, required this.color, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: height ?? 30.0,
        width: width ?? 1.0,
        color: color ?? Colors.white30,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      );
}
