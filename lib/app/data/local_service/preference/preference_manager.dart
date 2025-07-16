import '../../../../export.dart';
import '../../../modules/authentication/model/login_data_model.dart';
import '../../../modules/authentication/model/remember_me.dart';

double lowerValue = 50;
double upperValue = 1000;

class PreferenceManger {
  static bool? isNewArrival = false;
  static bool? isTopItem = false;
  static double lowerValue = 50;
  static double upperValue = 1000;
  static int rating = 0;
  static String size = "";

  static const String isLogin = "isLogin";
  static const String profile = "profile";
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
  static const String currentLanguage = "currentLanguage";

  isUserLogin(bool? isUserLogin) {
    storage.write(isLogin, isUserLogin);
  }

  getStatusUserLogin() {
    return storage.read(isLogin);
  }

  saveProfilePic(String? path) {
    return storage.write(profile, path);
  }

  getProfilePic() {
    return storage.read(profile);
  }

  saveUserData(LoginDataModel loginDataModel) {
    storage.write(loginResponseModel, jsonEncode(loginDataModel.toJson()));
    debugPrint("Saved------M>");
  }

  Future<LoginDataModel?> getUserData() async {
    Map<String, dynamic>? userMap;
    final userStr = await storage.read(loginResponseModel);
    if (userStr != null) userMap = jsonDecode(userStr);
    if (userMap != null) {
      LoginDataModel user = LoginDataModel.fromJson(userMap);
      return user;
    }
    return null;
  }

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

  // get saved language code
  Future<Language> getSavedLanguage() async {
    bool hasLanguage = storage.hasData(currentLanguage);
    if (hasLanguage) {
      String language = await storage.read(currentLanguage);
      return languageFromString(language);
    } else {
      return Language.en;
    }
  }

  // save language code
  Future<void> saveLanguageCode(String language) async {
    await storage.write(currentLanguage, language);
  }
}
