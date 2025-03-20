import '../../../../export.dart';
import '../controllers/home_controller_2.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainViewController>(
      () => MainViewController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<HomeController2>(
      () => HomeController2(),
    );
  }
}
