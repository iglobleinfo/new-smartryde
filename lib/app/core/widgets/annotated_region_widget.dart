import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';

import '../../../export.dart';

class AnnotatedRegionWidget extends StatelessWidget {
  final Widget child;
  final Color statusBarColor;
  final Brightness statusBarBrightness;

  const AnnotatedRegionWidget(
      {Key? key,
      required this.child,
      required this.statusBarColor,
      required this.statusBarBrightness})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: statusBarColor,
            statusBarBrightness: statusBarBrightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark, // ios
            statusBarIconBrightness: statusBarBrightness),
        child: ColorfulSafeArea(
          color: statusBarColor,
          bottom: Platform.isAndroid ? true : false,
          child: child,
        ));
  }
}
