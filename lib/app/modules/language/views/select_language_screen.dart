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

import 'package:smart_ryde/app/modules/language/model/language_model.dart';

import '../../../../export.dart';
import '../../../core/widgets/custom_back_button.dart';
import '../controllers/select_language_controller.dart';

class SelectLanguageScreen extends GetView<SelectLanguageController> {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectLanguageController>(
      init: SelectLanguageController(),
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              vertical: margin_16,
              // horizontal: margin_10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                CustomBackButton(),
                languageSelection(context: context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget languageSelection({
    required BuildContext context,
  }) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            TextView(
              text: keyChangeLanguage.tr,
              maxLine: 1,
              textStyle: textStyleTitle(context).copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ).marginOnly(left: margin_10),
            TextView(
              text: keySelectLanguage.tr,
              maxLine: 1,
              textStyle: textStyleTitle(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ).marginOnly(left: margin_10),
            SizedBox(
              height: margin_15,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.languageList.length,
              itemBuilder: (BuildContext context, int index) {
                LanguageModel model = controller.languageList[index];
                return InkWell(
                  onTap: () {
                    controller.changeLanguage(model.language);
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(margin_12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  model.language.name.toUpperCase(),
                                  style: textStyleTitle(context).copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: margin_10,
                                ),
                                Text(
                                  model.name,
                                  style: textStyleTitle(context).copyWith(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_circle_right_outlined,
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 0.5,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
