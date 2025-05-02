import 'package:smart_ryde/app/modules/authentication/controllers/my_booking_controller.dart';

import '../../../../export.dart';
import '../controllers/feedback_controller.dart';
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
    Get.lazyPut<FeedbackController>(
      () => FeedbackController(),
    );
    Get.lazyPut<MyBookingController>(
      () => MyBookingController(),
    );
  }
}
