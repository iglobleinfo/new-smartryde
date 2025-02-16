import '../../../../../export.dart';
import '../../authentication/model/login_data_model.dart';

class HomeController extends GetxController {
  late Dio dio;
  CustomLoader customLoader = CustomLoader();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  LoginDataModel? userData;
  File? tempFile;

  @override
  void onInit() {
    dio = Dio();
    getData();
    super.onInit();
  }

  getData() async {
    String? tempFile = PreferenceManger().getProfilePic();
    if (tempFile != null) {
      debugPrint('::::::::$tempFile');
      this.tempFile = File(tempFile);
    }
    userData = await PreferenceManger().getUserData();
    update();
    hitUserAPI();
  }

  /*===================================================================== Generate OTP API Call  ==========================================================*/
  hitUserAPI() {
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.getUserApi(userData!.id.toString()).then((value) async {
      customLoader.hide();
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  Future<bool> onWillPop() {
    debugPrint(backPressCounter.toString());
    if (backPressCounter < 1) {
      Get.snackbar(
        stringAppName,
        stringExitWarning,
        borderRadius: 6.0,
        backgroundColor: colorMistyRose,
        margin: EdgeInsets.zero,
        colorText: colorVioletM,
      );
      backPressCounter++;
      Future.delayed(Duration(milliseconds: 1500), () {
        backPressCounter--;
      });
      return Future.value(false);
    } else {
      if (GetPlatform.isAndroid) {
        SystemNavigator.pop();
      }
      return Future.value(true);
    }
  }
}
