import 'package:smart_ryde/export.dart';

class ItemView extends GetView<ItemController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      controller.onWillPop();
      return Future.value(true);
    }, child: SafeArea(child: GetBuilder<ItemController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(appBarTitleText: controller.imageArg?.title ?? ''),
        body: _body(context),
      );
    })));
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: margin_20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            height: height_200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_15),
                color: Colors.black),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(radius_15),
                child: cachedImage(controller.imageArg?.image ?? '',
                    boxFit: BoxFit.cover)),
          ).marginOnly(bottom: height_10),
          ReadMoreTextWidget(
            controller.imageArg?.description ?? '',
            style: textStyleTitle(context).copyWith(fontWeight: FontWeight.w400),
            moreStyle: textStyleTitle(context).copyWith(color: colorAppColor),
            lessStyle: textStyleTitle(context),
          ),
        ],
      ),
    );
  }
}
