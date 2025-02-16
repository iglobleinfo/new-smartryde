import 'package:image_picker/image_picker.dart';

import '../../../../../export.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/image_picker_dialog.dart';
import '../../authentication/model/login_data_model.dart';

class MyProfileController extends GetxController {
  late Dio dio;
  CustomLoader customLoader = CustomLoader();

  late TextEditingController emailController = TextEditingController();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController numberController = TextEditingController();
  late TextEditingController countryPickerController = TextEditingController();
  late TextEditingController forgetEmailController;
  late TextEditingController passwordController;
  late FocusNode emailFocusNode;
  late FocusNode nameFocusNode = FocusNode();
  late FocusNode numberFocusNode = FocusNode();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  LoginDataModel? userData;
  File? tempFile;

  @override
  void onInit() {
    String? tempFile = PreferenceManger().getProfilePic();
    if(tempFile != null){
      debugPrint('::::::::$tempFile');
      this.tempFile = File(tempFile);
    }
    dio = Dio();
    getData();
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

  Future<void> addProfilePicture(BuildContext context) async {
    await Get.bottomSheet(
      ImagePickerDialog(
        imageSelected: (XFile? file) async {
          Navigator.pop(context);
          if (file != null) {
            tempFile = File(file.path);
            debugPrint("TempFile: ${tempFile?.path}");
            PreferenceManger().saveProfilePic(tempFile!.path);
            update();
            // unawaited(uploadProfilePicture());
          }
        },
      ),
    );
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
  hitUpdateProfileAPI(context) {
    if (nameController.text.isEmpty) {
      toast(stringPasswordEmptyValidation.tr);
      return;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      toast('Enter a valid email');
      return;
    }
    customLoader.show(context);
    FocusManager.instance.primaryFocus!.unfocus();
    var loginReq = AuthRequestModel.profileReq(
      phoneNumber: numberController.text,
      userId: userData!.id.toString(),
      email: emailController.text.trim(),
      name: nameController.text.trim(),
    );
    APIRepository.updateProfileApiCall(dataBody: loginReq)
        .then((LoginResponseModel? value) async {
      LoginResponseModel? loginModel = value;
      customLoader.hide();
      PreferenceManger().saveUserData(loginModel!.data!);
      try {
        Get.find<HomeController>().getData();
      } catch (e) {
        Get.put(HomeController()).getData();
      }
      Get.back();
      toast('Profile updated successfully');
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
