import '../../../../../export.dart';
import '../../authentication/model/login_data_model.dart';

class HomeController2 extends GetxController {
  late Dio dio;
  CustomLoader customLoader = CustomLoader();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  LoginDataModel? userData;
  File? tempFile;
  String? matchId;
  String? pickUpName;

  @override
  void onInit() {
    dio = Dio();
    getData();
    matchId = Get.arguments['matchId']??'';
    pickUpName = Get.arguments['pickupStop']??'';
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
}
