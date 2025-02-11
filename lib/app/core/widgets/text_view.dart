import 'package:flutter/widgets.dart';

class TextView extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final int maxLine;

  const TextView({
    super.key,
    required this.text,
    required this.textStyle,
    this.maxLine = 15,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
