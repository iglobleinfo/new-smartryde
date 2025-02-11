import '../../../../../export.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  Widget getBackButtonRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: margin_8,
        vertical: margin_8,
      ),
      child: Row(
        children: [
          Icon(
            Icons.arrow_back_rounded,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                getBackButtonRow(context),
                loginForm(context: context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget loginForm({
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
            text: userLogin.tr,
            textStyle: textStyleBodyLarge(context),
          ),
          TextView(
            text: pleaseFillUpTheInformationBelow.tr,
            textStyle: textStyleLabelSmall(context).copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
          Form(
            key: controller.formGlobalKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  controller: TextEditingController(),
                  decoration: const InputDecoration(
                    hintText: '+12345678910',
                    labelText: 'Phone number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value != null && value.isNotEmpty ? null : 'Required',
                ),
              ],
            ),
          ).marginOnly(bottom: margin_30),
          Align(
            alignment: Alignment.center,
            child: MaterialButtonWidget(
              buttonText: stringLogin.tr.toUpperCase(),
              onPressed: () {
                if (controller.formGlobalKey.currentState!.validate()) {
                  Get.offAllNamed(AppRoutes.mainScreen);
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
                        Get.offAllNamed(AppRoutes.signUp);
                      },
                    style: textStyleBodySmall(context).copyWith(
                      color: appClickableTextColor,
                    ),
                  ),
                  TextSpan(
                    text: ' ${and.tr} ',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.offAllNamed(AppRoutes.signUp);
                      },
                  ),
                  TextSpan(
                    text: privacyPolicy.tr,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.offAllNamed(AppRoutes.signUp);
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
