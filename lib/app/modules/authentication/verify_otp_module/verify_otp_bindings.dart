import 'verify_otp_controller.dart';
import 'package:get/get.dart';


class VerifyOtpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyOtpController());
  }
}