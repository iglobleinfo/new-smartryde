import '../../../../../export.dart';

class ProfileScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(appBarTitleText: 'Account Information'.tr),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: margin_16, horizontal: margin_30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    doubleText(context, 'Username',
                            controller.myAccountModel?.fullname ?? '')
                        .marginOnly(bottom: margin_30, top: margin_20),
                    doubleText(context, 'email',
                            controller.myAccountModel?.email ?? '')
                        .marginOnly(bottom: margin_30),
                    doubleText(context, 'Phone Number',
                        controller.myAccountModel?.mobile ?? ''),
                    const Spacer(),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text.rich(
                            TextSpan(
                                text: 'To manage your account visit',
                                children: [
                                  TextSpan(
                                      text: ' Fluter',
                                      style: TextStyle(
                                          color: colorVioletM.shade50,
                                          fontWeight: FontWeight.w800,
                                          fontSize: font_16),
                                      children: [
                                        TextSpan(
                                          text: "website",
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
                          ),
                        ).marginOnly(bottom: margin_12),
                        MaterialButtonWidget(
                          onPressed: () {},
                          buttonText: 'manage',
                        ),
                      ],
                    ).marginOnly(bottom: margin_30),
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
