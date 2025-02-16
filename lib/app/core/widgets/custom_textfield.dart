import 'package:flutter/foundation.dart';
import 'package:smart_ryde/export.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final String? labelText;
  final String? tvHeading;
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final Color? courserColor;
  final validate;
  final hintStyle;
  final EdgeInsets? contentPadding;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function()? onTap;
  final TextInputAction? inputAction;
  final bool? hideBorder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxline;
  final decoration;
  final int? minLine;
  final int? maxLength;
  final bool readOnly;
  final bool? shadow;
  final bool? obscureText;
  final bool? isOutined;
  final bool? allowSpacing;
  final Function(String value)? onChange;
  final inputFormatter;
  final errorColor;

  const TextFieldWidget({
    this.hint,
    this.labelText,
    this.tvHeading,
    this.inputType,
    this.textController,
    this.hintStyle,
    this.courserColor,
    this.validate,
    this.onChange,
    this.decoration,
    this.radius,
    this.focusNode,
    this.readOnly = false,
    this.shadow,
    this.onFieldSubmitted,
    this.inputAction,
    this.height,
    this.width,
    this.contentPadding,
    this.isOutined = false,
    this.maxline = 1,
    this.minLine = 1,
    this.maxLength,
    this.color,
    this.hideBorder = true,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.allowSpacing = true,
    this.onTap,
    this.inputFormatter,
    this.errorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
                readOnly: readOnly,
                onTap: onTap,
                obscureText: obscureText ?? false,
                controller: textController,
                focusNode: focusNode,
                keyboardType: inputType,
                maxLength: maxLength,
                onChanged: onChange,
                cursorColor: courserColor ?? colorAppColor,
                inputFormatters: inputFormatter ??
                    [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      FilteringTextInputFormatter(
                          RegExp(
                              '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                          allow: false),
                    ],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: maxline,
                minLines: minLine,
                textInputAction: inputAction,
                onFieldSubmitted: onFieldSubmitted,
                validator: validate,
                style: textStyleBodySmall(context).copyWith(
                  fontWeight: FontWeight.normal,
                ),
                decoration: inputDecoration(context))
            .marginOnly(bottom: 0.5, right: 0.5),
      ],
    );
  }

  inputDecoration(context) => InputDecoration(
      counterText: "",
      errorMaxLines: 2,
      errorStyle: textStyleBody1(context).copyWith(
          fontSize: font_10,
          fontWeight: FontWeight.w500,
          color: errorColor ?? Colors.red),
      isDense: true,
      filled: true,
      contentPadding: contentPadding ??
          EdgeInsets.only(left: margin_10, top: margin_10, bottom: margin_10),
      prefixIcon: prefixIcon,
      suffixIcon: isOutined == true ? null : suffixIcon,
      hintText: hint,
      hintStyle: hintStyle ??
          textStyleBodySmall(context).copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
      labelText: labelText,
      fillColor: appTextFieldBackgroundColor,
      border: decoration ??
          DecoratedInputBorder(
            child: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? margin_0),
              borderSide: BorderSide(
                color: appTextFieldOutlineColor,
                width: 1,
              ),
            ),
            shadow: BoxShadow(
              color: shadow == true ? Colors.transparent : Colors.grey[200]!,
              blurRadius: margin_2,
              spreadRadius: margin_2,
            ),
          ),
      focusedErrorBorder: decoration ??
          DecoratedInputBorder(
            child: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? margin_0),
              borderSide: BorderSide(
                color: appTextFieldOutlineColor,
              ),
            ),
            shadow: BoxShadow(
              color: shadow == true ? Colors.transparent : Colors.grey[200]!,
              blurRadius: margin_2,
              spreadRadius: margin_2,
            ),
          ),
      errorBorder: decoration ??
          DecoratedInputBorder(
              child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? margin_0),
                borderSide: BorderSide(
                  color: appTextFieldErrorOutlineColor,
                ),
              ),
              shadow: BoxShadow(
                color: shadow == true ? Colors.transparent : Colors.grey[200]!,
                blurRadius: margin_2,
                spreadRadius: margin_2,
              )),
      focusedBorder: decoration ??
          DecoratedInputBorder(
              child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? margin_0),
                borderSide: BorderSide(
                  color: appTextFieldOutlineColor,
                ),
              ),
              shadow: BoxShadow(
                color: shadow == true ? Colors.transparent : Colors.grey[200]!,
                blurRadius: margin_2,
                spreadRadius: margin_2,
              )),
      enabledBorder: decoration ??
          DecoratedInputBorder(
            child: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? margin_0),
              borderSide: BorderSide(
                color: appTextFieldOutlineColor,
              ),
            ),
            shadow: BoxShadow(
              color: shadow == true ? Colors.transparent : Colors.grey[200]!,
              blurRadius: margin_2,
              spreadRadius: margin_2,
            ),
          ));

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('validate', validate));
    properties.add(DiagnosticsProperty('hintStyle', hintStyle));
  }
}

class DecoratedInputBorder extends InputBorder {
  DecoratedInputBorder({
    required this.child,
    required this.shadow,
  }) : super(borderSide: child.borderSide);

  final InputBorder child;

  final BoxShadow? shadow;

  @override
  bool get isOutline => child.isOutline;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      child.getInnerPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      child.getOuterPath(rect, textDirection: textDirection);

  @override
  EdgeInsetsGeometry get dimensions => child.dimensions;

  @override
  InputBorder copyWith(
      {BorderSide? borderSide,
      InputBorder? child,
      BoxShadow? shadow,
      bool? isOutline}) {
    return DecoratedInputBorder(
      child: (child ?? this.child).copyWith(borderSide: borderSide),
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ShapeBorder scale(double t) {
    final scalledChild = child.scale(t);

    return DecoratedInputBorder(
      child: scalledChild is InputBorder ? scalledChild : child,
      shadow: BoxShadow.lerp(null, shadow, t),
    );
  }

  @override
  void paint(Canvas canvas, Rect rect,
      {double? gapStart,
      double gapExtent = 0.0,
      double gapPercentage = 0.0,
      TextDirection? textDirection}) {
    final clipPath = Path()
      ..addRect(const Rect.fromLTWH(-5000, -5000, 10000, 10000))
      ..addPath(getInnerPath(rect), Offset.zero)
      ..fillType = PathFillType.evenOdd;
    canvas.clipPath(clipPath);

    final Paint paint = shadow!.toPaint();
    final Rect bounds =
        rect.shift(shadow!.offset).inflate(shadow!.spreadRadius);

    canvas.drawPath(getOuterPath(bounds), paint);

    child.paint(canvas, rect,
        gapStart: gapStart,
        gapExtent: gapExtent,
        gapPercentage: gapPercentage,
        textDirection: textDirection);
  }

  // @override
  // bool operator == (Object other) {
  //   if (other.runtimeType != runtimeType) return false;
  //   return other is DecoratedInputBorder &&
  //       other.borderSide == borderSide &&
  //       other.child == child &&
  //       other.shadow == shadow;
  // }
  //
  // @override
  // int get hashCode => hashValues(borderSide, child, shadow);
}
