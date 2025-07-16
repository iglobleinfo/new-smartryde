import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ryde/app/core/translations/languages/en_Us.dart';
import 'package:smart_ryde/app/core/translations/languages/simplified-ch.dart';
import 'package:smart_ryde/app/core/translations/languages/traditional-ch.dart';
import '../values/app_constant.dart';

class TranslationService extends Translations {
  static final locales = {
    Language.en: const Locale('en'),
    Language.sch: const Locale('sch'),
    Language.tch: const Locale('tch'),
  };

  @override
  Map<String, Map<String, String>> get keys => {
        'en': enUS,
        'sch': zhCN,
        'tch': zhHK,
      };

  static Locale getLocaleFromLanguage(Language lang) => locales[lang]!;

  static const fallbackLocale = Locale('en');
}
