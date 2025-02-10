import '../../../export.dart';
import 'languages/en_Us.dart';
import 'languages/heb_He.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;

  static final fallbackLocale = Locale('en', 'he');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'he_HB': he_HB,
      };
}
