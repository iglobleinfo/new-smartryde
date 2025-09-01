import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:smart_ryde/app/data/internet_check/no_internet_screen.dart';
import 'package:smart_ryde/export.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    checkInternetAvailable(Get.context!);
    super.onInit();
  }

  void checkInternetAvailable(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    debugPrint('connectivityResult ${connectivityResult.first}');
    if (connectivityResult.first == ConnectivityResult.none) {
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
          if (storage.read(LOCALKEY_token) != null) {
            Get.offAll(
              AppRoutes.dashboard,
            );
          } else {
            Get.offAllNamed(
              AppRoutes.home,
            );
          }
        }
      });

  bool appExpirationDateCheck() {
    return DateTime.now().isAfter(
      DateTime(
        2025,
        08,
        29,
      ).add(
        const Duration(days: 30),
      ),
    );
  }
}
