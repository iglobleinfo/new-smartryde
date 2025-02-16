import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_ryde/app/core/utils/validators.dart';
import 'package:smart_ryde/app/core/values/app_strings.dart';
import 'package:smart_ryde/app/core/widgets/custom_flashbar.dart';
import 'package:smart_ryde/app/data/remote_service/entity/request_model/auth_reuest_model.dart';
import 'package:smart_ryde/app/data/remote_service/network/api_provider.dart';
import 'package:smart_ryde/main.dart';

class ForgotPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController countryPickerController = TextEditingController();
  final TextEditingController otpTextController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool viewPassword = RxBool(false);

  @override
  void onInit() {
    countryPickerController.text = '+825';
    super.onInit();
  }

  hitGenerateOtpAPI(context) {
    String? result = phoneTextFieldValidator(
        countryPickerController.text, phoneNumberController.text, context);
    if (result != null) {
      toast(result);
      return;
    }
    customLoader.show(context);
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.generateOtpApi(
            '${countryPickerController.text}${phoneNumberController.text}')
        .then((value) async {
      customLoader.hide();
      toast('OTP send successfully');
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  Future<void> hitSubmitPassword(BuildContext context) async {
    // Check The Phone Text Field Validator
    String? result = phoneTextFieldValidator(
        countryPickerController.text, phoneNumberController.text, context);
    if (result != null) {
      toast(result);
      return;
    }
    // Check The Otp
    if (otpTextController.text.isEmpty) {
      toast(stringOtpEmptyValidation.tr);
      return;
    }
    // Check The Password
    if (passwordController.text.isEmpty) {
      toast(stringPasswordEmptyValidation.tr);
      return;
    }

    // Hit The Forgot Password Api
    var forgotRequest = AuthRequestModel.forgetReq(
      phoneNumber: countryPickerController.text + phoneNumberController.text,
      otp: otpTextController.text,
      password: passwordController.text,
    );
    customLoader.show(context);
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.forgotPasswordApi(forgotRequest)
        .then((value) async {
      customLoader.hide();
      Get.back();
      toast(stringPasswordChangedSuccessfully.tr);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  void showOrHidePasswordVisibility() {
    viewPassword.value = !viewPassword.value;
    update();
  }
}
