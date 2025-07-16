import 'package:smart_ryde/app/modules/language/model/language_model.dart';

import '../../../../export.dart';
import '../../../core/values/route_arguments.dart';

class SelectLanguageController extends GetxController {
  RxInt selectedLanguage = 1.obs;

  RxBool isDrawerType = false.obs;
  bool isLangType = false;

  int selectedLangIndex = 0;

  Rx<Language> selectLanguage = Rx(Language.en);

  final PreferenceManger _preferenceManger = PreferenceManger();

  navigateToNextScreen() {
    if (isDrawerType.value == true) {
      Get.back();
    } else {
      Get.toNamed(AppRoutes.logIn);
    }
  }

  List<LanguageModel> languageList = [
    LanguageModel(language: Language.en, name: keyEnglish.tr),
    LanguageModel(language: Language.sch, name: keySimplifiedChinese.tr),
    LanguageModel(language: Language.tch, name: keyTraditionalChinese.tr),
  ];

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
  void changeLanguage(Language language) async {
    selectLanguage.value = language;
    appLanguage = language;
    await _preferenceManger.saveLanguageCode(language.name);
    Get.updateLocale(Locale(language.name));
    Get.back();
  }
}
