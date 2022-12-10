import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../../../controller/photoview_controller.dart';
import '../../../../core/class/my_image.dart';

class PhotoWidget extends StatelessWidget {
  final List<MyImage> myImages;
  const PhotoWidget({Key? key, required this.myImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPhotoViewController>(
        builder: (controller) => RotatedBox(
            quarterTurns: controller.quarterTurns,
            child: PhotoViewGallery.builder(
                loadingBuilder: (context, event) =>
                    const Center(child: CircularProgressIndicator()),
                onPageChanged: (index) => controller.updateIndex(index),
                pageController: controller.pageController,
                itemCount: myImages.length,
                builder: (context, i) {
                  var data = myImages[controller.index].data;
                  return PhotoViewGalleryPageOptions(
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.contained * 4,
                      imageProvider: MemoryImage(data));
                })));
  }
}
