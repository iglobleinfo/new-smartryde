import 'package:smart_ryde/app/core/widgets/custom_back_button.dart';

import '../../../../../export.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  final formGlobalKey = GlobalKey<FormState>();

  ProfileScreen({super.key});

  Widget userDetailForm({
    required BuildContext context,
  }) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomBackButton(),
          SizedBox(
            height: 30,
          ),
          TextView(
                  text: 'Edit Profile',
                  maxLine: 1,
                  textStyle: textStyleTitle(context).copyWith(fontSize: 22))
              .marginOnly(bottom: margin_5),
          Form(
            key: formGlobalKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                TextView(
                        text: 'Name',
                        maxLine: 1,
                        textStyle: textStyleTitle(context))
                    .marginOnly(bottom: margin_5),
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
                SizedBox(
                  height: 15,
                ),
                TextView(
                        text: 'Email',
                        maxLine: 1,
                        textStyle: textStyleTitle(context))
                    .marginOnly(bottom: margin_5),
                TextFieldWidget(
                  textController: controller.emailController,
                  shadow: true,
                  hint: enterYourEmail.tr,
                  // validate: (String? value) {
                  //   return emailTextFieldValidator(value, context);
                  // },
                ),
                SizedBox(
                  height: 15,
                ),
                TextView(
                        text: 'Phone Number',
                        maxLine: 1,
                        textStyle: textStyleTitle(context))
                    .marginOnly(bottom: margin_5),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        textController: controller.numberController,
                        focusNode: controller.nameFocusNode,
                        shadow: true,
                        readOnly: true,
                        maxLength: 10,
                        textColor: Colors.grey,
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
              ],
            ),
          ).marginOnly(bottom: margin_30),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            return Scaffold(
              // appBar: CustomAppBar(appBarTitleText: 'Edit Profile',),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: margin_16, horizontal: margin_10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userDetailForm(context: context),
                    const Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: MaterialButtonWidget(
                        minWidth: Get.width,
                        fontsize: 14,
                        buttonText: 'Save Changes'.tr.toUpperCase(),
                        onPressed: () {
                          if (formGlobalKey.currentState!.validate()) {
                            controller.hitUpdateProfileAPI(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

Widget doubleText(BuildContext context, topText, bottomText) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(text: topText, maxLine: 1, textStyle: textStyleTitle(context))
            .marginOnly(bottom: margin_5),
        TextView(
            text: bottomText, textStyle: textStyleTitle(context), maxLine: 1),
      ],
    );
