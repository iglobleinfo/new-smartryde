




import 'package:smart_ryde/app/modules/splash/controllers/splash_controller.dart';

import '../../../../export.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}
