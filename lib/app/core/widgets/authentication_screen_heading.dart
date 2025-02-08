import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ryde/app/core/values/dimens.dart';
import 'package:smart_ryde/app/core/values/text_styles.dart';
import 'package:smart_ryde/app/core/widgets/text_view.dart';

class AuthenticationScreenHeading extends StatelessWidget {
  final String title;
  final textStyle;
  final TextAlign textAlign;
  final topMargin;
  AlignmentGeometry? alignmentGeometry;

  AuthenticationScreenHeading({
    Key? key,
    required this.title,
    this.textStyle,
    this.topMargin,
    this.textAlign = TextAlign.center,
    this.alignmentGeometry = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: alignmentGeometry ?? Alignment.center,
        child: TextView(
          text: title.tr,
          textAlign: textAlign,
          textStyle: textStyle ??
              textStyleHeadlineSmall(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: font_26),
        )).paddingOnly(top: topMargin ?? margin_0);
  }
}
