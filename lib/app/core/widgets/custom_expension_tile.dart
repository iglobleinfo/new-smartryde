import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:smart_ryde/export.dart';

customTile({
  required BuildContext context,
  String? question,
  String? answer,
}) =>
    ExpansionTile(
      title: TextView(
          text: question ?? '', textStyle: textStyleTitle(context), maxLine: 3),
      children: [
        HtmlWidget(
          answer!,
          // onLinkTap: (url, context, attributes, element) {},
        )
      ],
    );
