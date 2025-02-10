/*
 *
 *  * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *  * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */



import '../../../../export.dart';
import '../../../core/translations/local_keys.dart';
import '../../../core/values/route_arguments.dart';
import '../../../data/local_service/preference/preference_manager.dart';
import '../model/language_model.dart';

enum ChooseLanguage { english, hebrew }

class SelectLanguageController extends GetxController {
  RxInt selectedLanguage = 1.obs;

  RxBool isDrawerType = false.obs;
  bool isLangType = false;

  int selectedLangIndex = 0;

  Rx<ChooseLanguage> selectLanguage = ChooseLanguage.english.obs;

  final PreferenceManger _preferenceManger = Get.put(PreferenceManger());

  navigateToNextScreen() {
    if (isDrawerType.value == true) {
      Get.back();
    } else {
      Get.toNamed(AppRoutes.logIn);
    }

    //  applyChanged();
  }

  List<CommonLanguageCalenderModel> languageList = [
    CommonLanguageCalenderModel(id: pageTypeEnglish, title: keyEnglish.tr),
  ];

  @override
  void onReady() {
    _preferenceManger.getLocalLanguageData().then((value) {
      selectLanguage.value = value;
    });
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments[isDrawer] != null) {
        isDrawerType.value = Get.arguments[isDrawer];
      }
    }
    super.onInit();
  }

  //=====================================change language function=================
  void changeLanguage(ChooseLanguage language) async {
    selectLanguage.value = language;
  }

  applyChanged() {
    if (selectLanguage.value == ChooseLanguage.english) {
      Get.updateLocale(Locale('en', 'US'));
    } else {
      Get.updateLocale(Locale('he', 'HB'));
    }
    _preferenceManger.saveLocalLanguageData(selectLanguage.value);
  }
}
