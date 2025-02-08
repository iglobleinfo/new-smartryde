



import 'package:smart_ryde/app/modules/onboarding/controllers/onboarding_controller.dart';

import '../../../../export.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(),
    );
  }
}
