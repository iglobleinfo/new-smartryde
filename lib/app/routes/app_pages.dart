import 'package:smart_ryde/app/modules/about/views/about_us_screen.dart';
import 'package:smart_ryde/app/modules/authentication/verify_otp_module/verify_otp_bindings.dart';
import 'package:smart_ryde/app/modules/authentication/views/onboarding_screen.dart';
import 'package:smart_ryde/app/modules/authentication/views/profile_screen.dart';
import 'package:smart_ryde/app/modules/authentication/views/register_screen.dart';
import 'package:smart_ryde/app/modules/bus/binding/bindings.dart';
import 'package:smart_ryde/app/modules/bus/view/bus_list_view.dart';
import 'package:smart_ryde/app/modules/forgot_password/forgot_password_screen.dart';
import 'package:smart_ryde/app/modules/home/views/home_screen.dart';
import 'package:smart_ryde/app/modules/live_tracking/live_tracking_screen.dart';
import 'package:smart_ryde/app/modules/splash/views/splash_screen.dart';
import 'package:smart_ryde/app/modules/stop_locations/stop_location_page.dart';
import '../../export.dart';
import '../modules/authentication/verify_otp_module/verify_otp_page.dart';
import '../modules/authentication/views/feedback_screen.dart';
import '../modules/authentication/views/my_booking.dart';
import '../modules/authentication/views/my_profile.dart';
import '../modules/bus/view/bus_booking_screen.dart';
import '../modules/home/views/home_screen2.dart';
import '../modules/language/bindings/select_language_binding.dart';
import '../modules/language/views/select_language_screen.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.about,
      page: () => AboutUsScreen(),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.selectLanguage,
      page: () => SelectLanguageScreen(),
      binding: SelectLanguageBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingScreen(),
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
      name: AppRoutes.verifyOtp,
      page: () => VerifyOtpPage(),
      bindings: [
        VerifyOtpBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.home2,
      page: () => HomeScreen2(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => ProfileScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => MyProfileScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.busList,
      page: () => BusListScreen(),
      bindings: [BusBinding()],
    ),
    GetPage(
      name: AppRoutes.busBooking,
      page: () => BusBookingScreen(),
      bindings: [BusBinding()],
    ),
    GetPage(
      name: AppRoutes.liveTracking,
      page: () => LiveTrackingScreen(),
    ),
    GetPage(
      name: AppRoutes.busLocation,
      page: () => StopLocationPage(),
    ),
    GetPage(
      name: AppRoutes.feedback,
      page: () => FeedbackScreen(),
    ),
    GetPage(
      name: AppRoutes.myBooking,
      page: () => MyBookingListScreen(),
    ),
  ];
}
