import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ryde/app/core/values/app_assets.dart';
import 'package:smart_ryde/app/core/widgets/asset_image.dart';

import '../values/text_styles.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onTap, this.title});
  final GestureTapCallback? onTap;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap ??
              () {
                Get.back();
              },
          child: Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: AssetImageWidget(
                imageUrl: imageBack,
              ),
            ),
          ),
        ),
        Text(
          title ?? '',
          style: textStyleDisplayMedium(context).copyWith(
            fontWeight: FontWeight.normal,
            color: Colors.white,
            fontSize: 19
          ),
        ),
      ],
    );
  }
}
