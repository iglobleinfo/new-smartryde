


import '../../../../export.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainViewController>(
      () => MainViewController(),
    );
 Get.lazyPut<HomeController>(
      () => HomeController(),
    );
 Get.lazyPut<ItemController>(
      () => ItemController(),
    );
  }
}
