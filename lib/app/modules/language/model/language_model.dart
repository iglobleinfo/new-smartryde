import '../../../core/values/app_constant.dart' show Language;

class LanguageModel {
  Language language;
  String name;

  LanguageModel({
    required this.language,
    required this.name,
  });
}

class LoginTypeModel {
  String? title;
  String? asset;
  bool isSelect = false;

  LoginTypeModel(this.title, this.asset, {this.isSelect = false});
}

class ButtonTypeModel {
  String? title;
  String? asset;
  bool isSelect = false;

  ButtonTypeModel(this.title, this.asset, {this.isSelect = false});
}
