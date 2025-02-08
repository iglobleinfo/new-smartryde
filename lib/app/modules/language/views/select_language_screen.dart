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
import '../../../core/utils/helper_widget.dart';
import '../../../core/widgets/annotated_region_widget.dart';
import '../../../core/widgets/authentication_screen_heading.dart';
import '../../../core/widgets/screen_heading.dart';
import '../controllers/select_language_controller.dart';

class SelectLanguageScreen extends StatelessWidget {
  final controller = Get.put(SelectLanguageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectLanguageController>(
        init: SelectLanguageController(),
        builder: (controller) {
          return AnnotatedRegionWidget(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            child: SafeArea(
              top: true,
              child: Scaffold(
                extendBodyBehindAppBar: true,
                backgroundColor: Colors.white,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              onWillPop(context);
                            },
                            child: SizedBox())
                        .marginOnly(top: margin_20)
                        .marginSymmetric(horizontal: margin_15)
                        .paddingOnly(bottom: margin_10),
                    Expanded(child: Center(child: _bodyWidget())),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _bodyWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          controller.isDrawerType.value == false
              ? Center(
                  child: AuthenticationScreenHeading(
                    title: keySelectLanguage.tr,
                    alignmentGeometry: Alignment.center,
                    textAlign: TextAlign.center,
                  ).paddingOnly(
                      bottom: margin_10, left: margin_15, right: margin_15),
                )
              : Center(
                  child: ScreenHeading(
                    title: keyChangeLanguage.tr,
                  ).paddingOnly(
                      bottom: margin_10, left: margin_15, right: margin_15),
                ),
          chooseLanguage(),
          _selectLangSection(),
        ],
      ).marginOnly(top: margin_20);

  _selectLangSection() => SizedBox(
        width: Get.width,
        child: ListView.separated(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) => InkWell(
            onTap: () {
              controller.selectedLangIndex =
                  controller.languageList[index].id ?? 0;
              Timer(Duration(milliseconds: 200), () {
                controller.navigateToNextScreen();
              });
              controller.update();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: margin_20, horizontal: margin_15),
              margin: EdgeInsets.symmetric(
                  vertical: margin_8, horizontal: margin_70),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade100,
                        blurRadius: 2,
                        spreadRadius: 2)
                  ],
                  color: controller.selectedLangIndex ==
                          controller.languageList[index].id
                      ? colorAppColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(radius_50)),
              child: Align(
                  alignment: Alignment.center,
                  child: TextView(
                      text: controller.languageList[index].title.toString(),
                      textStyle: textStyleBodyMedium(context).copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: font_17,
                          color: controller.selectedLangIndex ==
                                  controller.languageList[index].id
                              ? Colors.white
                              : Colors.black))),
            ),
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: height_10,
          ),
          itemCount: controller.languageList.length,
        ),
      );

  chooseLanguage() => TextView(
          text: keyPreferredLang.tr,
          textStyle: textStyleBodyLarge(Get.context!)
              .copyWith(fontWeight: FontWeight.w500, fontSize: font_15))
      .paddingOnly(left: margin_15, bottom: margin_80);
}
