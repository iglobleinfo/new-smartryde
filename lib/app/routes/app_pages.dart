/*
 * @copyright : Ozvid Technologies Pvt. Ltd. < www.ozvid.com >
 * @author     : Shiv Charan Panjeta < shiv@ozvid.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of Ozvid Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */



import 'package:smart_ryde/app/modules/authentication/views/forget_screen.dart';
import 'package:smart_ryde/app/modules/authentication/views/login_screen.dart';
import 'package:smart_ryde/app/modules/authentication/views/profile_screen.dart';
import 'package:smart_ryde/app/modules/authentication/views/register_screen.dart';
import 'package:smart_ryde/app/modules/home/views/home_screen.dart';
import 'package:smart_ryde/app/modules/home/views/item_view.dart';
import 'package:smart_ryde/app/modules/home/views/main_screen.dart';
import 'package:smart_ryde/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:smart_ryde/app/modules/splash/views/splash_screen.dart';
import 'package:smart_ryde/app/routes/app_routes.dart';

import '../../export.dart';
import '../modules/language/bindings/select_language_binding.dart';
import '../modules/language/views/select_language_screen.dart';
import '../modules/new_signin.dart';


class AppPages {
  static const INITIAL = AppRoutes.splash;

  static final routes = [
    GetPage(
        name: AppRoutes.splash,
        page: () => SplashScreen(),
        bindings: [SplashBinding()
        ],
    ),
    GetPage(
      name: AppRoutes.selectLanguage,
      page: () => SelectLanguageScreen(),
      binding: SelectLanguageBinding()
    ),
    GetPage(
        name: AppRoutes.onBoarding,
        page: () => OnboardingScreen(),
        binding: OnBoardingBinding()
    ),
    GetPage(
      name: AppRoutes.logIn,
      page: () => LoginScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => RegisterScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgetScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.mainScreen,
      page: () => MainScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.itemView,
      page: () => ItemView(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      bindings: [AuthenticationBinding()],
    ),  GetPage(
      name: AppRoutes.newSignIn,
      page: () => NewSignIn(),
      bindings: [AuthenticationBinding()],
    ),
  ];


}
