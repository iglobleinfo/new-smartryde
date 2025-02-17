import 'package:smart_ryde/export.dart';

class MaterialButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final double? buttonRadius;
  final double? minWidth;
  final double? minHeight;
  final double? verticalPadding;
  final double? horizontalPadding;
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
    this.buttonRadius,
    this.decoration,
    this.isSocial = false,
    this.onPressed,
    this.elevation,
    this.iconWidget,
    this.fontsize,
    this.minWidth,
    this.minHeight,
    this.verticalPadding,
    this.horizontalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: minHeight,
      splashColor: Colors.transparent,
      minWidth: minWidth ?? Get.width * 0.45,
      color: buttonColor ?? appButtonColor,
      elevation: elevation ?? 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          buttonRadius ?? 0,
        ),
      ),
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding ?? margin_12,
        horizontal: horizontalPadding ?? margin_20,
      ),
      child: TextView(
        text: buttonText!,
        textStyle: textStyleButton(context).copyWith(
          color: textColor ?? Colors.white,
          fontSize: fontsize??16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
