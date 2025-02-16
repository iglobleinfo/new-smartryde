import 'package:smart_ryde/export.dart';


class VerifyOtpController extends GetxController {
  final TextEditingController otpController = TextEditingController();

  final FocusNode otpFocusNode = FocusNode();

  late String phoneNumber;

  void changePin(String value) {}

  @override
  void onInit() {
    phoneNumber = Get.arguments['phoneNumber']??'';
    super.onInit();
  }

  Future<void> verifyOtp(context) async {
    customLoader.show(context);
    FocusManager.instance.primaryFocus!.unfocus();
    MessageResponseModel? successResponse =
        await APIRepository.verifyOtpApi(otpController.text);
    if (successResponse != null) {
      customLoader.hide();
      toast(successResponse.message);
      Get.offAllNamed(AppRoutes.home);
    }
  }

  /*===================================================================== SignUp API Call  ==========================================================*/
  hitGenerateOtpAPI(context) {
    customLoader.show(context);
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.generateOtpApi(phoneNumber).then((value) async {
      customLoader.hide();
      toast('OTP send successfully');
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }
}
