import 'package:smart_ryde/export.dart';

class MaterialButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final double? buttonRadius;
  final double? minWidth;
  final double? minHeight;
  final double? padding;
  final onPressed;
  final decoration;
  final elevation;
  final bool? isSocial;
  final double? fontsize;
  final Widget? iconWidget;

  const MaterialButtonWidget({
    Key? key,
    this.buttonText = "",
    this.buttonColor,
    this.textColor,
    this.buttonRadius = defaultRaduis,
    this.decoration,
    this.isSocial = false,
    this.onPressed,
    this.elevation,
    this.iconWidget,
    this.fontsize,
    this.minWidth,
    this.minHeight,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: minHeight,
      splashColor: Colors.transparent,
      minWidth: minWidth ?? Get.width,
      color: buttonColor ?? colorAppColors,
      elevation: elevation ?? radius_4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius!)),
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(vertical: padding ?? margin_15),
      child: TextView(
        text: buttonText!,
        textStyle: textStyleButton(context).copyWith(
          color: textColor ?? Colors.white,
          fontSize: fontsize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
