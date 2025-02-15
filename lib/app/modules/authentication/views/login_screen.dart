import 'package:smart_ryde/app/core/widgets/annotated_region_widget.dart';
import 'package:smart_ryde/app/core/widgets/custom_back_button.dart';
import 'package:smart_ryde/app/modules/authentication/views/bottom_phone_picker.dart';
import '../../../../../export.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.dark,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(),
                  loginForm(context: context),
                ],
              ),
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
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 55,
                      ),
                      child: TextFieldWidget(
                        readOnly: true,
                        onTap: () {
                          Get.bottomSheet(
                            BottomPhonePicker(
                              countryCode: ['+91', '+825'],
                              selectedCountryCode: (countryCode) {
                                controller.countryPickerController.text =
                                    countryCode;
                                Get.back();
                              },
                            ),
                          );
                        },
                        contentPadding: EdgeInsets.all(margin_10),
                        textController: controller.countryPickerController,
                        shadow: true,
                      ),
                    ),
                    Expanded(
                      child: TextFieldWidget(
                        textController: controller.phoneNumberController,
                        focusNode: controller.phoneFocusNode,
                        shadow: true,
                        maxLength: 10,
                        inputType: TextInputType.number,
                        hint: enterYourContactNumber.tr,
                        onChange: (value) {
                          if (controller.phoneNumberController.text == ' ') {
                            controller.phoneNumberController.text = '';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  IconData icon = controller.viewPassword.value
                      ? Icons.visibility
                      : Icons.visibility_off;
                  return TextFieldWidget(
                    suffixIcon: IconButton(
                      onPressed: controller.showOrHidePasswordVisibility,
                      icon: Icon(icon),
                    ),
                    obscureText: controller.viewPassword.value,
                    textController: controller.passwordController,
                    shadow: true,
                    hint: stringPassword.tr,
                  );
                }),
              ],
            ),
          ).marginOnly(bottom: margin_30),
          Align(
            alignment: Alignment.center,
            child: MaterialButtonWidget(
              buttonText: stringLogin.tr.toUpperCase(),
              onPressed: () {
                controller.hitLoginAPI(context);
              },
            ),
          ).marginOnly(bottom: margin_20),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.signUp);
              },
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
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: textStyleBodySmall(context).copyWith(
                      color: appClickableTextColor,
                    ),
                  ),
                  TextSpan(
                    text: ' ${and.tr} ',
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(
                    text: privacyPolicy.tr,
                    recognizer: TapGestureRecognizer()..onTap = () {},
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
