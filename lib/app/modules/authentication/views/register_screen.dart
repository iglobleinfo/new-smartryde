import 'package:smart_ryde/app/core/widgets/annotated_region_widget.dart';
import 'package:smart_ryde/app/core/widgets/custom_back_button.dart';

import '../../../../../export.dart';
import '../../../core/utils/validators.dart';
import 'bottom_phone_picker.dart';

class RegisterScreen extends GetView<RegisterController> {
  final formGlobalKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

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
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  leading: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CustomBackButton(),
                  ),
                ),
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AssetImageWidget(
                      imageUrl: imageBusMainLogin,
                    ),
                    signUpForm(context: context),
                  ],
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
            textStyle: textStyleLabelSmall(context).copyWith(fontSize: 19),
          ),
          TextView(
            text: pleaseFillUpTheInformationBelow.tr,
            textStyle: textStyleLabelSmall(context)
                .copyWith(fontWeight: FontWeight.normal, fontSize: 15),
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
                  allowSpacing: false,
                  inputFormatter: [
                    FilteringTextInputFormatter(
                        RegExp(
                            '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                        allow: false),
                  ],
                  inputType: TextInputType.text,
                  maxLength: 40,
                  onChange: (value) {
                    if (controller.nameController.text == ' ') {
                      controller.nameController.text = '';
                    }
                  },
                  hint: enterName.tr,
                ),
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
                        // contentPadding: EdgeInsets.all(margin_10),
                        textController: controller.countryPickerController,
                        shadow: true,
                        validate: (String? value) {
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextFieldWidget(
                        textController: controller.numberController,
                        focusNode: controller.nameFocusNode,
                        shadow: true,
                        maxLength: 10,
                        inputType: TextInputType.number,
                        hint: enterYourContactNumber.tr,
                        onChange: (value) {
                          if (controller.numberController.text == ' ') {
                            controller.numberController.text = '';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                TextFieldWidget(
                  textController: controller.emailController,
                  shadow: true,
                  hint: enterYourEmail.tr,
                  // validate: (String? value) {
                  //   return emailTextFieldValidator(value, context);
                  // },
                ),
                Obx(() {
                  IconData icon = controller.viewPassword.value
                      ? Icons.visibility_off
                      : Icons.visibility;
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
              buttonText: stringSignUp.tr.toUpperCase(),
              onPressed: () {
                if (formGlobalKey.currentState!.validate()) {
                  controller.hitSignUpAPI(context);
                }
              },
            ),
          ).marginOnly(bottom: margin_20),
          // Align(
          //   alignment: Alignment.center,
          //   child: GestureDetector(
          //     onTap: () {
          //       Get.offNamed(AppRoutes.logIn);
          //     },
          //     child: TextView(
          //       text: alreadyHaveAccountSignInNow.tr,
          //       textStyle: textStyleBodySmall(context).copyWith(
          //         color: appClickableTextColor,
          //         decoration: TextDecoration.underline,
          //         decorationColor: Colors.blueAccent,
          //         decorationThickness: 1,
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: margin_10,
          ),
          Align(
            alignment: Alignment.center,
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: byContinuingYouAgreeTo.tr,
                style: textStyleBodySmall(context)
                    .copyWith(color: Colors.black, fontSize: 17),
                children: [
                  TextSpan(
                    text: termsOfService.tr,
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: textStyleBodySmall(context)
                        .copyWith(color: appClickableTextColor, fontSize: 17),
                  ),
                  TextSpan(
                    text: ' ${and.tr} ',
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(
                    text: privacyPolicy.tr,
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: textStyleBodySmall(context)
                        .copyWith(color: appClickableTextColor, fontSize: 17),
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
