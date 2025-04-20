import 'package:smart_ryde/export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? appBarTitleText;
  final actionWidget;
  final bottomPadding;
  final topPadding;
  final Color? bgColor;
  final appBarTitleWidget;
  final leadingIcon;
  final bool? isDrawerIcon;
  final bool? isBackIcon;
  final bool? centerTitle;
  final Function? onTap;

  const CustomAppBar({
    super.key,
    this.appBarTitleText,
    this.onTap,
    this.actionWidget,
    this.bottomPadding,
    this.topPadding,
    this.isDrawerIcon = false,
    this.appBarTitleWidget,
    this.leadingIcon,
    this.isBackIcon = true,
    this.centerTitle = false,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      bottomOpacity: 0.0,
      leading: isBackIcon! ? _backIcon() : Container(),
      centerTitle: false,
      leadingWidth: 60,
      surfaceTintColor: Colors.transparent,
      title: appBarTitleWidget ??
          (appBarTitleText != "" || appBarTitleText != null
              ? TextView(
                  text: appBarTitleText ?? "",
                  textAlign: TextAlign.center,
                  textStyle: textStyleDisplayLarge(context).copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 22
                  ),
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                )),
      shadowColor: Colors.transparent,
      backgroundColor: bgColor ?? Colors.white,
      actions: actionWidget ?? [],
    );
  }

  _backIcon() {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        child: leadingIcon ??
            AssetImageWidget(
              imageUrl: (isDrawerIcon == true ? iconMenu : imageBack),
              imageWidth: isDrawerIcon == true ? height_65 : height_15,
              imageHeight: isDrawerIcon == true ? height_65 : height_20,
            ).paddingOnly(
              top: topPadding ?? margin_15,
              left: margin_15,
              bottom:
                  isDrawerIcon == false ? bottomPadding ?? margin_2 : margin_2,
            ),
        onTap: () {
          if (onTap == null) {
            Get.back(result: true);
          } else {
            onTap!();
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height_50);
}
