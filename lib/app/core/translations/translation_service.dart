/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 *  the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */

import '../../../export.dart';
import 'languages/heb_He.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;

  static final fallbackLocale = Locale('en', 'he');


  @override
  Map<String, Map<String, String>> get keys => {
         'en_US': en_US,
         'he_HB': he_HB,
      };
}
