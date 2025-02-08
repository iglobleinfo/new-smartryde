import '../../../../../export.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: Padding(
                  padding: EdgeInsets.fromLTRB(
                      margin_16, margin_30, margin_16, margin_16),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AssetImageWidget(
                                        imageUrl: iconSmallLogo,
                                        imageHeight: margin_70)
                                    .marginOnly(bottom: margin_15),
                                TextView(
                                        text: stringLoginHeading,
                                        maxLine: 2,
                                        textStyle: textStyleHeading2(context))
                                    .marginOnly(bottom: margin_15),
                                Form(
                                    key: controller.formGlobalKey,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: Column(
                                      children: [
                                        TextFieldWidget(
                                                textController:
                                                    controller.emailController,
                                                labelText: stringEmail,
                                                validate: (value) {
                                                  if (value!.isEmpty) {
                                                    return stringEmailEmptyValidation;
                                                  } else if (value.length > 0 &&
                                                      !GetUtils.isEmail(
                                                          value)) {
                                                    return stringEmailValidValidation;
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                focusNode:
                                                    controller.emailFocusNode)
                                            .marginOnly(bottom: margin_15),
                                        TextFieldWidget(
                                            textController:
                                                controller.passwordController,
                                            labelText: stringPassword,
                                            obscureText:
                                                controller.viewPassword,
                                            validate: (value) {
                                              if (value!.isEmpty)
                                                return stringPasswordEmptyValidation;
                                              else
                                                return null;
                                            },
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  controller
                                                      .showOrHidePasswordVisibility();
                                                },
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                icon: Icon(
                                                  controller.viewPassword
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                )),
                                            focusNode:
                                                controller.passwordFocusNode),
                                      ],
                                    )).marginOnly(bottom: margin_10),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.forgotPassword);
                                    },
                                    child: TextView(
                                      text: stringForgotPassword,
                                      textStyle:
                                          textStyleTitle(context).copyWith(
                                        color: colorRussianViolet,
                                      ),
                                    ),
                                  ),
                                ).marginOnly(bottom: margin_15),
                                MaterialButtonWidget(
                                  buttonText: stringLogin,
                                  onPressed: () {
                                    if (controller.formGlobalKey.currentState!
                                        .validate()) {
                                      Get.offAllNamed(AppRoutes.mainScreen);
                                    }
                                  },
                                ).marginOnly(bottom: margin_60),
                                Text.rich(
                                  TextSpan(
                                      text: stringDontHaveAccount,
                                      children: [
                                        TextSpan(
                                            text: ' $stringSignUp ',
                                            recognizer:
                                                new TapGestureRecognizer()
                                                  ..onTap = () {
                                                    Get.offAllNamed(
                                                        AppRoutes.signUp);
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
                                              )
                                            ])
                                      ]),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: font_16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        });
  }
}
