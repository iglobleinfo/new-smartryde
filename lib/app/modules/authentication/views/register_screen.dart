import 'package:smart_ryde/app/core/widgets/annotated_region_widget.dart';

import '../../../../../export.dart';
import '../../../core/utils/validators.dart';

class RegisterScreen extends GetView<RegisterController> {
  final formGlobalKey = GlobalKey<FormState>();

  RegisterScreen({super.key});
  Widget getBackButtonRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: margin_8,
        vertical: margin_8,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_rounded,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) {
          return AnnotatedRegionWidget(
            statusBarColor: primaryColor,
            statusBarBrightness: Brightness.dark,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      getBackButtonRow(context),
                      signUpForm(context: context),
                      AssetImageWidget(
                        imageUrl: imageBusMainLogin,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget signUpForm({
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: margin_12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: margin_50,
          ),
          TextView(
            text: userSignUp.tr,
            textStyle: textStyleBodyLarge(context),
          ),
          TextView(
            text: pleaseFillUpTheInformationBelow.tr,
            textStyle: textStyleLabelSmall(context).copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
          Form(
            key: formGlobalKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                TextFieldWidget(
                  textController: controller.nameController,
                  shadow: true,
                  hint: enterName.tr,
                ),
                TextFieldWidget(
                  textController: controller.numberController,
                  shadow: true,
                  hint: enterYourContactNumber.tr,
                ),
                TextFieldWidget(
                  textController: controller.emailController,
                  shadow: true,
                  hint: enterYourEmail.tr,
                  validate: (String? value) {
                    return emailTextFieldValidator(value, context);
                  },
                ),
                TextFieldWidget(
                  textController: controller.passwordController,
                  shadow: true,
                  hint: stringPassword.tr,
                  validate: (String? value) {
                    return passwordTextFieldValidator(value, context);
                  },
                ),
              ],
            ),
          ).marginOnly(bottom: margin_30),
          Align(
            alignment: Alignment.center,
            child: MaterialButtonWidget(
              buttonText: stringSignUp.tr.toUpperCase(),
              onPressed: () {
                if (formGlobalKey.currentState!.validate()) {
                  // Get.offAllNamed(AppRoutes.mainScreen);
                }
              },
            ),
          ).marginOnly(bottom: margin_20),
          Align(
            alignment: Alignment.center,
            child: TextView(
              text: doNotHaveAccountSignUpNow.tr,
              textStyle: textStyleBodySmall(context).copyWith(
                color: appClickableTextColor,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blueAccent,
                decorationThickness: 1,
              ),
            ),
          ),
          SizedBox(
            height: margin_20,
          ),
          Align(
            alignment: Alignment.center,
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: byContinuingYouAgreeTo.tr,
                children: [
                  TextSpan(
                    text: termsOfService.tr,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(AppRoutes.signUp);
                      },
                    style: textStyleBodySmall(context).copyWith(
                      color: appClickableTextColor,
                    ),
                  ),
                  TextSpan(
                    text: ' ${and.tr} ',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(AppRoutes.signUp);
                      },
                  ),
                  TextSpan(
                    text: privacyPolicy.tr,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(AppRoutes.signUp);
                      },
                    style: textStyleBodySmall(context).copyWith(
                      color: appClickableTextColor,
                    ),
                  ),
                ],
              ),
              style: textStyleBodySmall(context),
            ),
          )
        ],
      ),
    );
  }
}
