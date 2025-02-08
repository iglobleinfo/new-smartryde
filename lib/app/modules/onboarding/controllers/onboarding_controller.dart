




import 'package:smart_ryde/app/modules/onboarding/entity/pageview_model.dart';

import '../../../../../export.dart';


class OnboardingController extends GetxController {
  var introKey = GlobalKey<IntroductionScreenState>();

  var page = pages;
  int currentIndex = 0;

  onSkip() {
    storage.write(LOCALKEY_onboarding, true);
    Get.offAllNamed(AppRoutes.logIn);
  }

  onSlide(index) {
    currentIndex = index;
    update();
  }
}
