

import '../../../../export.dart';

class AboutUsController extends GetxController {
  final PreferenceManger _preferenceManger = Get.put(PreferenceManger());
  MessageResponseModel messageResponseModel = MessageResponseModel();
  ResponseModel responseModel = ResponseModel();

  bool isLoading = false;

  late TextEditingController pinController;
  FocusNode focusNode = FocusNode();

  TextEditingController languageTextController = TextEditingController();
  FocusNode languageFocusNode = FocusNode();

  String? selectedValue;
  bool isLanguage = true;
  var langValue = 0;
  bool notifyOn = false;

  RxInt selectedIndex = 0.obs;

  bool isYesClicked = false;
  bool isNoClicked = false;

  String versionNumber = "";
  String packageName = "";

  @override
  void onInit() {
    if (_preferenceManger.getNotification() != null) {
      notifyOn = _preferenceManger.getNotification();
    }
    getVersionDetails();
    initEditTextController();
    initFocusNodes();
    super.onInit();
  }

  getVersionDetails() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionNumber = packageInfo.version;
    packageName = packageInfo.packageName;
    update();
  }

  /* =========================================================init all edit text that are used in this controller ============================================*/

  initEditTextController() {
    pinController = TextEditingController();
  }

  /* =========================================================init all focus nodes that are used in this screen =================================================*/
  initFocusNodes() {
    focusNode = FocusNode();
  }

}
