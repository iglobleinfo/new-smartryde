


import '../../../../../export.dart';

class StaticPageController extends SuperController {
  List? faqList = [];
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  hitFaqAPI() {
    isLoading.value = true;
    APIRepository.faqApiCall().then((value) {
      faqList = value;
      isLoading.value = false;
      update();
    }).onError((error, stackTrace) {
      isLoading.value = false;
      toast(error);
    });
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}
