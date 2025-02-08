

import 'package:get/get.dart';
import 'package:smart_ryde/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:smart_ryde/export.dart';


class SubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionController>(
      () => SubscriptionController(),
    );
  }
}
