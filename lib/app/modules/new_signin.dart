import '../../../../../export.dart';

class NewSignIn extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Container(
              color: colorAppColors,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height_60),
                  TextView(
                          text: 'Create Account',
                          textStyle: textStyleTitle(context)
                              .copyWith(color: Colors.white, fontSize: font_20))
                      .marginOnly(left: margin_15),
                  SizedBox(height: height_10),
                  TextView(
                          text: 'Sign up to your account',
                          textStyle: textStyleTitle(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal))
                      .marginOnly(left: margin_15),
                  SizedBox(height: height_30),
                  Container(
                    height: Get.height,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(radius_90))),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 20, left: 10, top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Form(
                              key: controller.formGlobalKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                      text: stringEmail,
                                      textStyle: textStyleTitle(context)),
                                  TextFieldWidget(
                                      textController:
                                          controller.emailController,
                                      labelText: stringEmail,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return stringEmailEmptyValidation;
                                        } else if (value.length > 0 &&
                                            !GetUtils.isEmail(value)) {
                                          return stringEmailValidValidation;
                                        } else {
                                          return null;
                                        }
                                      },
                                      focusNode: controller.emailFocusNode),
                                  TextFieldWidget(
                                      textController:
                                          controller.passwordController,
                                      labelText: stringPassword,
                                      obscureText: controller.viewPassword,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return stringPasswordEmptyValidation;
                                        } else {
                                          return null;
                                        }
                                      },
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            controller
                                                .showOrHidePasswordVisibility();
                                          },
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          icon: Icon(
                                            controller.viewPassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          )),
                                      focusNode: controller.passwordFocusNode),
                                  TextFieldWidget(
                                      textController:
                                          controller.passwordController,
                                      labelText: stringPassword,
                                      obscureText: controller.viewPassword,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return stringPasswordEmptyValidation;
                                        } else {
                                          return null;
                                        }
                                      },
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            controller
                                                .showOrHidePasswordVisibility();
                                          },
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          icon: Icon(
                                            controller.viewPassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          )),
                                      focusNode: controller.passwordFocusNode),
                                ],
                              )),
                          rememberMeWidget(),
                          MaterialButtonWidget(
                            buttonText: 'Sign Up',
                            onPressed: () {
                              if (controller.formGlobalKey.currentState!
                                  .validate()) {
                                Get.offAllNamed(AppRoutes.mainScreen);
                              }
                            },
                          ),
                          SizedBox(height: height_15),
                          const Divider(
                            color: colorAppColors,
                          ),
                          const Row(
                            children: [
                              Divider(
                                color: colorAppColors,
                              ),
                              Divider(
                                color: Colors.black,
                              )
                            ],
                          ),
                          SizedBox(
                            height: height_50,
                          ),
                          Text.rich(
                            TextSpan(text: stringDontHaveAccount, children: [
                              TextSpan(
                                  text: ' $stringSignUp ',
                                  recognizer: new TapGestureRecognizer()
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
                                            fontSize: font_16))
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
                ],
              ),
            ),
          ));
        });
  }

  rememberMeWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Checkbox(
            autofocus: true,
            activeColor: colorAppColors,
            value: controller.isRemember.value,
            onChanged: (value) {
              controller.isRemember.value = value!;
              controller.update();
            })),
        // Expanded(
        //   child: TextView(
        //           text:
        //               'By signing up,you agree to our Terms & conditions\n and Privacy Policy.',
        //           maxLine: 2,
        //           textStyle: textStyleTitle())
        //       .marginOnly(top: margin_10),
        // ),
      ],
    );
  }
}

///

/*
import '../../export.dart';

class NewSignIn extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NewSignIn> {
  int _counter = 0;
  Offset _offset = Offset.zero; // changed

  void _incrementCounter()
  {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
        // Transform widget
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // perspective
          ..rotateX(0.01 * _offset.dy) // changed
          ..rotateY(-0.01 * _offset.dx), // changed
        alignment: FractionalOffset.center,
        child: GestureDetector(
          // new
          onPanUpdate: (details) => setState(() => _offset += details.delta),
          onDoubleTap: () => setState(() => _offset = Offset.zero),
          child: _defaultApp(context),
        ));
  }

  _defaultApp(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Matrix 3D'), // changed
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
*/
