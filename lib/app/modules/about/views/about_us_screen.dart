import 'package:smart_ryde/app/core/widgets/custom_back_button.dart';

import '../../../../export.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutUsController>(
      init: AboutUsController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(),
                  getAboutUs(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('SmartRyde V${controller.versionNumber}'),
                    ],
                  ),
                  SizedBox(
                    height: margin_10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getAboutUs(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: margin_20,
            ),
            Text(
              stringAboutUs.tr,
              style: textStyleDisplayMedium(context),
            ),
            SizedBox(
              height: margin_10,
            ),
            Text(
              stringAboutUsDescription.tr,
              style: textStyleBodyMedium(context).copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  tileList({
    required BuildContext context,
    required AboutUsController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _listTileIconView(
          context: context,
          label: "Version",
          description: controller.versionNumber,
        ),
        _listTileIconView(
            context: context,
            label: "Rate App",
            onSeeAllTap: () async {
              final InAppReview inAppReview = InAppReview.instance;
              if (await inAppReview.isAvailable()) {
                inAppReview.requestReview();
              }
            },
            description: "If you like us, Rate us"),
        _listTileIconView(
            context: context,
            label: "Share App",
            // leadingIcon: iconsDelete,
            onSeeAllTap: () async {
              final String appLink =
                  'https://play.google.com/store/apps/details?id=${controller.packageName}';
              final String message = 'Check out this app: $appLink';
              // await FlutterShare.share(
              //     title: 'Share App', linkUrl: appLink, text: message);
            },
            description: "If you like us, let other's know"),
        _listTileIconView(
            context: context,
            label: "More Apps",
            onSeeAllTap: () async {
              await launchUrl(Uri.parse(
                  "https://play.google.com/store/apps/details?id=${controller.packageName}"));
            },
            description: "Check other apps we have"),
        _listTileIconView(
          context: context,
          label: "Copyrights",
          description: "ToXSL Technologies Private Limited",
        ),
        _listTileIconView(
          context: context,
          label: "Server URL",
          // description: "${imageBaseUrl}",
        ),
      ],
    );
  }

  Widget _listTileIconView({
    required BuildContext context,
    label,
    leadingIcon,
    onSeeAllTap,
    icon,
    description,
  }) =>
      InkWell(
        onTap: onSeeAllTap ?? () {},
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    (leadingIcon != null)
                        ? AssetImageWidget(
                            imageUrl: leadingIcon,
                            imageFitType: BoxFit.cover,
                            imageHeight: height_25,
                          ).marginOnly(right: margin_12)
                        : const SizedBox(),
                    (icon != null)
                        ? Icon(
                            icon,
                            color: Colors.yellow,
                            size: height_25,
                          ).marginOnly(right: margin_12)
                        : emptySizeBox(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: label ?? "",
                          textStyle: textStyleDisplayMedium(context).copyWith(
                            color: Colors.black,
                            fontSize: font_15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextView(
                          text: description ?? "",
                          textStyle: textStyleDisplayMedium(context).copyWith(
                            color: Colors.black,
                            fontSize: font_15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(vertical: margin_16, horizontal: margin_15),
            const Divider(
              color: Colors.grey,
            ),
          ],
        ),
      );
}
