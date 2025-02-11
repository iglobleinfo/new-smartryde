import '../../../../../export.dart';

class RegisterScreen extends GetView<RegisterController> {
  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AssetImageWidget(
                                    imageUrl: iconSmallLogo, imageHeight: 70)
                                .marginOnly(bottom: margin_16),
                            TextView(
                              text: 'stringRegister',
                              maxLine: 2,
                              textStyle: textStyleTitle(context),
                              textAlign: TextAlign.center,
                            ).marginOnly(bottom: margin_16),
                            Form(
                                key: formGlobalKey,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                  children: [
                                    TextFieldWidget(
                                      textController:
                                          controller.emailController,
                                      labelText: 'stringEmail',
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'stringEmailEmptyValidation';
                                        } else if (value.length > 0 &&
                                            !GetUtils.isEmail(value)) {
                                          return 'stringEmailValidValidation';
                                        } else {
                                          return null;
                                        }
                                      },
                                      focusNode: controller.emailFocusNode,
                                    ).marginOnly(bottom: margin_16),
                                    TextFieldWidget(
                                        textController:
                                            controller.passwordController,
                                        labelText: 'stringPassword',
                                        obscureText: true,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'stringPasswordEmptyValidation';
                                          } else {
                                            return null;
                                          }
                                        },
                                        focusNode:
                                            controller.passwordFocusNode),
                                  ],
                                )).marginOnly(bottom: margin_16),
                            MaterialButtonWidget(
                              onPressed: () {
                                if (formGlobalKey.currentState!.validate()) {
                                  controller.update();
                                  controller.hitLoginAPI(context);
                                }
                              },
                              buttonText: 'stringRegister',
                            ).marginOnly(bottom: margin_65),
                            GestureDetector(
                              onTap: () {},
                              child: Text.rich(
                                TextSpan(
                                    text: 'stringAlreadyHaveAccount',
                                    children: [
                                      TextSpan(
                                        text: '',
                                        recognizer: new TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.offAllNamed(AppRoutes.logIn);
                                          },
                                        style: TextStyle(
                                            color: colorVioletM.shade50,
                                            fontWeight: FontWeight.w800,
                                            fontSize: font_16),
                                      )
                                    ]),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: font_16,
                                  fontWeight: FontWeight.w400,
                                ),
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
