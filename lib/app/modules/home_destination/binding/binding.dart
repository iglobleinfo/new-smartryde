import '../../../../export.dart';
import '../controller/home_destination_controller.dart';

class HomeDestinyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeDestinyController>(
      () => HomeDestinyController(),
    );
  }
}
