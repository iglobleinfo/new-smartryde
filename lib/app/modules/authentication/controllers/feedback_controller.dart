import 'package:smart_ryde/app/modules/authentication/controllers/my_profile_controller.dart';
import '../../../../../export.dart';
import '../../authentication/model/login_data_model.dart';
import '../../home_booking/models/district_model.dart';

class FeedbackController extends GetxController {
  late Dio dio;
  CustomLoader customLoader = CustomLoader();

  late TextEditingController emailController = TextEditingController();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController incidentController = TextEditingController();
  late TextEditingController dateTimeController = TextEditingController();
  late TextEditingController numberController = TextEditingController();
  late TextEditingController countryPickerController = TextEditingController();
  late TextEditingController feedbackController = TextEditingController();
  late TextEditingController forgetEmailController;
  late TextEditingController passwordController;
  int? pickUp1DistrictId;
  late TextEditingController routeController = TextEditingController();
  late FocusNode emailFocusNode;
  late FocusNode nameFocusNode = FocusNode();
  late FocusNode numberFocusNode = FocusNode();
  DistrictResponseModel? districtResponseModel;
  List<DistrictList> districtList = [];

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  LoginDataModel? userData;

  @override
  void onInit() {
    dio = Dio();
    getData();
    hitGetDistrict();
    super.onInit();
  }

  getData() async {
    userData = await PreferenceManger().getUserData();
    numberController.text = userData?.phone ?? '';
    emailController.text = userData?.email ?? '';
    nameController.text = userData?.name ?? '';
    update();
    hitUserAPI();
  }

  Future<void> hitGetDistrict() async {
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.getDistrictApi().then((DistrictResponseModel? value) async {
      districtResponseModel = value;
      districtList.addAll(districtResponseModel?.data ?? []);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  /*===================================================================== Generate OTP API Call  ==========================================================*/
  hitUserAPI() {
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.getUserApi(userData!.id.toString()).then((value) async {
      update();
      customLoader.hide();
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  /*===================================================================== Update Profile API Call  ==========================================================*/
  hitAddFeedbackAPI(context) {
    if (nameController.text.isEmpty) {
      toast(stringPasswordEmptyValidation.tr);
      return;
    }
    if (dateTimeController.text.isEmpty) {
      toast(keySelectDate.tr);
      return;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      toast(keyEnterValidEmail.tr);
      return;
    }
    customLoader.show(context);
    FocusManager.instance.primaryFocus!.unfocus();
    var loginReq = AuthRequestModel.feedbackReq(
      phoneNumber: numberController.text,
      userId: userData!.id.toString(),
      email: emailController.text.trim(),
      name: nameController.text.trim(),
      feedbackType: feedbackController.text,
      incidentDetails: incidentController.text,
      route: pickUp1DistrictId.toString(),
      incidentDate: dateTimeController.text,
    );
    APIRepository.addFeedbackApiCall(dataBody: loginReq)
        .then((MessageResponseModel? value) async {
      Get.until((route) => route.isFirst);
      customLoader.hide();
      toast(keyFeedSubmit.tr);
      update();
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
