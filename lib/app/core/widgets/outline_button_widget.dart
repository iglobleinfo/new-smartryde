import 'package:smart_ryde/export.dart';

class OutlineButtonWidget extends StatelessWidget {
  const OutlineButtonWidget({
    super.key,
    this.outlineColor,
    this.backgroundColor,
    required this.text,
    this.textStyle,
    this.verticalPadding,
    this.horizontalPadding,
  });

  final Color? outlineColor;
  final Color? backgroundColor;
  final String text;
  final TextStyle? textStyle;
  final double? verticalPadding;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: null,
      style: ButtonStyle(
        side: WidgetStatePropertyAll(
          BorderSide(
            width: 2,
            color: outlineColor ?? Colors.blue,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? margin_12,
          horizontal: horizontalPadding ?? margin_20,
        ),
        child: Text(
          text,
          style: textStyle ?? textStyleBodySmall(context),
        ),
      ),
    );
  }
}
