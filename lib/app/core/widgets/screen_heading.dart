import '../../../export.dart';

class ScreenHeading extends StatelessWidget {
  final title;
  final textStyle;
  final actionIcon;
  final onIconPress;
  final isDrawerIcon;
  final leadingIcon;
  final appBarTitleWidget;
  final actionWidget;
  final color;
  final centerTitle;
  final double? buttonRadius;

  ScreenHeading(
      {Key? key,
      this.title,
      this.actionIcon,
      this.isDrawerIcon,
      this.textStyle,
      this.leadingIcon,
      this.onIconPress,
      this.appBarTitleWidget,
      this.actionWidget,
      this.centerTitle,
      this.color,
      this.buttonRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: margin_10),
      decoration: BoxDecoration(color: color ?? Colors.white),
      child: CustomAppBar(
        bgColor: Colors.transparent,
        appBarTitleText: title,
        bottomPadding: margin_0,
        centerTitle: centerTitle,
        topPadding: margin_0,
        onTap: onIconPress,
        leadingIcon: leadingIcon,
        appBarTitleWidget: appBarTitleWidget,
        actionWidget: actionWidget,
        isDrawerIcon: isDrawerIcon,
      ),
    );
  }
}
