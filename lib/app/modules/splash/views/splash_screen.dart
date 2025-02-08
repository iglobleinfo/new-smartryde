


import 'package:smart_ryde/app/modules/splash/controllers/splash_controller.dart';

import '../../../../../export.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        body: GetBuilder<SplashController>(
      builder: (controller) {
        return  Center(
          child: FlutterLogo(
            size: height_100,
          ),
        );
      },
    ));
  }
}
