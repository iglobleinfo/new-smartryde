import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_ryde/app/core/values/app_assets.dart';
import 'package:smart_ryde/app/core/values/app_colors.dart';
import 'package:smart_ryde/app/core/widgets/custom_back_button.dart';
import 'package:smart_ryde/app/core/widgets/outline_button_widget.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/dimens.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/asset_image.dart' show AssetImageWidget;
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/otp_input.dart';
import '../../../core/widgets/text_view.dart';
import 'verify_otp_controller.dart';

class VerifyOtpPage extends GetView<VerifyOtpController> {
  const VerifyOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyOtpController>(
        init: VerifyOtpController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(),
                  getOtpVerificationForm(context),
                  AssetImageWidget(
                    imageUrl: imageBusSmallLogin,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget getOtpVerificationForm(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              stringVerificationOTP.tr,
              style: textStyleDisplayMedium(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              strOtpSentDescription.tr,
              style: textStyleBodyMedium(context).copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 30),
          OtpInput(
            controller: controller.otpController,
            focusNode: controller.otpFocusNode,
            focusColor: primaryColor,
            onCompleted: controller.changePin,
            otpLength: 4,
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: margin_20),
            child: Row(
              children: [
                Expanded(
                  child: OutlineButtonWidget(
                    onTap: () {
                      controller.hitGenerateOtpAPI(context);
                    },
                    outlineColor: appButtonColor,
                    text: 'Resend'.tr.toUpperCase(),
                    textStyle: textStyleButton(context).copyWith(
                      color: appButtonColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: MaterialButtonWidget(
                      buttonText: 'Verify'.toUpperCase(),
                      onPressed: () {
                        controller.verifyOtp(context);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
