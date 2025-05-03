import 'package:smart_ryde/app/core/widgets/annotated_region_widget.dart';
import 'package:smart_ryde/app/modules/authentication/model/login_data_model.dart';
import 'package:smart_ryde/app/modules/home_booking/view/home_booking_screen.dart';
import 'package:smart_ryde/export.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  Widget customDrawer(BuildContext context) => Container(
        color: Colors.white,
        width: Get.width - 100,
        height: height_1000,
        child: Column(
          children: [
            profileHeader(context),
            const Divider(),
            listTile(
                context: context,
                icon: iconClock,
                text: 'Booking',
                onTap: () {
                  if (PreferenceManger().getStatusUserLogin() ?? false) {
                    Get.toNamed(AppRoutes.myBooking);
                  }
                }),
            listTile(
                context: context,
                icon: iconFeedback,
                text: 'Drop A Feedback',
                onTap: () {
                  Get.toNamed(AppRoutes.feedback);
                }),
            listTile(
                context: context,
                icon: iconStar,
                text: 'Rate Us',
                onTap: () async {
                  final InAppReview inAppReview = InAppReview.instance;
                  if (await inAppReview.isAvailable()) {
                    inAppReview.requestReview();
                  }
                }),
            listTile(
                context: context,
                icon: iconInfo,
                text: stringAboutUs.tr,
                onTap: () {
                  Get.toNamed(AppRoutes.about);
                }),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        controller.onWillPop();
      },
      child: AnnotatedRegionWidget(
        statusBarColor: primaryColor,
        statusBarBrightness: Brightness.dark,
        child: SafeArea(
          child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              return Scaffold(
                key: controller.scaffoldKey,
                resizeToAvoidBottomInset: false,
                appBar: CustomAppBar(
                  appBarTitleText: 'SmartRyde',
                  leadingIcon: getInkWell(
                    onTap: () {
                      controller.scaffoldKey.currentState!.openDrawer();
                    },
                    child: Icon(
                      Icons.dehaze_outlined,
                      size: 26,
                    ).paddingAll(12),
                  ),
                ),
                drawer: customDrawer(context),
                body: Stack(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        AssetImageWidget(
                          imageUrl: imageBusMainLogin,
                        ),
                        HomeBookingScreen()
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  listTile({context, text, icon, onTap}) => InkWell(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AssetImageWidget(
                      imageUrl: icon,
                      imageHeight: 25,
                      imageWidth: 25,
                      imageFitType: BoxFit.contain)
                  .marginOnly(right: margin_10),
              Text(
                text,
                style: textStyleDisplayMedium(context)
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
              )
            ],
          ),
        ),
        onTap: () {
          onTap();
        },
      );

  Widget profileHeader(context) {
    return Container(
      height: 150,
      color: primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: controller.tempFile != null
                      ? ClipOval(
                          child: Image.file(
                            controller.tempFile!,
                            fit: BoxFit.fill,
                            height: 40,
                            width: 40,
                          ),
                        )
                      : AssetImageWidget(
                          imageUrl: imageUser,
                          imageHeight: 40,
                          imageWidth: 40,
                          radiusAll: 90,
                        ),
                ),
              ),
              PreferenceManger().getStatusUserLogin() ?? false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.userData?.name ?? '',
                          style: textStyleDisplayMedium(context).copyWith(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          controller.userData?.phone ?? '',
                          style: textStyleDisplayMedium(context).copyWith(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Please Login/Signup',
                      style: textStyleDisplayMedium(context).copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 17,
                color: Colors.white,
              )
            ],
          ),
        ),
        onTap: () {
          if (PreferenceManger().getStatusUserLogin() ?? false) {
            Get.toNamed(AppRoutes.profile);
          } else {
            Get.toNamed(AppRoutes.onboarding);
          }
        },
      ),
    );
  }
}
