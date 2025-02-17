import '../../../../export.dart';
import '../controllers/my_profile_controller.dart';
import '../controllers/profile_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<MyProfileController>(
      () => MyProfileController(),
    );
  }
}
