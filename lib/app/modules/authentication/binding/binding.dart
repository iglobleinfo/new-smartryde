


import '../../../../export.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
     Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
  }
}
