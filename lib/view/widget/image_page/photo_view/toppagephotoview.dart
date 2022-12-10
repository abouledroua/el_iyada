import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/color.dart';

class TopPagePhotoView extends StatelessWidget {
  final String titleAnnonce;
  const TopPagePhotoView({Key? key, required this.titleAnnonce})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        color: AppColor.black,
        child: Row(children: [
          const SizedBox(width: 5),
          InkWell(
              onTap: () {
                Get.back();
              },
              child: Ink(
                  child: const Icon(Icons.arrow_back, color: AppColor.white))),
          const Spacer(),
          Text(titleAnnonce,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: AppColor.white)),
          const Spacer()
        ]));
  }
}
