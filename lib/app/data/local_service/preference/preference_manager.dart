import '../../../../export.dart';
import '../../../modules/authentication/model/login_data_model.dart';
import '../../../modules/authentication/model/remember_me.dart';
import '../../../modules/language/controllers/select_language_controller.dart';

double lowerValue = 50;
double upperValue = 1000;

class PreferenceManger {
  static bool? isNewArrival = false;
  static bool? isTopItem = false;
  static double lowerValue = 50;
  static double upperValue = 1000;
  static int rating = 0;
  static String size = "";

  static const String isFirstLaunch = "isFirstLaunch";
  static const String authToken = "authToken";
  static const String loginResponseModel = "loginResponseModel";
  static const String staticResponseModel = "staticResponseModel";
  static const String rememberMe = "rememberMe";
  static const String isNotification = "isNotification";
  static const String email = "email";
  static const String password = "password";
  static const String rememberMeTeacher = "rememberMeTeacher";
  static const String notificationOn = "notificationOn";
  static const String defaultCurrency = "defaultCurrency";
  static const String changeLanguage = "changeLanguage";

  firstLaunch(bool? isFirstCheck) {
    storage.write(isFirstLaunch, isFirstCheck);
  }

  saveAuthToken(String? token) {
    storage.write(authToken, token);
  }

  saveLoginType(bool value) {
    storage.write("skip", value);
  }

  getLoginType() {
    return storage.read("skip");
  }

  getAuthToken() {
    return storage.read(authToken);
  }

  getStatusFirstLaunch() {
    return storage.read(isFirstLaunch);
  }

  saveRegisterData(LoginDataModel? model) async {
    storage.write(loginResponseModel, jsonEncode(model));
    debugPrint("Data Saved ---------- Data Saved");
  }

  getSavedLoginData() async {
    Map<String, dynamic>? userMap;
    final userStr = await storage.read(loginResponseModel);
    if (userStr != null) userMap = jsonDecode(userStr) as Map<String, dynamic>;
    if (userMap != null) {
      LoginDataModel user = LoginDataModel.fromJson(userMap);
      return user;
    }
    return null;
  }

  saveRemeberMeData(RememberMeModel? model) async {
    storage.write(rememberMe, jsonEncode(model));
  }

  clearRemeberMeData() {
    storage.remove(rememberMe);
  }

  clearLoginData() {
    storage.remove(loginResponseModel);
    storage.remove(authToken);
    storage.remove(notificationOn);
  }

  Future getsaveRemeberData() async {
    Map<String, dynamic>? userMap;
    final userStr = await storage.read(rememberMe);
    if (userStr != null) userMap = jsonDecode(userStr) as Map<String, dynamic>;
    if (userMap != null) {
      RememberMeModel user = RememberMeModel.fromJson(userMap);
      return user;
    }
    return null;
  }

  saveNotification(bool? notify) {
    storage.write(notificationOn, notify);
  }

  getNotification() {
    return storage.read(notificationOn);
  }

  Future<ChooseLanguage> getLocalLanguageData() async {
    try {
      int code = await storage.read(changeLanguage);
      return getLanguageEnumModal(code);
    } catch (e) {
      return ChooseLanguage.english;
    }
  }

  getLanguageCodeModal(ChooseLanguage chooseLanguage) {
    switch (chooseLanguage) {
      case ChooseLanguage.english:
        return 0;
      case ChooseLanguage.hebrew:
        return 1;
      default:
        return 0;
    }
  }

  ChooseLanguage getLanguageEnumModal(int code) {
    switch (code) {
      case 0:
        return ChooseLanguage.english;
      case 1:
        return ChooseLanguage.hebrew;
      default:
        return ChooseLanguage.english;
    }
  }

  saveLocalLanguageData(ChooseLanguage chooseLanguage) async {
    storage.write(changeLanguage, getLanguageCodeModal(chooseLanguage));
  }
}
