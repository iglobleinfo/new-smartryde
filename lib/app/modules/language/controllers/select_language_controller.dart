import 'package:smart_ryde/app/modules/authentication/model/login_data_model.dart';
import 'package:smart_ryde/app/modules/home_booking/controller/home_booking_controller.dart';
import 'package:smart_ryde/app/modules/language/model/language_model.dart';
import 'package:smart_ryde/model/error_response_model.dart';

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

  /*===================================================================== Update Language API Call  ==========================================================*/
  hitUpdateLangAPI(context) async {
    customLoader.show(context);
    LoginDataModel? userData = await PreferenceManger().getUserData();
    APIRepository.updateLanguageApiCall(
      userId: userData!.id.toString(),
    ).then((ErrorMessageResponseModel? value) async {
      customLoader.hide();
      // PreferenceManger().saveUserData(loginModel!.data!);
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
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
  void changeLanguage(Language language, BuildContext context) async {
    selectLanguage.value = language;
    appLanguage = language;
    if (PreferenceManger().getStatusUserLogin() ?? false) {
      hitUpdateLangAPI(context);
    }
    await _preferenceManger.saveLanguageCode(language.name);
    Get.updateLocale(Locale(language.name));
    Get.find<HomeBookingController>().hitGetDistrict();
    Get.back();
  }
}
