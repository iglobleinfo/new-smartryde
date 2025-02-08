import 'package:smart_ryde/export.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      controller.onWillPop();
      return Future.value(true);
    }, child: SafeArea(child: GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: _body(),
      );
    })));
  }

  Widget _body() {
    return Padding(
        padding:
            EdgeInsets.only(left: margin_22, right: margin_22, top: margin_16),
        child: Column(
          children: [
            TextFieldWidget(
                    hint: 'Search',
                    onChange: (val) {
                      controller.search(val);
                    },
                    inputAction: TextInputAction.search,
                    prefixIcon: Container(
                      child: AssetImageWidget(
                          imageUrl: iconSearch, imageHeight: 8, imageWidth: 8),
                      padding:
                          EdgeInsets.only(left: margin_15, right: margin_15),
                    ),
                    focusNode: controller.searchFocusNode,
                    textController: controller.searchController)
                .marginOnly(bottom: margin_25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MaterialButtonWidget(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            controller.onMyBookTap();
                            controller.hitMyBookAPI();
                            controller.searchController.clear();
                          },
                          buttonText: 'My Books',
                          textColor: controller.isMyBook.value
                              ? Colors.white
                              : Colors.grey.shade300,
                          buttonColor: controller.isMyBook.value
                              ? colorVioletM
                              : Colors.grey.shade400)
                      .marginOnly(right: margin_15),
                ),
                Expanded(
                  child: MaterialButtonWidget(
                          onPressed: () {
                            controller.hitMyBookAPI();
                            FocusManager.instance.primaryFocus?.unfocus();
                            controller.onLentBookTap();
                            controller.searchController.clear();
                          },
                          buttonText: 'Books I lent',
                          textColor: !controller.isMyBook.value
                              ? Colors.white
                              : Colors.grey.shade300,
                          buttonColor: !controller.isMyBook.value
                              ? colorVioletM
                              : Colors.grey.shade400)
                      .marginOnly(left: margin_15),
                ),
              ],
            ).marginOnly(bottom: margin_15),
            controller.homeLoader.value
                ? const Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                    backgroundColor: colorRussianViolet,
                    color: colorMistyRose,
                  )))
                : Expanded(
                    child: ListView.separated(
                        itemCount: controller.items.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: height_10),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getInkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.itemView,
                                        arguments: controller.items[index]);
                                  },
                                  child: Container(
                                    width: Get.width,
                                    height: height_200,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(radius_15),
                                        color: Colors.black),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(radius_15),
                                        child: cachedImage(
                                            controller.items[index].image,
                                            boxFit: BoxFit.cover)),
                                  ),
                                ).marginOnly(bottom: height_10),
                                TextView(
                                  text: controller.items[index].title ?? '',
                                  maxLine: 2,
                                  textStyle: textStyleTitle(context),
                                ).marginOnly(bottom: height_10),
                                ReadMoreTextWidget(
                                  controller.items[index].description ?? '',
                                  style: textStyleTitle(context)
                                      .copyWith(fontWeight: FontWeight.w400),
                                  moreStyle: const TextStyle(
                                      color: colorVioletM,
                                      fontWeight: FontWeight.bold),
                                  lessStyle: const TextStyle(
                                      color: colorVioletM,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
          ],
        ));
  }
}
