import '../../../../export.dart';
import '../controller/book_seat_controller.dart';
import '../controller/bus_controller.dart';

class BusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusController>(
      () => BusController(),
    );
    Get.lazyPut<BookSeatController>(
      () => BookSeatController(),
    );
  }
}
