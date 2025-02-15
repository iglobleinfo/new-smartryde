import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ryde/app/core/values/app_colors.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/dimens.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/otp_input.dart';
import '../../../core/widgets/text_view.dart';
import 'verify_otp_controller.dart';

class VerifyOtpPage extends GetView<VerifyOtpController> {
  const VerifyOtpPage({super.key});

  Widget getBackButtonRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: margin_8,
        vertical: margin_8,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_rounded,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyOtpController>(
        init: VerifyOtpController(),
        builder: (controller) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                getBackButtonRow(context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    strOtpSentDescription.tr,
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
                TextView(
                  text: doNotHaveAccountSignUpNow.tr,
                  textStyle: textStyleBodySmall(context).copyWith(
                    color: appClickableTextColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blueAccent,
                    decorationThickness: 1,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: MaterialButtonWidget(
                buttonText: 'Verify'.toUpperCase(),
                onPressed: () {
                  controller.verifyOtp(context);
                },
              ),
            ).marginOnly(bottom: margin_20),
          ],
        ),
      );
    });
  }
}
