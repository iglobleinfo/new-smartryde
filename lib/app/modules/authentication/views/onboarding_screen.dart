import 'package:smart_ryde/app/core/widgets/outline_button_widget.dart';
import 'package:smart_ryde/export.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                AssetImageWidget(
                  imageUrl: imageSignUpBackground,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: margin_20,
                    left: margin_5,
                  ),
                  child: TextView(
                    text: 'WELCOME ONBOARD TO\nSmartRyde',
                    textAlign: TextAlign.start,
                    textStyle: textStyleDisplayLarge(context).copyWith(
                      fontWeight: FontWeight.w500,
                      // fontSize: 25
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: margin_20,
            ),
            TextView(
              text: 'Please Login/Signup',
              textStyle: textStyleDisplayLarge(context).copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: margin_15,
            ),
            MaterialButtonWidget(
              minWidth: Get.width * 0.9,
              buttonColor: appFacebookButtonColor,
              buttonText: 'PROCEED USING FACEBOOK',
              onPressed: () {},
            ),
            SizedBox(
              height: margin_15,
            ),
            TextView(
              text: 'OR',
              textStyle: textStyleDisplayLarge(context).copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: margin_15,
            ),
            SizedBox(
              width: Get.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: MaterialButtonWidget(
                      buttonText: stringSignUp.tr.toUpperCase(),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: margin_10,
                  ),
                  Expanded(
                    child: OutlineButtonWidget(
                      outlineColor: appButtonColor,
                      text: stringLogin.tr.toUpperCase(),
                      textStyle: textStyleButton(context).copyWith(
                        color: appButtonColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
