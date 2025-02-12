import 'package:smart_ryde/app/modules/splash/controllers/splash_controller.dart';
import 'package:smart_ryde/export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SplashController(),
        builder: (context) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                AssetImageWidget(
                  imageHeight: Get.height,
                  imageWidth: Get.width,
                  imageUrl: imageSplashBackground,
                  imageFitType: BoxFit.cover,
                ),
                AssetImageWidget(
                  imageUrl: imageSplashLogo,
                  imageFitType: BoxFit.cover,
                ),
              ],
            ),
          );
        });
  }
}
