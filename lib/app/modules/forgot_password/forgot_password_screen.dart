import 'package:smart_ryde/app/core/widgets/custom_back_button.dart';
import 'package:smart_ryde/app/core/widgets/outline_button_widget.dart';
import 'package:smart_ryde/app/modules/authentication/views/bottom_phone_picker.dart';
import 'package:smart_ryde/app/modules/forgot_password/forgot_password_controller.dart';

import '../../../../../export.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
        body: GetBuilder<ForgotPasswordController>(
          init: ForgotPasswordController(),
          builder: (controller) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AssetImageWidget(
                  imageUrl: imageBusMainLogin,
                ),
                getForgotPasswordForm(context: context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getForgotPasswordForm({
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
            text: stringForgotPassword.tr,
            textStyle: textStyleBodyLarge(context),
          ),
          TextView(
            text: pleaseFillUpTheInformationBelow.tr,
            textStyle: textStyleLabelSmall(context).copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Form(
            key: controller.formKey,
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
                        // contentPadding: EdgeInsets.all(margin_10),
                        textController: controller.countryPickerController,
                        shadow: true,
                      ),
                    ),
                    Expanded(
                      child: TextFieldWidget(
                        textController: controller.phoneNumberController,
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
                TextFieldWidget(
                  textController: controller.otpTextController,
                  shadow: true,
                  maxLength: 4,
                  inputType: TextInputType.number,
                  hint: stringEnterOtp.tr,
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
                    maxLength: 10,
                    inputType: TextInputType.text,
                    hint: stringNewPassword.tr,
                  );
                }),
              ],
            ),
          ),
          SizedBox(
            height: margin_30,
          ),
          MaterialButtonWidget(
            minWidth: double.infinity,
            buttonText: stringSubmitPassword.tr.toUpperCase(),
            onPressed: () {
              controller.hitSubmitPassword(context);
            },
          ),
          SizedBox(
            height: margin_10,
          ),
          SizedBox(
            width: double.infinity,
            child: OutlineButtonWidget(
              onTap: () {
                controller.hitGenerateOtpAPI(context);
              },
              outlineColor: appButtonColor,
              text: stringGetOtp.tr.toUpperCase(),
              textStyle: textStyleButton(context).copyWith(
                color: appButtonColor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
