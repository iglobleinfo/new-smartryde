import 'package:smart_ryde/app/core/utils/helper_widget.dart';
import 'package:smart_ryde/app/modules/about/views/about_us_screen.dart';
import 'package:smart_ryde/app/modules/authentication/controllers/login_controller.dart';
import 'package:smart_ryde/app/modules/authentication/views/profile_screen.dart';
import 'package:smart_ryde/app/modules/home/controllers/home_controller.dart';
import 'package:smart_ryde/app/modules/home/views/home_screen.dart';
import 'package:smart_ryde/app/modules/staticPages/controllers/static_page_controller.dart';
import 'package:smart_ryde/app/modules/staticPages/views/static_page_screen.dart';
import '../../../../../export.dart';
import '../../../core/widgets/annotated_region_widget.dart';

class MainScreen extends GetView<HomeController> {
  final StaticPageController staticPageController =
      Get.put(StaticPageController());
  final LoginController loginController = Get.put(LoginController());
  final HomeController homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();
  final MyAccountModel? myAccountModel = MyAccountModel();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        homeController.onWillPop();
      },
      child: AnnotatedRegionWidget(
        statusBarColor: primaryColor,
        statusBarBrightness: Brightness.dark,
        child: SafeArea(
          child: GetBuilder<HomeController>(
            builder: (controller) {
              return Scaffold(
                key: scaffoldKey,
                resizeToAvoidBottomInset: false,
                appBar: CustomAppBar(
                  appBarTitleText: 'SmartRyde',
                  leadingIcon: getInkWell(
                    onTap: () {
                      scaffoldKey!.currentState!.openDrawer();
                    },
                    child: AssetImageWidget(
                      imageUrl: iconMenu,
                    ).paddingAll(height_10),
                  ),
                ),
                drawer: customDrawer(context),
                body: controller.bottomNavIndex == 2
                    ? ProfileScreen()
                    : HomeScreen(),
                bottomNavigationBar:
                    controller.currentViewType == ViewType.bottomNav
                        ? BottomNavigationBar(
                            onTap: (value) {
                              controller.updateBottomNavIndex(value);
                            },
                            currentIndex: controller.bottomNavIndex,
                            items: const [
                                BottomNavigationBarItem(
                                    label: '', icon: Icon(Icons.home)),
                                BottomNavigationBarItem(
                                    label: '', icon: Icon(Icons.feed)),
                                BottomNavigationBarItem(
                                    label: '', icon: Icon(Icons.person)),
                              ])
                        : null,
              );
            },
          ),
        ),
      ),
    );
  }

  customDrawer(BuildContext context) => Container(
        color: Colors.white,
        width: Get.width - 100,
        height: height_1000,
        child: Column(
          children: [
            profileHeader(context, loginController, homeController),
            const Divider(),
            listTile(
                icon: iconAccount_info,
                text: 'Account Information',
                onTap: () {
                  // loginController.hitMyAccountAPI();
                  // Get.toNamed(AppRoutes.newSignIn);
                  scaffoldKey!.currentState!.openEndDrawer();
                  Get.toNamed(AppRoutes.profile);
                }),
            listTile(
                icon: iconAccount_info,
                text: 'Switch View Type',
                onTap: () {
                  // loginController.hitMyAccountAPI();
                  if (controller.currentViewType == ViewType.bottomNav) {
                    controller.updateViewType(ViewType.drawer);
                  } else {
                    controller.updateViewType(ViewType.bottomNav);
                  }
                  scaffoldKey!.currentState!.openEndDrawer();
                  // Get.toNamed(AppRoutes.profile);
                }),
            listTile(
                icon: iconLanguage,
                text: Get.locale?.countryCode?.camelCase == 'sa'
                    ? 'English'
                    : 'Arabic',
                onTap: () {
                  scaffoldKey!.currentState!.openEndDrawer();
                  if (Get.locale?.countryCode?.camelCase == 'sa') {
                    Get.updateLocale(const Locale('en', 'US'));
                    storage.write(LOCALKEY_currentLang, 'en');
                  } else {
                    Get.updateLocale(const Locale('ar', 'SA'));
                    storage.write(LOCALKEY_currentLang, 'ar');
                  }
                  log.e(storage.read(LOCALKEY_currentLang));
                }),
            listTile(
                icon: iconFaq,
                text: stringFAQs,
                onTap: () {
                  homeController.isfaq.value = true;
                  staticPageController.hitFaqAPI();
                  scaffoldKey!.currentState!.openEndDrawer();
                  Get.to(() => const StaticPageScreen(type: stringFAQs));
                }),
            listTile(
                icon: iconAbout,
                text: stringAboutUs,
                onTap: () {
                  homeController.isfaq.value = false;
                  scaffoldKey!.currentState!.openEndDrawer();
                  Get.to(() => AboutUsScreen());
                  // Get.to(() => StaticPageScreen(type: 'About Us'));
                }),
            listTile(
                icon: iconLogout,
                text: stringDeleteAccount,
                onTap: () {
                  deleteAccountDialog(context);
                }),
            listTile(
                icon: iconLogout,
                text: stringLogout,
                onTap: () {
                  logoutDialog(context);
                }),
          ],
        ),
      );
}

Future<void> readBook({path, id, bookController}) async {
  var data;
  data = {
    "bookId": "",
    "href": "",
    "created": 0,
    "locations": {"cfi": ""}
  };
  var datax = storage.read('$id');
  if (datax != null) {
    data = json.decode(datax);
  }
  Map locations = data != null ? data['locations'] : Map();
  try {
    if (await File(path).exists()) {
      await bookController.openBook(
        path,
        // controller
        //     .fullPath.value,
        // 'assets/book/book.epub',
        '$id',
        cfi: locations['cfi'],
        created: data['created'],
        href: data['href'],
      );
    }
  } catch (e) {
    toast(e);
  }
}

listTile({text, icon, onTap}) => InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            AssetImageWidget(
                    imageUrl: icon,
                    imageHeight: 20,
                    imageWidth: 20,
                    imageFitType: BoxFit.contain)
                .marginOnly(right: margin_10),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            )
          ],
        ),
      ),
      onTap: () {
        onTap();
      },
    );

Widget profileHeader(context, loginController, homeController) => Container(
      height: height_100,
      color: primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AssetImageWidget(
                imageUrl: iconAccount_info,
                imageHeight: 25,
                imageWidth: 25,
                imageFitType: BoxFit.fill,
              ).marginOnly(right: margin_10),
              Text(
                'Please Login/Signup',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
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
