import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ryde/app/core/values/app_colors.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/dimens.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/otp_input.dart';
import 'verify_otp_controller.dart';

class VerifyOtpPage extends GetView<VerifyOtpController> {
  const VerifyOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyOtpController>(
        init: VerifyOtpController(),
        builder: (controller) {
      return Scaffold(
        // appBar: CustomAppbar(title: strEnterOtp.tr),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
