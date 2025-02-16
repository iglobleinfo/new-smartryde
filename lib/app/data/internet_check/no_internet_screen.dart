import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:smart_ryde/export.dart';

class NoInternetConnectionScreen extends StatefulWidget {
  final int? screenType;

  const NoInternetConnectionScreen({super.key, this.screenType});

  @override
  State createState() => _NoInternetConnectionScreenState();
}

class _NoInternetConnectionScreenState
    extends State<NoInternetConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No Internet",
              style: textStyleBodyMedium(context).copyWith(
                  fontSize: font_18,
                  fontFamily: "strFontBold",
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: height_10,
            ),
            Text(
              "Please check your Internet connection and",
              textAlign: TextAlign.center,
              style: textStyleBodyMedium(context).copyWith(
                  color: Colors.black45,
                  fontSize: font_15,
                  fontFamily: "strFontMedium",
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: height_15,
            ),
            SizedBox(
              width: Get.width / 2.5,
              child: MaterialButtonWidget(
                onPressed: () {
                  checkInternet();
                },
                buttonRadius: radius_10,
                textColor: Colors.white,
                buttonText: "Try Again",
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkInternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      toast("No Internet Connection");
    } else {
      if (widget.screenType == 0) {
        Get.offAllNamed(AppRoutes.splash);
      } else {
        Get.back();
      }
    }
  }
}
