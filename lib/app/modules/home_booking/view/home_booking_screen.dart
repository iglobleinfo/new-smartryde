import 'package:smart_ryde/app/modules/home_booking/bottomsheets/destiny_bottomsheet.dart';
import 'package:smart_ryde/app/modules/home_booking/bottomsheets/region_bottomsheet.dart';
import 'package:smart_ryde/app/modules/home_booking/bottomsheets/stop_bottomsheet.dart';
import 'package:smart_ryde/app/modules/home_booking/controller/home_booking_controller.dart';
import 'package:smart_ryde/model/responseModal/bookmark_response_model.dart';
import '../../../../../../export.dart';

class HomeBookingScreen extends GetView<HomeBookingController> {
  final formGlobalKey = GlobalKey<FormState>();

  HomeBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeBookingController>(
      init: HomeBookingController(),
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: controller.pickUp1StopId != null
              ? MaterialButtonWidget(
                  minWidth: Get.width,
                  buttonText: keyNextStep.tr.toUpperCase(),
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.home2,
                      arguments: {
                        'matchId': '${controller.pickUp1StopId!}',
                        'pickupStop': controller.stop1Controller.text
                      },
                    );
                  },
                )
              : SizedBox(),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: pickUpForm(context: context),
              ),
              bookmarkListing(context),
            ],
          ),
        );
      },
    );
  }

  void showDeleteDialog(context, index) {
    Get.dialog(
      AlertDialog(
        title: Text(
          keySureRemove.tr,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
            },
            child: Text(
              keyNo.tr,
              style: TextStyle(color: Colors.blue),
            ),
          ),
          TextButton(
            onPressed: () {
              // Do something on confirm
              controller.hitBookmarkApi(context, index);
              Get.back();
            },
            child: Text(
              keyYes.tr,
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget bookmarkWidget(BuildContext context, index) {
    BookmarkList bookmarkData = controller.bookmarkList[index];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 6,
          bottom: 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showDeleteDialog(context, index);
                  },
                  child: Icon(
                    Icons.bookmark,
                    color: Colors.orangeAccent,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextView(
                        text: keyPickStop.tr,
                        textAlign: TextAlign.start,
                        maxLine: 2,
                        textStyle: textStyleLabelSmall(context).copyWith(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextView(
                        text: appLanguage == Language.en
                            ? bookmarkData.fromStopEnName ?? 'N/A'
                            : appLanguage == Language.sch
                                ? bookmarkData.fromStopSchName ?? '不适用'
                                : bookmarkData.fromStopChName ?? '不適用',
                        textAlign: TextAlign.start,
                        maxLine: 2,
                        textStyle: textStyleLabelSmall(context).copyWith(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Image.asset(
                      imageBusRoute,
                      color: primaryColor,
                      height: 35,
                    ),
                    SizedBox(
                      width: 150,
                      child: TextView(
                        text: keyDestinationStop.tr,
                        textAlign: TextAlign.start,
                        maxLine: 2,
                        textStyle: textStyleLabelSmall(context).copyWith(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextView(
                        textAlign: TextAlign.start,
                        text: appLanguage == Language.en
                            ? bookmarkData.toStopEnName ?? 'N/A'
                            : appLanguage == Language.sch
                                ? bookmarkData.toStopSchName ?? '不适用'
                                : bookmarkData.toStopChName ?? '不適用',
                        textStyle: textStyleLabelSmall(context).copyWith(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // TextView(
                    //   text: busData.deptTime.toString().split('.').first,
                    //   textStyle: textStyleLabelSmall(context).copyWith(
                    //     fontSize: 12,
                    //     color: busData.totalSeat == 0
                    //         ? Colors.white
                    //         : Colors.black26,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    // TextView(
                    //   text: 'Total Booked Seats:${busData.totalSeat}',
                    //   textStyle: textStyleLabelSmall(context).copyWith(
                    //     fontSize: 12,
                    //     color: busData.totalSeat == 0
                    //         ? Colors.white
                    //         : Colors.black26,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    // TextView(
                    //   text: 'Booking No:${bookmarkData.refrenceNumber}',
                    //   textStyle: textStyleLabelSmall(context).copyWith(
                    //     fontSize: 12,
                    //     color: bookmarkData.totalSeat == 0
                    //         ? Colors.white
                    //         : Colors.black26,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.busList, arguments: {
                      'fromId': int.parse(
                          controller.bookmarkList[index].fromStopId.toString()),
                      'toId': int.parse(
                          controller.bookmarkList[index].toStopId.toString()),
                      'fromName': appLanguage == Language.en
                          ? controller.bookmarkList[index].fromStopEnName ??
                              'N/A'
                          : appLanguage == Language.sch
                              ? controller
                                      .bookmarkList[index].fromStopSchName ??
                                  '不适用'
                              : controller.bookmarkList[index].fromStopChName ??
                                  '不適用',
                      'toName': appLanguage == Language.en
                          ? controller.bookmarkList[index].toStopEnName ?? 'N/A'
                          : appLanguage == Language.sch
                              ? controller.bookmarkList[index].toStopSchName ??
                                  '不适用'
                              : controller.bookmarkList[index].toStopChName ??
                                  '不適用',
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: primaryColor,
                    width: 160,
                    height: 30,
                    child: TextView(
                      text: keySearchBus.tr,
                      textStyle: textStyleLabelSmall(context).copyWith(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,)
          ],
        ),
      ),
    );
  }

  Widget pickUpForm({
    required BuildContext context,
  }) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 20),
            child: TextView(
              text: stringSelectPickup.tr,
              textStyle: textStyleLabelSmall(context).copyWith(
                fontSize: 19,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: margin_12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: margin_20,
                ),
                Container(
                  child: Form(
                    key: formGlobalKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        TextFieldWidget(
                          textColor: Colors.grey,
                          hint: keySelectYourDestiny.tr,
                          hintStyle: textStyleBodyMedium(context).copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 17),
                          readOnly: true,
                          onTap: () {
                            Get.bottomSheet(
                              DestinyBottomsheet(
                                list: controller.districtList,
                                selectedDistrict: (district) {
                                  controller.destiny1Controller.text = district;
                                  Get.back();
                                },
                                selectedDistrictId: (districtId) {
                                  controller.pickUp1DistrictId = districtId;
                                  controller.pickUp1StopId=null;
                                  controller.pickUp1RegionId = null;
                                  controller.region1Controller.clear();
                                  controller.stop1Controller.clear();
                                  controller.hitGetRegion();
                                  controller.update();
                                },
                              ),
                            );
                          },
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey,
                          ),
                          textController: controller.destiny1Controller,
                          shadow: true,
                          validate: (String? value) {
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        controller.pickUp1DistrictId != null
                            ? TextFieldWidget(
                                textColor: Colors.grey,
                                hint: keySelectYourArea.tr,
                                hintStyle: textStyleBodyMedium(context)
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontSize: 17),
                                readOnly: true,
                                onTap: () {
                                  Get.bottomSheet(
                                    RegionBottomsheet(
                                      list: controller.regionList,
                                      selectedRegion: (region) {
                                        controller.region1Controller.text =
                                            region;
                                        Get.back();
                                      },
                                      selectedRegionId: (regionId) {
                                        controller.pickUp1RegionId = regionId;
                                        controller.stop1Controller.clear();
                                        controller.pickUp1StopId = null;
                                        controller.hitGetStop();
                                        controller.update();
                                      },
                                    ),
                                  );
                                },
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.grey,
                                ),
                                textController: controller.region1Controller,
                                shadow: true,
                                validate: (String? value) {
                                  return null;
                                },
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
                        controller.pickUp1RegionId != null
                            ? TextFieldWidget(
                                textColor: Colors.grey,
                                hint: keySelectYourStop.tr,
                                hintStyle: textStyleBodyMedium(context)
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontSize: 17),
                                readOnly: true,
                                onTap: () {
                                  Get.bottomSheet(
                                    StopBottomsheet(
                                      list: controller.stopList,
                                      selectedStop: (stop) {
                                        controller.stop1Controller.text = stop;
                                        Get.back();
                                      },
                                      selectedStopId: (stopId) {
                                        controller.pickUp1StopId = stopId;
                                        controller.update();
                                      },
                                    ),
                                  );
                                },
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.grey,
                                ),
                                textController: controller.stop1Controller,
                                shadow: true,
                                validate: (String? value) {
                                  return null;
                                },
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ).marginOnly(bottom: margin_30),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bookmarkListing(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: context.height * 0.5,
      ),
      width: double.infinity,
      child: PreferenceManger().getStatusUserLogin() ?? false
          ? controller.bookmarkList.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 35,
                      color: primaryColor,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.menu_book_sharp),
                          SizedBox(
                            width: 10,
                          ),
                          TextView(
                            textAlign: TextAlign.start,
                            text: keyBookmark.tr,
                            textStyle: textStyleLabelSmall(context).copyWith(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: controller.bookmarkList.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return bookmarkWidget(context, index);
                          }),
                    ),
                  ],
                )
              : SizedBox()
          : SizedBox(),
    );
  }
}
