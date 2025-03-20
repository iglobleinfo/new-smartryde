import '../../../../export.dart';
import '../controller/home_booking_controller.dart';

class HomeBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeBookingController>(
      () => HomeBookingController(),
    );
  }
}
