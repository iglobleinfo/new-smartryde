import 'package:smart_ryde/export.dart';

Widget buildImage(String assetName, {double? width, double? height = 200}) {
  return SizedBox(
    height: height,
    child: Image.asset(
      assetName,
      width: width,
      height: height,
    ),
  );
}

var pageDecoration = PageDecoration(
  titleTextStyle: TextStyle(
      fontSize: font_18, color: Colors.black, fontWeight: FontWeight.w400),
  bodyTextStyle: TextStyle(
      fontSize: font_18, color: Colors.black, fontWeight: FontWeight.w400),
  bodyPadding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
  pageColor: Colors.white,
  imagePadding: EdgeInsets.zero,
);

List<Widget> pages = [
  const OnBoardingScreen(
    label:
        "Welcome to pub.dev Reader\n\nWhere you can enjoy the reading experience with our app.",
    image: iconImg1,
    footer: iconSlider1,
  ),
  const OnBoardingScreen(
    label:
        'To start the reading experience, you have to login to Flutter/library, download a book, and then enjoy reading.',
    image: iconImg2,
    footer: iconSlider2,
  ),
  const OnBoardingScreen(
    label:
        'Print reader provides a customizable reading experience, and other features where you can lend books to friends or family or gift it as a gift.',
    image: iconImg3,
    footer: iconSlider3,
  ),
];

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen(
      {Key? key,
      required this.label,
      required this.image,
      required this.footer})
      : super(key: key);
  final String label;
  final String image;
  final String footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Column(
                children: [
                  buildImage(image).marginOnly(bottom: margin_30),
                  TextView(
                      text: label,
                      maxLine: 4,
                      textStyle: textStyleTitle(context),
                      textAlign: TextAlign.center),
                ],
              ),
              const Spacer(),
              AssetImageWidget(
                  imageUrl: footer,
                  imageHeight: 12,
                  imageWidth: 90,
                  imageFitType: BoxFit.contain)
            ],
          ),
        ),
      ),
    );
  }
}
