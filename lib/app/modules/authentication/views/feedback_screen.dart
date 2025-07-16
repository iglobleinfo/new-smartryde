import 'package:smart_ryde/app/core/widgets/custom_back_button.dart';
import 'package:smart_ryde/app/modules/authentication/views/helper_bottomsheet.dart';

import '../../../../../export.dart';
import '../../home_booking/bottomsheets/destiny_bottomsheet.dart';
import '../controllers/feedback_controller.dart';

class FeedbackScreen extends GetView<FeedbackController> {
  final formGlobalKey = GlobalKey<FormState>();

  FeedbackScreen({super.key});

  Widget userDetailForm({
    required BuildContext context,
  }) {
    return GetBuilder<FeedbackController>(builder: (controller) {
      return Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              TextView(
                text: keyDropAFeedback.tr,
                maxLine: 1,
                textStyle: textStyleTitle(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ).marginOnly(bottom: margin_5),
              TextView(
                text: keyAboutYourExperienceInRides.tr,
                maxLine: 1,
                textStyle: textStyleTitle(context).copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ).marginOnly(bottom: margin_5),
              Form(
                key: formGlobalKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      hint: keyTypeOfFeedback.tr,
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                      ),
                      readOnly: true,
                      onTap: () {
                        Get.bottomSheet(
                          HelperBottomsheet(
                            list: [
                              keyCommendation.tr,
                              keyComplaint.tr,
                              keySuggestion.tr,
                            ],
                            selectedValue: (countryCode) {
                              controller.feedbackController.text = countryCode;
                              Get.back();
                            },
                          ),
                        );
                      },
                      // contentPadding: EdgeInsets.all(margin_10),
                      textController: controller.feedbackController,
                      shadow: true,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 65,
                          ),
                          child: TextFieldWidget(
                            hint: keySelect.tr,
                            readOnly: true,
                            onTap: () {
                              Get.bottomSheet(
                                HelperBottomsheet(
                                  list: [
                                    keyMr.tr,
                                    keyMs.tr,
                                    keyMrs.tr,
                                  ],
                                  selectedValue: (countryCode) {
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
                    // TextView(
                    //         text: 'Phone Number',
                    //         maxLine: 1,
                    //         textStyle: textStyleTitle(context))
                    //     .marginOnly(bottom: margin_5),
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            textController: controller.numberController,
                            focusNode: controller.nameFocusNode,
                            shadow: true,
                            maxLength: 10,
                            // textColor: Colors.grey,
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
                    SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      textColor: Colors.grey,
                      hint: keySelectRoute.tr,
                      hintStyle: textStyleBodyMedium(context).copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 17),
                      readOnly: true,
                      onTap: () {
                        Get.bottomSheet(
                          DestinyBottomsheet(
                            list: controller.districtList,
                            selectedDistrict: (district) {
                              controller.routeController.text = district;
                              Get.back();
                            },
                            selectedDistrictId: (districtId) {
                              controller.pickUp1DistrictId = districtId;
                              controller.update();
                            },
                          ),
                        );
                      },
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                      ),
                      textController: controller.routeController,
                      shadow: true,
                      validate: (String? value) {
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      textColor: Colors.grey,
                      hint: keySelectDate.tr,
                      hintStyle: textStyleBodyMedium(context).copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 17),
                      readOnly: true,
                      onTap: () {
                        _selectDateTime(context);
                      },
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                      ),
                      textController: controller.dateTimeController,
                      shadow: true,
                      validate: (String? value) {
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      textController: controller.incidentController,
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
                      maxline: 5,
                      minLine: 5,
                      onChange: (value) {
                        if (controller.incidentController.text == ' ') {
                          controller.incidentController.text = '';
                        }
                      },
                      hint: keyIncidentDetails.tr,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: MaterialButtonWidget(
                        minWidth: 150,
                        minHeight: 50,
                        fontsize: 14,
                        buttonText: keySubmit.tr.toUpperCase(),
                        onPressed: () {
                          if (formGlobalKey.currentState!.validate()) {
                            controller.hitAddFeedbackAPI(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ).marginOnly(bottom: margin_30),
            ],
          ),
        ),
      );
    });
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final ThemeData themedata = Theme.of(context).copyWith(
      colorScheme: ColorScheme.light(
        primary:
            primaryColor, // Header background color// Header text color// Body text color
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor, // Button text color
        ),
      ),
    );
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(data: themedata, child: child!);
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: Theme(data: themedata, child: child!),
          );
        },
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        controller.dateTimeController.text =
            finalDateTime.toString().split('.').first;
        controller.update();

        print("Selected DateTime: $finalDateTime");
        // You can update your UI or state with finalDateTime
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<FeedbackController>(
          init: FeedbackController(),
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
                    CustomBackButton(),
                    userDetailForm(context: context),
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
