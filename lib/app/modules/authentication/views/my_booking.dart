import 'package:intl/intl.dart';
import 'package:smart_ryde/app/core/values/route_arguments.dart';
import 'package:smart_ryde/app/core/widgets/annotated_region_widget.dart';
import 'package:smart_ryde/app/modules/authentication/model/my_booking_response.dart';
import 'package:smart_ryde/app/modules/bus/model/bus_response.dart';
import 'package:smart_ryde/export.dart';

import '../controllers/my_booking_controller.dart';

class MyBookingListScreen extends GetView<MyBookingController> {
  const MyBookingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegionWidget(
      statusBarColor: primaryColor,
      statusBarBrightness: Brightness.dark,
      child: SafeArea(
        child: GetBuilder<MyBookingController>(
          init: MyBookingController(),
          builder: (controller) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: CustomAppBar(
                appBarTitleText: 'Booking',
                textColor: primaryColor,
                actionWidget: [
                 getInkWell(
                          onTap: () {
                            controller.hitDeleteAllCancelBooking();
                          },
                          child: Text(
                            'Delete All',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ).paddingAll(12),
                        ),
                ],
                leadingIcon: getInkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.grey,
                    size: 26,
                  ).paddingAll(12),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 10.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: 'Select a trip that suits your preference',
                          textStyle: textStyleLabelSmall(context).copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DefaultTabController(
                          length: 3,
                          child: Column(
                            children: [
                              Container(
                                color: Colors.white,
                                child: TabBar(
                                  labelColor: primaryColor,
                                  unselectedLabelColor: primaryColor,
                                  indicatorColor: primaryColor,
                                  labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  unselectedLabelStyle: TextStyle(fontSize: 16),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                        width: 2, color: primaryColor),
                                    insets: EdgeInsets.zero,
                                  ),
                                  tabs: [
                                    Tab(
                                      text: 'Current',
                                    ),
                                    Tab(
                                      text: 'Cancelled',
                                    ),
                                    Tab(
                                      text: 'Past',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height - 250,
                                child: TabBarView(
                                  children: [
                                    currentBookingList(context),
                                    cancelledBookingList(context),
                                    pastBookingList(context),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget currentBookingList(context) {
    return GetBuilder<MyBookingController>(
        init: MyBookingController(),
        builder: (controller) {
          controller.index = 0;
          return controller.isLoader
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                    backgroundColor: Colors.white,
                  ),
                )
              : controller.currentBookingList.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AssetImageWidget(
                          imageUrl: imageBus2,
                          imageHeight: 105,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: TextView(
                            text:
                                'No Bus available right now. Please try again later!',
                            textStyle: textStyleLabelSmall(context).copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: controller.currentBookingList.length,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 20),
                      itemBuilder: (BuildContext context, int index) {
                        BookingList busData =
                            controller.currentBookingList[index];
                        return Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: busData.totalSeat == 0
                                    ? Colors.grey
                                    : Colors.white,
                                // border: Border.all(
                                //   width: 0.5,
                                // ),
                                // borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AssetImageWidget(
                                              imageUrl: imageBus2,
                                              imageHeight: 55,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextView(
                                              text: busData.busNumber ?? '',
                                              textStyle:
                                                  textStyleLabelSmall(context)
                                                      .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: TextView(
                                                text: busData.fromEng ??
                                                    '' /*busData.enRouteName!
                                                    .split(')')
                                                    .first
                                                    .split('(')
                                                    .last*/
                                                ,
                                                textAlign: TextAlign.start,
                                                maxLine: 2,
                                                textStyle:
                                                    textStyleLabelSmall(context)
                                                        .copyWith(
                                                  fontSize: 12,
                                                  color: busData.totalSeat == 0
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              imageBusRoute,
                                              color: busData.totalSeat == 0
                                                  ? Colors.white
                                                  : primaryColor,
                                              height: 35,
                                            ),
                                            SizedBox(
                                              width: 150,
                                              child: TextView(
                                                textAlign: TextAlign.start,
                                                text: busData.toEng ??
                                                    '' /*busData.enRouteName!
                                                    .split('to')
                                                    .last
                                                    .split('(')
                                                    .last
                                                    .replaceAll(')', '')*/
                                                ,
                                                textStyle:
                                                    textStyleLabelSmall(context)
                                                        .copyWith(
                                                  fontSize: 12,
                                                  color: busData.totalSeat == 0
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            TextView(
                                              text: busData.deptTime
                                                  .toString()
                                                  .split('.')
                                                  .first,
                                              textStyle:
                                                  textStyleLabelSmall(context)
                                                      .copyWith(
                                                fontSize: 12,
                                                color: busData.totalSeat == 0
                                                    ? Colors.white
                                                    : Colors.black26,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextView(
                                              text:
                                                  'Total Booked Seats:${busData.totalSeat}',
                                              textStyle:
                                                  textStyleLabelSmall(context)
                                                      .copyWith(
                                                fontSize: 12,
                                                color: busData.totalSeat == 0
                                                    ? Colors.white
                                                    : Colors.black26,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextView(
                                              text:
                                                  'Booking No:${busData.refrenceNumber}',
                                              textStyle:
                                                  textStyleLabelSmall(context)
                                                      .copyWith(
                                                fontSize: 12,
                                                color: busData.totalSeat == 0
                                                    ? Colors.white
                                                    : Colors.black26,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      AppRoutes.liveTracking,
                                                      arguments: {
                                                        'busData': busData
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    color: primaryColor,
                                                    width: 130,
                                                    height: 30,
                                                    child: TextView(
                                                      text: 'Track The Bus',
                                                      textStyle:
                                                          textStyleLabelSmall(
                                                                  context)
                                                              .copyWith(
                                                        fontSize: 13,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.hitCancelBooking(
                                                      busData.ticketId
                                                          .toString(),
                                                    );
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    color: primaryColor,
                                                    width: 120,
                                                    height: 30,
                                                    child: TextView(
                                                      text: 'Cancel Booking',
                                                      textStyle:
                                                          textStyleLabelSmall(
                                                                  context)
                                                              .copyWith(
                                                        fontSize: 13,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 0.2,
                              color: Colors.grey,
                            )
                          ],
                        );
                      },
                    );
        });
  }

  Widget cancelledBookingList(context) {
    return GetBuilder<MyBookingController>(
        init: MyBookingController(),
        builder: (controller) {
          controller.index = 1;
          return controller.isLoader
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                    backgroundColor: Colors.white,
                  ),
                )
              : controller.cancelledBookingList.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AssetImageWidget(
                          imageUrl: imageBus2,
                          imageHeight: 105,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: TextView(
                            text:
                                'No Bus available right now. Please try again later!',
                            textStyle: textStyleLabelSmall(context).copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: controller.cancelledBookingList.length,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 20),
                      itemBuilder: (BuildContext context, int index) {
                        BookingList busData =
                            controller.cancelledBookingList[index];
                        return Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: busData.totalSeat == 0
                                    ? Colors.grey
                                    : Colors.white,
                                // border: Border.all(
                                //   width: 0.5,
                                // ),
                                // borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AssetImageWidget(
                                              imageUrl: imageBus2,
                                              imageHeight: 55,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextView(
                                              text: busData.busNumber ?? '',
                                              textStyle:
                                                  textStyleLabelSmall(context)
                                                      .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            busData.totalSeat != 0
                                                ? SizedBox(
                                                    height: 40,
                                                  )
                                                : GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      color: primaryColor,
                                                      width: 120,
                                                      height: 40,
                                                      child: TextView(
                                                        text:
                                                            'Sorry, The Bus Is Full',
                                                        textStyle:
                                                            textStyleLabelSmall(
                                                                    context)
                                                                .copyWith(
                                                          fontSize: 12,
                                                          letterSpacing: 0,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: TextView(
                                                text: busData.fromEng ??
                                                    '' /*busData.enRouteName!
                                                    .split(')')
                                                    .first
                                                    .split('(')
                                                    .last*/
                                                ,
                                                textAlign: TextAlign.start,
                                                maxLine: 2,
                                                textStyle:
                                                    textStyleLabelSmall(context)
                                                        .copyWith(
                                                  fontSize: 12,
                                                  color: busData.totalSeat == 0
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              imageBusRoute,
                                              color: busData.totalSeat == 0
                                                  ? Colors.white
                                                  : primaryColor,
                                              height: 35,
                                            ),
                                            SizedBox(
                                              width: 150,
                                              child: TextView(
                                                textAlign: TextAlign.start,
                                                text: busData.toEng ??
                                                    '' /*busData.enRouteName!
                                                    .split('to')
                                                    .last
                                                    .split('(')
                                                    .last
                                                    .replaceAll(')', '')*/
                                                ,
                                                textStyle:
                                                    textStyleLabelSmall(context)
                                                        .copyWith(
                                                  fontSize: 12,
                                                  color: busData.totalSeat == 0
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            TextView(
                                              text: busData.deptTime
                                                  .toString()
                                                  .split('.')
                                                  .first,
                                              textStyle:
                                                  textStyleLabelSmall(context)
                                                      .copyWith(
                                                fontSize: 12,
                                                color: busData.totalSeat == 0
                                                    ? Colors.white
                                                    : Colors.black26,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextView(
                                              text:
                                                  'Total Booked Seats:${busData.totalSeat}',
                                              textStyle:
                                                  textStyleLabelSmall(context)
                                                      .copyWith(
                                                fontSize: 12,
                                                color: busData.totalSeat == 0
                                                    ? Colors.white
                                                    : Colors.black26,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextView(
                                              text:
                                                  'Booking No:${busData.refrenceNumber}',
                                              textStyle:
                                                  textStyleLabelSmall(context)
                                                      .copyWith(
                                                fontSize: 12,
                                                color: busData.totalSeat == 0
                                                    ? Colors.white
                                                    : Colors.black26,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                busData.totalSeat == 0
                                                    ? SizedBox()
                                                    : GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          color: Colors.grey,
                                                          width: 120,
                                                          height: 30,
                                                          child: TextView(
                                                            text: 'Cancelled',
                                                            textStyle:
                                                                textStyleLabelSmall(
                                                                        context)
                                                                    .copyWith(
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 0.2,
                              color: Colors.grey,
                            )
                          ],
                        );
                      },
                    );
        });
  }

  Widget pastBookingList(context) {
    return GetBuilder<MyBookingController>(
        init: MyBookingController(),
        builder: (controller) {
          controller.index=2;
          return controller.isLoader
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                    backgroundColor: Colors.white,
                  ),
                )
              : controller.pastBookingList.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AssetImageWidget(
                          imageUrl: imageBus2,
                          imageHeight: 105,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: TextView(
                            text:
                                'No Bus available right now. Please try again later!',
                            textStyle: textStyleLabelSmall(context).copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: controller.pastBookingList.length,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 20),
                      itemBuilder: (BuildContext context, int index) {
                        BookingList busData = controller.pastBookingList[index];
                        return Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: busData.totalSeat == 0
                                    ? Colors.grey
                                    : Colors.white,
                                // border: Border.all(
                                //   width: 0.5,
                                // ),
                                // borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AssetImageWidget(
                                              imageUrl: imageBus2,
                                              imageHeight: 55,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextView(
                                              text: busData.busNumber ?? '',
                                              textStyle:
                                                  textStyleLabelSmall(context)
                                                      .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            busData.totalSeat != 0
                                                ? SizedBox(
                                                    height: 40,
                                                  )
                                                : GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      color: primaryColor,
                                                      width: 120,
                                                      height: 40,
                                                      child: TextView(
                                                        text:
                                                            'Sorry, The Bus Is Full',
                                                        textStyle:
                                                            textStyleLabelSmall(
                                                                    context)
                                                                .copyWith(
                                                          fontSize: 12,
                                                          letterSpacing: 0,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: TextView(
                                                text: busData.fromEng ??
                                                    '' /*busData.enRouteName!
                                                    .split(')')
                                                    .first
                                                    .split('(')
                                                    .last*/
                                                ,
                                                textAlign: TextAlign.start,
                                                maxLine: 2,
                                                textStyle:
                                                    textStyleLabelSmall(context)
                                                        .copyWith(
                                                  fontSize: 12,
                                                  color: busData.totalSeat == 0
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              imageBusRoute,
                                              color: busData.totalSeat == 0
                                                  ? Colors.white
                                                  : primaryColor,
                                              height: 35,
                                            ),
                                            SizedBox(
                                              width: 150,
                                              child: TextView(
                                                textAlign: TextAlign.start,
                                                text: busData.toEng ??
                                                    '' /*busData.enRouteName!
                                                    .split('to')
                                                    .last
                                                    .split('(')
                                                    .last
                                                    .replaceAll(')', '')*/
                                                ,
                                                textStyle:
                                                    textStyleLabelSmall(context)
                                                        .copyWith(
                                                  fontSize: 12,
                                                  color: busData.totalSeat == 0
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            TextView(
                                              text: busData.deptTime
                                                  .toString()
                                                  .split('.')
                                                  .first,
                                              textStyle:
                                                  textStyleLabelSmall(context)
                                                      .copyWith(
                                                fontSize: 12,
                                                color: busData.totalSeat == 0
                                                    ? Colors.white
                                                    : Colors.black26,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextView(
                                              text:
                                                  'Total Booked Seats:${busData.totalSeat}',
                                              textStyle:
                                                  textStyleLabelSmall(context)
                                                      .copyWith(
                                                fontSize: 12,
                                                color: busData.totalSeat == 0
                                                    ? Colors.white
                                                    : Colors.black26,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextView(
                                              text:
                                                  'Booking No:${busData.refrenceNumber}',
                                              textStyle:
                                                  textStyleLabelSmall(context)
                                                      .copyWith(
                                                fontSize: 12,
                                                color: busData.totalSeat == 0
                                                    ? Colors.white
                                                    : Colors.black26,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                busData.canceled ?? false
                                                    ? GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          color: primaryColor,
                                                          width: 120,
                                                          height: 30,
                                                          child: TextView(
                                                            text: 'Cancelled',
                                                            textStyle:
                                                                textStyleLabelSmall(
                                                                        context)
                                                                    .copyWith(
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 0.2,
                              color: Colors.grey,
                            )
                          ],
                        );
                      },
                    );
        });
  }
}
