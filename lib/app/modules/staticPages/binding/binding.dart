

import 'package:get/get.dart';
import 'package:smart_ryde/app/modules/staticPages/controllers/static_page_controller.dart';
import 'package:smart_ryde/export.dart';

class WebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaticPageController>(
      () => StaticPageController(),
    );
  }
}
