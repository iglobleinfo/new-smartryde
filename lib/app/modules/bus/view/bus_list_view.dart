import 'package:intl/intl.dart';
import 'package:smart_ryde/app/core/widgets/annotated_region_widget.dart';
import 'package:smart_ryde/app/modules/bus/model/bus_response.dart';
import 'package:smart_ryde/export.dart';

import '../controller/bus_controller.dart';

class BusListScreen extends GetView<BusController> {
  const BusListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegionWidget(
      statusBarColor: primaryColor,
      statusBarBrightness: Brightness.dark,
      child: SafeArea(
        child: GetBuilder<BusController>(
          init: BusController(),
          builder: (controller) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: CustomAppBar(
                // appBarTitleText: 'SmartRyde',
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
                        SizedBox(
                          height: 30,
                          child: ListView.builder(
                            scrollDirection:
                                Axis.horizontal, // Horizontal scroll direction
                            itemCount: controller.dateList.length,
                            itemBuilder: (context, index) {
                              String chipLabel =
                                  controller.dateList[index]['date'];
                              bool isSelected = controller.selectedDate ==
                                  chipLabel; // Check if this date is selected

                              return GestureDetector(
                                onTap: () {
                                  // Set the selected date, or deselect if tapped again
                                  controller.selectedDate =
                                      (isSelected ? null : chipLabel)!;
                                  controller.busList.clear();
                                  controller.hitGetBusList();
                                  controller.update();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: 8.0), // Space between chips
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      width: 0.4,
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  ),
                                  child: Text(
                                    DateFormat('dd MMMM')
                                        .format(DateTime.parse(chipLabel)),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  busList(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget busList(context) {
    return GetBuilder<BusController>(
        init: BusController(),
        builder: (controller) {
          return Expanded(
            child: controller.isLoader
                ? Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      backgroundColor: Colors.white,
                    ),
                  )
                : controller.busList.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AssetImageWidget(
                            imageUrl:imageBus2,
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
                        itemCount: controller.busList.length,
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 20),
                        itemBuilder: (BuildContext context, int index) {
                          BusList busData = controller.busList[index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                imageUrl:imageBus2,
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
                                                  text:controller.fromName??'' /*busData.enRouteName!
                                                      .split(')')
                                                      .first
                                                      .split('(')
                                                      .last*/,
                                                  textAlign: TextAlign.start,
                                                  maxLine: 2,
                                                  textStyle:
                                                      textStyleLabelSmall(
                                                              context)
                                                          .copyWith(
                                                    fontSize: 12,
                                                    color:
                                                        busData.totalSeat == 0
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
                                                  text: controller.toName??''/*busData.enRouteName!
                                                      .split('to')
                                                      .last
                                                      .split('(')
                                                      .last
                                                      .replaceAll(')', '')*/,
                                                  textStyle:
                                                      textStyleLabelSmall(
                                                              context)
                                                          .copyWith(
                                                    fontSize: 12,
                                                    color:
                                                        busData.totalSeat == 0
                                                            ? Colors.white
                                                            : Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              TextView(
                                                text: busData.deptTime
                                                    .toString()
                                                    .split(' ')
                                                    .last
                                                    .split('.')
                                                    .first
                                                    .replaceAll(':00', ''),
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
                                              TextView(
                                                text: 'Schedule Time',
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
                                                height: 5,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                color: primaryColor,
                                                width: 80,
                                                height: 30,
                                                child: TextView(
                                                  text:
                                                      'ETA:${busData.deptTime.toString().split(' ').last.split('.').first.replaceAll(':00', '')}',
                                                  textStyle:
                                                      textStyleLabelSmall(
                                                              context)
                                                          .copyWith(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              busData.totalSeat == 0
                                                  ? SizedBox()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            AppRoutes
                                                                .busBooking,
                                                            arguments: {
                                                              'busData':
                                                                  busData,
                                                              'fromId':
                                                                  controller
                                                                      .fromId,
                                                              'toId': controller
                                                                  .toId,
                                                              'fromName': controller.fromName,
                                                              'toName': controller.toName,
                                                            });
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: primaryColor,
                                                        width: 100,
                                                        height: 30,
                                                        child: TextView(
                                                          text: 'Book Now',
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
                      ),
          );
        });
  }
}
