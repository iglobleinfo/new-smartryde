import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:smart_ryde/export.dart';
import 'no_internet_screen.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.first == ConnectivityResult.none) {
      Get.to(const NoInternetConnectionScreen(
        screenType: 0,
      ));
      update();
    } else {
      update();
    }
  }

  offlineSheet() {
    return Get.dialog(
        barrierDismissible: false,
        WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Container(
            width: Get.width * 0.70,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          ),
        ));
  }

  offlineDialog(BuildContext context) {
    return Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: Get.width * 0.70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(margin_20)),
                child: Column(
                  children: [
                    AssetImageWidget(
                      imageUrl: iconSmallLogo,
                      imageHeight: height_100,
                    ),
                    TextView(
                            text: 'No internet connection',
                            textStyle: textStyleDisplaySmall(context).copyWith(
                                fontSize: font_17, fontWeight: FontWeight.bold))
                        .paddingSymmetric(vertical: margin_8),
                    TextView(
                            text: "Check Your Internet Connection",
                            textStyle: textStyleDisplaySmall(context).copyWith(
                                fontSize: font_15, fontWeight: FontWeight.bold))
                        .paddingSymmetric(vertical: margin_8),
                  ],
                ).paddingSymmetric(vertical: margin_15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
