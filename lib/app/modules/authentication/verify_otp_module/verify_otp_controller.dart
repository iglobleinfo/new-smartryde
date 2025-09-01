import 'package:smart_ryde/export.dart';

class VerifyOtpController extends GetxController {
  final TextEditingController otpController = TextEditingController();

  final FocusNode otpFocusNode = FocusNode();

  late String phoneNumber;

  void changePin(String value) {}

  @override
  void onInit() {
    phoneNumber = Get.arguments['phoneNumber'] ?? '';
    // phoneNumber = '+919050793243';
    super.onInit();
  }

  Future<void> verifyOtp(context) async {
    customLoader.show(context);
    FocusManager.instance.primaryFocus!.unfocus();
    var successResponse = await APIRepository.verifyOtpApi(
      phoneNumber: phoneNumber,
      otp: otpController.text,
    );
    if (successResponse != null) {
      customLoader.hide();
      Get.until((Route route) => route.settings.name == AppRoutes.onboarding);
    }
  }

  /*===================================================================== SignUp API Call  ==========================================================*/
  hitGenerateOtpAPI(context) {
    customLoader.show(context);
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.generateOtpApi(phoneNumber).then((value) async {
      customLoader.hide();
      toast(keyOtpSendSuccessfully.tr);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(keyInvalidOtpSend.tr);
    });
  }
}
