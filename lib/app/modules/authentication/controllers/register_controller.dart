import 'package:smart_ryde/export.dart';

import '../../../core/utils/validators.dart';

class RegisterController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController nameController = TextEditingController();
  late TextEditingController numberController = TextEditingController();
  late TextEditingController countryPickerController = TextEditingController();
  late TextEditingController forgetEmailController;
  late TextEditingController passwordController;
  late FocusNode emailFocusNode;
  late FocusNode nameFocusNode = FocusNode();
  late FocusNode numberFocusNode = FocusNode();
  late FocusNode forgetEmailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode loginFocusNode;
  LoginResponseModel? loginModel;
  MyAccountModel? myAccountModel;
  late CustomLoader customLoader;
  RxBool loader = false.obs;
  RxBool viewPassword = RxBool(true);

  @override
  void onInit() {
    emailController = TextEditingController();
    forgetEmailController = TextEditingController();
    passwordController = TextEditingController();
    countryPickerController.text = '+825';
    emailFocusNode = FocusNode();
    forgetEmailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    loginFocusNode = FocusNode();
    customLoader = CustomLoader();

    super.onInit();
  }

  @override
  void onClose() {
    customLoader.hide();
    emailController.dispose();
    forgetEmailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    forgetEmailFocusNode.dispose();
    passwordFocusNode.dispose();
    loginFocusNode.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    if (storage.read(LOCALKEY_token) != null &&
        storage.read(LOCALKEY_myAccount) == null) {
      hitMyAccountAPI();
    } else {
      if (storage.read(LOCALKEY_myAccount) != null) {
        myAccountModel =
            MyAccountModel.fromJson(storage.read(LOCALKEY_myAccount));
      }
    }
    update();
  }

  /*===================================================================== Password Visibility  ==========================================================*/
  showOrHidePasswordVisibility() {
    viewPassword.value = !viewPassword.value;
    update();
  }

  /*===================================================================== Social signupo  ==========================================================*/
  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser =
  //       await GoogleSignIn().signIn().onError((error, stackTrace) {
  //     debugPrint(error.toString());
  //     toast(stringGoogleSignInCancelled);
  //     return null;
  //   });
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser!.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
  //
  // Future<UserCredential?> signInWithFacebook() async {
  //   String? token;
  //   await FacebookAuth.instance.login(
  //       permissions: ['email', 'public_profile'],
  //       loginBehavior: LoginBehavior.nativeWithFallback).then((value) {
  //     token = value.accessToken!.tokenString;
  //   }).onError((error, stackTrace) {});
  //
  //   if (token == null) return null;
  //   final facebookAuthCredential = FacebookAuthProvider.credential(token!);
  //
  //   var cred = await FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential)
  //       .onError((error, stackTrace) {
  //     return toast(error.toString());
  //   });
  //   return cred;
  // }
  //
  // Future signInWithApple() async {
  //   final AuthorizationResult result = await TheAppleSignIn.performRequests([
  //     const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
  //   ]);
  //
  //   switch (result.status) {
  //     case AuthorizationStatus.authorized:
  //       return result;
  //
  //     case AuthorizationStatus.error:
  //       debugPrint("Sign in failed: ${result.error!.localizedDescription}");
  //       break;
  //
  //     case AuthorizationStatus.cancelled:
  //       debugPrint('User cancelled');
  //       break;
  //   }
  // }
  //
  // Future logInGoogle() async {
  //   try {
  //     customLoader.show(Get.overlayContext);
  //     UserCredential userCredential = await signInWithGoogle();
  //     hitSocialLoginApi(userCredential.user, googleSignIn);
  //   } on FirebaseException catch (e) {
  //     customLoader.hide();
  //     toast(e.message);
  //   } catch (e) {
  //     customLoader.hide();
  //     toast(
  //       stringGoogleSignInCancelled,
  //     );
  //   }
  // }
  //
  // Future logInFaceBook() async {
  //   try {
  //     customLoader.show(Get.overlayContext);
  //     UserCredential? userCredential = await signInWithFacebook();
  //     if (userCredential != null) {
  //       hitSocialLoginApi(userCredential.user, fbSignIn);
  //     } else {
  //       customLoader.hide();
  //       toast(stringFbSignInCancelled);
  //     }
  //   } on FirebaseException catch (e) {
  //     customLoader.hide();
  //     debugPrint(e.message);
  //   } catch (e) {
  //     customLoader.hide();
  //     toast(stringFbSignInCancelled);
  //   }
  // }
  //
  // Future logInApple() async {
  //   try {
  //     AuthorizationResult? userCredential = await signInWithApple();
  //
  //     customLoader.show(Get.overlayContext);
  //     hitSocialLoginApi(
  //       userCredential!.credential!,
  //       appleSignIn,
  //     );
  //   } on FirebaseException catch (e) {
  //     customLoader.hide();
  //     print(e.message);
  //   } catch (e) {
  //     customLoader.hide();
  //     toast(stringAppleSignInCancelled);
  //   }
  // }

  //APIs

  /*===================================================================== SignUp API Call  ==========================================================*/
  hitSignUpAPI(context) {
    if (nameController.text.isEmpty) {
      toast('Please enter your name'.tr);
      return;
    }
    String? result = phoneTextFieldValidator(
        countryPickerController.text, numberController.text, context);
    if (result != null) {
      toast(result);
      return;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      toast('Enter a valid email');
      return;
    }
    if (passwordController.text.isEmpty) {
      toast(stringPasswordEmptyValidation.tr);
      return;
    }
    loader.value = true;
    customLoader.show(context);
    FocusManager.instance.primaryFocus!.unfocus();
    var loginReq = AuthRequestModel.registerReq(
      phoneNumber: countryPickerController.text +
          numberController.text.trim().toLowerCase(),
      password: passwordController.text,
      email: emailController.text,
      name: nameController.text.trim(),
    );
    APIRepository.signUpApiCall(dataBody: loginReq).then((value) async {
      loginModel = value;
      // storage.write(LOCALKEY_token, loginModel?.token);
      loader.value = false;
      toast(value?.message);
      hitGenerateOtpAPI(context);
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      toast(error);
    });
  }

  /*===================================================================== Generate OTP API Call  ==========================================================*/
  hitGenerateOtpAPI(context) {
    loader.value = true;
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.generateOtpApi(
            countryPickerController.text + numberController.text)
        .then((value) async {
      customLoader.hide();
      Get.toNamed(AppRoutes.verifyOtp, arguments: {
        "phoneNumber": countryPickerController.text + numberController.text,
      });
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      toast(error);
    });
  }

  /*===================================================================== My account details API Call  ==========================================================*/
  hitMyAccountAPI() {
    APIRepository.myAccountApiCall().then((value) {
      myAccountModel = value;
      storage.write(LOCALKEY_myAccount, myAccountModel);
    }).onError((error, stackTrace) {
      toast(error);
    });
  }

  /*===================================================================== Social login API Call  ==========================================================*/
  hitSocialLoginApi(user, int signInType) async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    customLoader.show(Get.overlayContext);
    var response = AuthRequestModel.socialLoginReq(
      userId: user!.uid,
      email: user.email,
      fullName: user.displayName,
      username: user.displayName,
      provider: signInType,
      img_url: user.photoURL,
      deviceName: APIRepository.deviceName,
      deviceType: APIRepository.deviceType,
      deviceToken: APIRepository.deviceID,
    );
    APIRepository.socialLoginApiCall(dataBody: response).then((value) async {
      loginModel = value;
      customLoader.hide();
      // storage.write(LOCALKEY_token, loginModel?.token);
      loader.value = false;
      toast(value.message);
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      toast(error);
    });
  }
}
