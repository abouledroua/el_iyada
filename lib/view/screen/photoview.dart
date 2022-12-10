import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/photoview_controller.dart';
import '../../core/class/my_image.dart';
import '../widget/image_page/photo_view/backarrowphotoview.dart';
import '../widget/image_page/photo_view/bottomhorizontallistphotosphotoview.dart';
import '../widget/image_page/photo_view/bottompagephotoview.dart';
import '../widget/image_page/photo_view/nextarrowphotoview.dart';
import '../widget/image_page/photo_view/photowidget.dart';
import '../widget/image_page/photo_view/toppagephotoview.dart';
import '../widget/mywidget.dart';

class PhotoViewPage extends StatelessWidget {
  final int index;
  final List<MyImage> myImages;

  const PhotoViewPage({Key? key, required this.index, required this.myImages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MyPhotoViewController(index: index));
    return MyWidget(
        child: Column(children: [
      TopPagePhotoView(titleAnnonce: myImages[index].libelle),
      Expanded(
          child: Stack(children: [
        PhotoWidget(myImages: myImages),
        const BackArrowButtonPhotoView(),
        NextArrowButtonPhotoView(nbImages: myImages.length),
      ])),
      BottomHorizontalListPhotosPhotoView(myImages: myImages),
      BottomPagePhotoView(myImages: myImages)
    ]));
  }
}
