import '../../../../../export.dart';

class LoginController extends GetxController {
  late TextEditingController countryPickerController;
  late TextEditingController phoneNumberController;
  late TextEditingController forgetEmailController;
  late TextEditingController passwordController;
  late FocusNode emailFocusNode= FocusNode();
  late FocusNode forgetEmailFocusNode= FocusNode();
  late FocusNode phoneFocusNode= FocusNode();
  late FocusNode passwordFocusNode= FocusNode();
  late FocusNode loginFocusNode= FocusNode();
  LoginResponseModel? loginModel;
  MyAccountModel? myAccountModel;
  late CustomLoader customLoader;
  RxBool loader = false.obs;
  RxBool isRemember = false.obs;
  bool viewPassword = false;
  final formGlobalKey = GlobalKey<FormState>();
  int maxDigit= 8;
  @override
  void onInit() {
    phoneNumberController = TextEditingController();
    countryPickerController = TextEditingController();
    countryPickerController.text = '+825';
    forgetEmailController = TextEditingController();
    passwordController = TextEditingController();
    customLoader = CustomLoader();
    debugPrint('initCalled');
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    customLoader.hide();
    phoneNumberController.dispose();
    forgetEmailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    forgetEmailFocusNode.dispose();
    passwordFocusNode.dispose();
    loginFocusNode.dispose();
    super.dispose();
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
    viewPassword = !viewPassword;
    update();
  }

  /*===================================================================== Social Login  ==========================================================*/
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signIn().onError((error, stackTrace) {
      debugPrint(error.toString());
      return toast('stringGoogleSignInCancelled');
    });

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> signInWithFacebook() async {
    String? token;
    await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
        loginBehavior: LoginBehavior.nativeWithFallback).then((value) {
      token = value.accessToken!.tokenString;
    }).onError((error, stackTrace) {});

    if (token == null) return null;
    final facebookAuthCredential = FacebookAuthProvider.credential(token!);

    var cred = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .onError((error, stackTrace) {
      return toast(error.toString());
    });
    return cred;
  }

  Future signInWithApple() async {
    final AuthorizationResult result = await TheAppleSignIn.performRequests([
      const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        return result;

      case AuthorizationStatus.error:
        debugPrint("Sign in failed: ${result.error!.localizedDescription}");
        break;

      case AuthorizationStatus.cancelled:
        debugPrint('User cancelled');
        break;
    }
  }

  Future logInGoogle() async {
    try {
      customLoader.show(Get.overlayContext);
      UserCredential userCredential = await signInWithGoogle();
      hitSocialLoginApi(userCredential.user, googleSignIn);
    } on FirebaseException catch (e) {
      customLoader.hide();
      toast(e.message);
    } catch (e) {
      customLoader.hide();
      toast(
        'stringGoogleSignInCancelled',
      );
    }
  }

  Future logInFaceBook() async {
    try {
      customLoader.show(Get.overlayContext);
      UserCredential? userCredential = await signInWithFacebook();
      if (userCredential != null) {
        hitSocialLoginApi(userCredential.user, fbSignIn);
      } else {
        customLoader.hide();
        toast('stringFbSignInCancelled');
      }
    } on FirebaseException catch (e) {
      customLoader.hide();
      debugPrint(e.message);
    } catch (e) {
      customLoader.hide();
      toast('stringFbSignInCancelled');
    }
  }

  Future logInApple() async {
    try {
      AuthorizationResult? userCredential = await signInWithApple();

      customLoader.show(Get.overlayContext);
      hitSocialLoginApi(
        userCredential!.credential!,
        appleSignIn,
      );
    } on FirebaseException catch (e) {
      customLoader.hide();
      print(e.message);
    } catch (e) {
      customLoader.hide();
      toast('stringAppleSignInCancelled');
    }
  }

  //APIs

  /*===================================================================== Login API Call  ==========================================================*/
  hitLoginAPI(context) {
    loader.value = true;
    customLoader.show(context);
    FocusManager.instance.primaryFocus!.unfocus();
    var loginReq = AuthRequestModel.loginReq(
      phoneNumber: countryPickerController.text+phoneNumberController.text,
      password: passwordController.text,
    );
    APIRepository.loginApiCall(dataBody: loginReq)
        .then((LoginResponseModel? value) async {
      loginModel = value;
      customLoader.hide();
      // storage.write(LOCALKEY_token, loginModel?.token);
      loader.value = false;
      toast(value?.message ?? 'Logged In');
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      toast(error);
    });
  }

  /*===================================================================== Forgot password API Call  ==========================================================*/
  hitForgetAPI(context) {
    customLoader.show(context);
    FocusManager.instance.primaryFocus!.unfocus();
    var loginReq = AuthRequestModel.forgetReq(
      phoneNumber: forgetEmailController.text.trim().toLowerCase(),
    );
    APIRepository.forgetApiCall(dataBody: loginReq).then((value) {
      toast(value?.message, seconds: 1);
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(() => LoginScreen());
        forgetEmailController.clear();
      });
    }).onError((error, stackTrace) {
      customLoader.hide();
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
