





/*
import 'package:smart_ryde/app/modules/onboarding/controllers/onboarding_controller.dart';

import '../../../../../export.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OnboardingController>(
        builder: (controller) => IntroductionScreen(
          key: controller.introKey,
          onDone: () {
            controller.onSkip();
          },
          onChange: (index) {
            controller.onSlide(index);
            log.i(index);
          },
          showDoneButton: false,
          showNextButton: false,
          showSkipButton: false,
          dotsFlex: 0,
          globalHeader: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 27,
                    width: 70,
                    child: OutlinedButton(
                      onPressed: () {
                        controller.onSkip();
                      },
                      child: Text(
                        */
/*controller.currentIndex == 2 ? 'done'.tr : *//*

                        'skip',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(colorPinkM)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          globalBackgroundColor: Colors.white,
          dotsDecorator: DotsDecorator(
              color: Colors.transparent,
              activeColor: Colors.transparent,
              activeShape: StadiumBorder(),
              activeSize: Size(25, 10)),
          rawPages: controller.page,
        ),
      ),
    );
  }
}
*/
///

import 'package:smart_ryde/app/modules/onboarding/controllers/onboarding_controller.dart';
import '../../../../../export.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OnboardingController>(
        builder: (controller) => IntroductionScreen(
          key: controller.introKey,
          onDone: () {
            controller.onSkip();
          },
          onChange: (index) {
            controller.onSlide(index);
            log.i(index);
          },
          showDoneButton: false,
          showNextButton: false,
          showSkipButton: false,
          dotsFlex: 0,
          globalHeader: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 27,
                    width: 70,
                    child: OutlinedButton(
                      onPressed: () {
                        controller.onSkip();
                      },
                      child: Text(
                        /*controller.currentIndex == 2 ? 'done'.tr : */
                        'skip',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(colorPinkM)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          globalBackgroundColor: Colors.white,
          dotsDecorator: DotsDecorator(
              color: Colors.transparent,
              activeColor: Colors.transparent,
              activeShape: StadiumBorder(),
              activeSize: Size(25, 10)),
          rawPages: controller.page,
        ),
      ),
    );
  }
}
