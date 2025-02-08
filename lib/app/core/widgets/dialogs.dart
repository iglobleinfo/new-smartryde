import 'package:smart_ryde/export.dart';

logoutDialog(BuildContext context) {
  return Get.dialog(
    Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white10,
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: margin_40),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [BoxShadow(color: Colors.white, blurRadius: 4)],
              border: Border.all(color: Colors.white, width: width_4),
              borderRadius: BorderRadius.circular(margin_10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getInkWell(
                onTap: () {
                  Get.back();
                },
                child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: margin_40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.white, blurRadius: 4)
                    ],
                    border: Border.all(color: Colors.white, width: width_4),
                    borderRadius: BorderRadius.circular(margin_10)),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    AssetImageWidget(
                            imageUrl: iconSmallLogo, imageHeight: height_70)
                        .marginOnly(bottom: height_10),
                    TextView(
                      text: stringLogoutHeading,
                      textStyle: textStyleTitle(context),
                      maxLine: 5,
                      textAlign: TextAlign.center,
                    ).marginOnly(bottom: height_10),
                    Row(
                      children: [
                        Expanded(
                            child: _yesBtn(
                                    onTap: () {
                                      storage.remove(LOCALKEY_token);
                                      log.e(storage.read(LOCALKEY_token));
                                      log.e(storage.read(LOCALKEY_myAccount));
                                      Get.offAllNamed(AppRoutes.logIn);
                                      toast(stringLogoutSuccess);
                                    },
                                    label: stringLogout)
                                .marginOnly(right: width_10)),
                        Expanded(child: _noBtn().marginOnly(left: width_10)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

deleteAccountDialog(BuildContext context) {
  return Get.dialog(
    Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white10,
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: margin_40),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [BoxShadow(color: Colors.white, blurRadius: 4)],
              border: Border.all(color: Colors.white, width: width_4),
              borderRadius: BorderRadius.circular(margin_10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getInkWell(
                onTap: () {
                  Get.back();
                },
                child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: margin_40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.white, blurRadius: 4)
                    ],
                    border: Border.all(color: Colors.white, width: width_4),
                    borderRadius: BorderRadius.circular(margin_10)),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    AssetImageWidget(imageUrl: iconSmallLogo, imageHeight: 70)
                        .marginOnly(bottom: height_10),
                    TextView(
                            text: stringDeleteHeading,
                            maxLine: 5,
                            textAlign: TextAlign.center,
                            textStyle: textStyleTitle(context))
                        .marginOnly(bottom: height_10),
                    Row(
                      children: [
                        Expanded(
                            child: _yesBtn(
                                    onTap: () {
                                      storage.remove(LOCALKEY_token);
                                      log.e(storage.read(LOCALKEY_token));
                                      log.e(storage.read(LOCALKEY_myAccount));
                                      Get.offAllNamed(AppRoutes.logIn);
                                      toast(stringAccountDeleteSuccess);
                                    },
                                    label: stringDelete)
                                .marginOnly(right: width_10)),
                        Expanded(child: _noBtn().marginOnly(left: width_10)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

Widget _yesBtn({onTap, label}) {
  return MaterialButtonWidget(
      onPressed: onTap ?? () {},
      buttonText: label ?? '',
      buttonColor: colorVioletM);
}

Widget _noBtn() {
  return MaterialButtonWidget(
      onPressed: () {
        Get.back();
      },
      buttonText: stringCancel,
      buttonColor: colorVioletM);
}

appExpirationDialog(BuildContext context) {
  return Get.dialog(
    AlertDialog(
      title: Container(
          height: height_150,
          width: Get.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius_10),
                topRight: Radius.circular(radius_10),
              )),
          child: AssetImageWidget(
              imageUrl: iconAlertGif, imageFitType: BoxFit.cover)),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(
          horizontal: margin_10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView(
                    text: stringDemoExpired,
                    maxLine: 5,
                    textAlign: TextAlign.center,
                    textStyle: textStyleTitle(context))
                .marginOnly(bottom: height_10),
            TextView(
                    text: stringAppDemoExpiredDesc,
                    maxLine: 5,
                    textAlign: TextAlign.center,
                    textStyle: textStyleSubTitle(context))
                .marginOnly(bottom: height_10),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius_10)),
    ),
    barrierColor: Colors.grey.shade300,
    barrierDismissible: false,
  );
}
