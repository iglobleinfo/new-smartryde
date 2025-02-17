import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_ryde/app/core/values/text_styles.dart';

import '../utils/image_picker_and_cropper.dart';

class ImagePickerDialog extends StatelessWidget {
  ImagePickerDialog({
    super.key,
    required this.imageSelected,
  });
  final Function(XFile?) imageSelected;

  static late BuildContext _context;

  Widget get _getTopRow => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 12),
              Text(
                'Profile picture',
                style: textStyleTitle(_context),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(_context);
            },
            icon: const Icon(
              color: Colors.black,
              size: 40,
              Icons.close,
            ),
          ),
        ],
      );

  Widget get _getCameraGalleryRow => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          getCameraGalleryIcon(
              title: 'camera', icon: Icon(Icons.camera), index: 0),
          getCameraGalleryIcon(
            title: 'Gallery',
            icon: Icon(Icons.image),
            index: 1,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            _getTopRow,
            SizedBox(height: 15.h),
            _getCameraGalleryRow,
          ],
        ),
      ),
    );
  }

  String image = '';
  XFile? pickedFile;

  Widget getCameraGalleryIcon({
    required String title,
    required Icon icon,
    required int index,
    GestureTapCallback? onTap,
    BuildContext? context,
  }) =>
      Column(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              if (index == 0) {
                pickedFile = await imageFromCamera(_context);
              } else {
                pickedFile = await imageFromGallery(_context);
              }
              imageSelected.call(pickedFile);
            },
            child: Container(
              height: 64.r,
              width: 64.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(64.r),
                border: Border.all(
                  color: const Color.fromRGBO(255, 255, 255, 0.2),
                ),
              ),
              child: Center(child: icon),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: textStyleDisplayMedium(_context).copyWith(
              color: Colors.black,
            ),
          ),
        ],
      );
}
