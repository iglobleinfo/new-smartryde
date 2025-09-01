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
            Expanded(
              child: Stack(
                children: [
                  AssetImageWidget(
                    imageHeight: double.infinity,
                    imageFitType: BoxFit.fill,
                    imageUrl: imageSignUpBackground,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 22,
                      left: 15,
                    ),
                    child: TextView(
                      text: keyWelcome.tr,
                      textAlign: TextAlign.start,
                      textStyle: textStyleDisplayLarge(context).copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: margin_20.h,
            ),
            TextView(
              text: keyLoginSignUp.tr,
              textStyle: textStyleDisplayLarge(context).copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            // SizedBox(
            //   height: margin_15.h,
            // ),
            // MaterialButtonWidget(
            //   minWidth: Get.width * 0.9,
            //   buttonColor: appFacebookButtonColor,
            //   buttonText: 'PROCEED USING FACEBOOK',
            //   onPressed: () {},
            // ),
            // SizedBox(
            //   height: margin_15.h,
            // ),
            // TextView(
            //   text: 'OR',
            //   textStyle: textStyleDisplayLarge(context).copyWith(
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            SizedBox(
              height: margin_15.h,
            ),
            SizedBox(
              width: Get.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: MaterialButtonWidget(
                      buttonText: keySignUp.tr,
                      onPressed: () {
                        Get.toNamed(AppRoutes.signUp);
                      },
                    ),
                  ),
                  SizedBox(
                    width: margin_10.h,
                  ),
                  Expanded(
                    child: OutlineButtonWidget(
                      onTap: () {
                        Get.toNamed(AppRoutes.logIn);
                      },
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
            ),
            getContinueToService(context),
            SizedBox(
              height: margin_20.h,
            )
          ],
        ),
      ),
    );
  }

  Widget getContinueToService(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: margin_30,
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
                    fontSize: 16,
                    color: appClickableTextColor,
                  ),
                ),
                TextSpan(
                  text: ' ${and.tr} ',
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  style: textStyleBodySmall(context).copyWith(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: privacyPolicy.tr,
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  style: textStyleBodySmall(context).copyWith(
                    color: appClickableTextColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            style: textStyleBodySmall(context),
          ),
        )
      ],
    );
  }
}
