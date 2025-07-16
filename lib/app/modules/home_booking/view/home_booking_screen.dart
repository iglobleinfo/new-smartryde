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
                  buttonText: 'Next Step'.toUpperCase(),
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
          body: Column(
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
              pickUpForm(context: context)
            ],
          ),
        );
      },
    );
  }

  Widget busDetail(BuildContext context, index) {
    BookmarkList bookmarkData = controller.bookmarkList[index];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.hitBookmarkApi(context, index);
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // TextView(
                        //   text: bookmarkData. ?? '',
                        //   textStyle: textStyleLabelSmall(context).copyWith(
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: TextView(
                            text: 'Pickup Stop',
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
                            text: bookmarkData.fromStopEnName ?? 'N/A',
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
                            text: 'Destination Stop',
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
                            text: bookmarkData.toStopEnName ?? 'N/A',
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
                          'fromId': int.parse(controller
                              .bookmarkList[index].fromStopId
                              .toString()),
                          'toId': int.parse(controller
                              .bookmarkList[index].toStopId
                              .toString()),
                          'fromName':
                              controller.bookmarkList[index].fromStopEnName,
                          'toName':
                              controller.bookmarkList[index].toStopEnName,
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        color: primaryColor,
                        width: 160,
                        height: 30,
                        child: TextView(
                          text: 'Search for suitable bus',
                          textStyle: textStyleLabelSmall(context).copyWith(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget pickUpForm({
    required BuildContext context,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: margin_12,
          ),
          child: Stack(
            children: [
              Column(
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
                                    controller.destiny1Controller.text =
                                        district;
                                    Get.back();
                                  },
                                  selectedDistrictId: (districtId) {
                                    controller.pickUp1DistrictId = districtId;
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
                                  hint: 'Select Your Stop',
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
                                          controller.stop1Controller.text =
                                              stop;
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
            ],
          ),
        ),
        PreferenceManger().getStatusUserLogin() ?? false
            ? controller.bookmarkList.isNotEmpty
                ? Column(
                    children: [
                      Container(
                          height: 40,
                          color: Colors.blue,
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
                                text: 'Bookmark',
                                textStyle:
                                    textStyleLabelSmall(context).copyWith(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                            itemCount: controller.bookmarkList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return busDetail(context, index);
                            }),
                      ),
                    ],
                  )
                : SizedBox()
            : SizedBox()
      ],
    );
  }
}
