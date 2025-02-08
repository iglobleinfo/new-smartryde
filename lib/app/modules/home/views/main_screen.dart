import 'package:smart_ryde/app/core/utils/helper_widget.dart';
import 'package:smart_ryde/app/modules/about/views/about_us_screen.dart';
import 'package:smart_ryde/app/modules/authentication/controllers/login_controller.dart';
import 'package:smart_ryde/app/modules/authentication/views/profile_screen.dart';
import 'package:smart_ryde/app/modules/home/controllers/home_controller.dart';
import 'package:smart_ryde/app/modules/home/views/home_screen.dart';
import 'package:smart_ryde/app/modules/staticPages/controllers/static_page_controller.dart';
import 'package:smart_ryde/app/modules/staticPages/views/static_page_screen.dart';
import '../../../../../export.dart';

class MainScreen extends GetView<HomeController> {
  final StaticPageController staticPageController =
      Get.put(StaticPageController());
  final LoginController loginController = Get.put(LoginController());
  final HomeController homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();
  final MyAccountModel? myAccountModel = MyAccountModel();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      homeController.onWillPop();
      return Future.value(true);
    }, child: SafeArea(child: GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          appBarTitleText: 'My Base',
          leadingIcon: getInkWell(
              onTap: () {
                scaffoldKey!.currentState!.openDrawer();
              },
              child: AssetImageWidget(
                imageUrl: iconMenu,
              ).paddingAll(height_10)),
        ),
        drawer: customDrawer(context),
        body: controller.bottomNavIndex == 2 ? ProfileScreen() : HomeScreen(),
        bottomNavigationBar: controller.currentViewType == ViewType.bottomNav
            ? BottomNavigationBar(
                onTap: (value) {
                  controller.updateBottomNavIndex(value);
                },
                currentIndex: controller.bottomNavIndex,
                items: const [
                    BottomNavigationBarItem(label: '', icon: Icon(Icons.home)),
                    BottomNavigationBarItem(label: '', icon: Icon(Icons.feed)),
                    BottomNavigationBarItem(
                        label: '', icon: Icon(Icons.person)),
                  ])
            : null,
      );
    })));
  }

  Widget _body() {
    return Padding(
        padding:
            EdgeInsets.only(left: margin_22, right: margin_22, top: margin_16),
        child: Column(
          children: [
            Card(
              shadowColor: Colors.grey.withValues(alpha: 0.4),
              elevation: 3,
              child: TextFieldWidget(
                  hint: 'search',
                  onChange: (val) {
                    controller.search(val);
                  },
                  inputAction: TextInputAction.search,
                  prefixIcon: Container(
                    padding: EdgeInsets.only(left: margin_15, right: margin_15),
                    child: AssetImageWidget(
                        imageUrl: iconSearch, imageHeight: 8, imageWidth: 8),
                  ),
                  focusNode: controller.searchFocusNode,
                  textController: controller.searchController),
            ).marginOnly(bottom: margin_25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MaterialButtonWidget(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.onMyBookTap();
                        controller.hitMyBookAPI();
                        controller.searchController.clear();
                      },
                      buttonText: 'My Books',
                      textColor: controller.isMyBook.value
                          ? Colors.white
                          : colorLightGray,
                      buttonColor: controller.isMyBook.value
                          ? colorVioletM
                          : Colors.transparent),
                ).marginOnly(right: margin_15),
                Expanded(
                  child: MaterialButtonWidget(
                      onPressed: () {
                        controller.hitMyBookAPI();
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.onLentBookTap();
                        controller.searchController.clear();
                      },
                      buttonText: 'Books I lent',
                      textColor: !controller.isMyBook.value
                          ? Colors.white
                          : colorLightGray,
                      buttonColor: !controller.isMyBook.value
                          ? colorVioletM
                          : Colors.transparent),
                ),
              ],
            ).marginOnly(bottom: margin_15),
            controller.homeLoader.value
                ? const Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                    backgroundColor: colorRussianViolet,
                    color: colorMistyRose,
                  )))
                : Expanded(
                    child: ListView.separated(
                        itemCount: 5,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: height_10),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.width,
                                  height: height_200,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(radius_15),
                                      color: Colors.black),
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(radius_15),
                                      child: Image.asset(
                                        iconImg1,
                                        fit: BoxFit.cover,
                                      )),
                                ).marginOnly(bottom: height_10),
                                TextView(
                                  text: stringTitle,
                                  maxLine: 2,
                                  textStyle: textStyleTitle(context),
                                ).marginOnly(bottom: height_10),
                                const ReadMoreTextWidget(
                                  stringDummyText,
                                  moreStyle: TextStyle(
                                      color: colorVioletM,
                                      fontWeight: FontWeight.bold),
                                  lessStyle: TextStyle(
                                      color: colorVioletM,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
          ],
        ));
  }

  customDrawer(BuildContext context) => Drawer(
        child: Column(
          children: [
            profileHeader(context, loginController, homeController)
                .marginOnly(top: margin_30),
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
    if (await File(path).exists())
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: 'Username',
                textStyle: textStyleTitle(context),
              ),
              TextView(
                text: loginController.myAccountModel?.email ?? '',
                textStyle: textStyleTitle(context),
              )
            ],
          )
        ],
      ),
    );
