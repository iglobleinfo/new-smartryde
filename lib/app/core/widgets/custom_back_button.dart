import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ryde/app/core/values/app_assets.dart';
import 'package:smart_ryde/app/core/widgets/asset_image.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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
    );
  }
}
