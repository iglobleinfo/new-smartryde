import 'package:smart_ryde/app/core/widgets/annotated_region_widget.dart';
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
                onTap: () {}),
            listTile(
                context: context,
                icon: iconFeedback,
                text: 'Drop A Feedback',
                onTap: () {}),
            listTile(
                context: context,
                icon: iconStar,
                text: 'Rate Us',
                onTap: () {}),
            listTile(
                context: context,
                icon: iconInfo,
                text: stringAboutUs,
                onTap: () {}),
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
                    child: Icon(Icons.more_vert_rounded).paddingAll(height_10),
                  ),
                ),
                drawer: customDrawer(context),
                body: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AssetImageWidget(
                          imageUrl: imageBusMainLogin,
                        ),
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
                style: textStyleDisplayMedium(context).copyWith(
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          ),
        ),
        onTap: () {
          onTap();
        },
      );

  Widget profileHeader(context) => Container(
        height: height_120,
        color: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cachedImage(
                  url: '',
                  placeholder: Image.asset(imageUser),
                  height: 40,
                  width: 40,
                ),
                Text(
                  'Please Login/Signup',
                  style: textStyleDisplayMedium(context).copyWith(
                      fontWeight: FontWeight.normal, color: Colors.white),
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
            Get.toNamed(AppRoutes.logIn);
          },
        ),
      );
}
