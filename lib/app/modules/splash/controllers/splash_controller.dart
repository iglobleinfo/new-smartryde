import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:smart_ryde/app/data/internet_check/no_internet_screen.dart';
import 'package:smart_ryde/app/modules/home/views/home_screen.dart';
import 'package:smart_ryde/export.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    // update();
    checkInternetAvailable(Get.context!);
    super.onInit();
  }

  void checkInternetAvailable(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.offAll(
        const NoInternetConnectionScreen(
          screenType: 0,
        ),
      );
    } else if (context.mounted) {
      _navigateToNextScreen(context);
    }
  }

  _navigateToNextScreen(BuildContext context) =>
      Timer(const Duration(milliseconds: 3500), () async {
        if (appExpirationDateCheck()) {
          appExpirationDialog(context);
        } else {
          if (storage.read(LOCALKEY_onboarding) ?? false) {
            if (storage.read(LOCALKEY_token) != null) {
              Get.offAll(
                () => HomeScreen(),
              );
            } else {
              Get.offAllNamed(
                AppRoutes.mainScreen,
              );
            }
          } else if (storage.read(LOCALKEY_language) ?? false) {
            Get.offAllNamed(
              AppRoutes.onBoarding,
            );
          } else {
            Get.offAllNamed(
              AppRoutes.onBoarding,
            );
          }
        }
      });

  bool appExpirationDateCheck() {
    return DateTime.now().isAfter(
      DateTime(
        2025,
        02,
        10,
      ).add(
        const Duration(days: 15),
      ),
    );
  }
}
