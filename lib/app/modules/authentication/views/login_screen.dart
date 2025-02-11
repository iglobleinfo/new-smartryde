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
            textStyle: textStyleBodySmall(context),
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
          ).marginOnly(bottom: margin_10),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.forgotPassword);
              },
              child: TextView(
                text: stringForgotPassword,
                textStyle: textStyleTitle(context).copyWith(
                  color: colorRussianViolet,
                ),
              ),
            ),
          ).marginOnly(bottom: margin_15),
          MaterialButtonWidget(
            buttonText: stringLogin,
            onPressed: () {
              if (controller.formGlobalKey.currentState!.validate()) {
                Get.offAllNamed(AppRoutes.mainScreen);
              }
            },
          ).marginOnly(bottom: margin_60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                text: doNotHaveAccountSignUpNow.tr,
                textStyle: textStyleBodySmall(context).copyWith(
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blueAccent,
                  decorationThickness: 1,
                ),
              ),
            ],
          ),
          Text.rich(
            TextSpan(
              text: doNotHaveAccountSignUpNow.tr,
              children: [
                TextSpan(
                  text: ' $stringSignUp ',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.offAllNamed(AppRoutes.signUp);
                    },
                  style: TextStyle(
                      color: colorVioletM.shade50,
                      fontWeight: FontWeight.w800,
                      fontSize: font_16),
                  children: [
                    TextSpan(
                      text: stringWebsite,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: font_16),
                    ),
                  ],
                )
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: font_16,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
