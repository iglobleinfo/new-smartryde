import '../../../../../export.dart';

class ForgetScreen extends GetView<LoginController> {
  final formGlobalKey = GlobalKey<FormState>();
  final forgetController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: GetBuilder<LoginController>(builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(margin_30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextView(
                          text: 'forgot password?',
                          textStyle: textStyleTitle(context))
                      .marginOnly(bottom: margin_15, top: margin_30),
                  TextView(
                          text:
                              'A password reset link will be sent to registered email address.',
                          maxLine: 2,
                          textAlign: TextAlign.center,
                          textStyle: textStyleTitle(context))
                      .marginOnly(bottom: margin_30),
                  Form(
                    key: formGlobalKey,
                    child: TextFieldWidget(
                      textController: controller.forgetEmailController,
                      labelText: 'email',
                      focusNode: controller.forgetEmailFocusNode,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email address';
                        } else if (value.length > 0 &&
                            !GetUtils.isEmail(value)) {
                          return "Please enter valid email address";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ).marginOnly(bottom: margin_30),
                  Row(
                    children: [
                      Expanded(
                          child: MaterialButtonWidget(
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.logIn);
                        },
                        buttonText: 'send',
                      )),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
