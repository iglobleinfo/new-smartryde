import 'package:smart_ryde/app/core/widgets/annotated_region_widget.dart';
import 'package:smart_ryde/app/modules/bus/booking_confirm_screen.dart';
import 'package:smart_ryde/app/modules/bus/widgets/seat_picket_bottomsheet.dart';
import 'package:smart_ryde/export.dart';
import '../controller/book_seat_controller.dart';

class BusBookingScreen extends GetView<BookSeatController> {
  const BusBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegionWidget(
      statusBarColor: primaryColor,
      statusBarBrightness: Brightness.dark,
      child: SafeArea(
        bottom: false,
        child: GetBuilder<BookSeatController>(
          init: BookSeatController(),
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
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: Get.height - 170,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: keySelectNumberOfSeat.tr,
                            textStyle: textStyleLabelSmall(context).copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextView(
                            text: keyReserveSeats.tr,
                            textStyle: textStyleLabelSmall(context).copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          busList(context),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextView(
                                  text: keySelectedSeats.tr,
                                  textStyle:
                                      textStyleLabelSmall(context).copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextView(
                                  text: controller
                                          .seatPickerController.text.isEmpty
                                      ? '0'
                                      : controller.seatPickerController.text,
                                  textStyle:
                                      textStyleLabelSmall(context).copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextView(
                                  text: keyBookingAmount.tr,
                                  textStyle:
                                      textStyleLabelSmall(context).copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextView(
                                  text: 'HK\$0',
                                  textStyle:
                                      textStyleLabelSmall(context).copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              if (controller
                                  .seatPickerController.text.isEmpty) {
                                toast(keySelectNormalSeatsPrompt.tr);
                              } else {
                                controller.hitBookingApi(context);
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              color: primaryColor,
                              width: 100,
                              height: 40,
                              child: TextView(
                                text: keyBookNow.tr,
                                textStyle:
                                    textStyleLabelSmall(context).copyWith(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget busList(context) {
    return GetBuilder<BookSeatController>(
        init: BookSeatController(),
        builder: (controller) {
          return Expanded(
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   width: 0.5,
                    // ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  imageBus2,
                                  height: 55,
                                ),
                                TextView(
                                  text: controller.busData?.busNumber ?? '',
                                  textStyle:
                                      textStyleLabelSmall(context).copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: Get.width - 140,
                              color: Colors.grey.shade100,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    text: controller.fromName ?? '',
                                    textAlign: TextAlign.start,
                                    textStyle:
                                        textStyleLabelSmall(context).copyWith(
                                      fontSize: 13,
                                      color: Colors.black26,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Image.asset(
                                    imageBusRoute,
                                    color: primaryColor,
                                    height: 35,
                                  ),
                                  TextView(
                                    text: controller.toName ?? '',
                                    textAlign: TextAlign.start,
                                    textStyle:
                                        textStyleLabelSmall(context).copyWith(
                                      fontSize: 13,
                                      color: Colors.black26,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                TextFieldWidget(
                  textColor: Colors.grey,
                  hint: keySelectNumberOfSeat.tr,
                  hintStyle: textStyleBodyMedium(context).copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 17),
                  readOnly: true,
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Get.bottomSheet(
                      SeatPicker(
                        list: ['1', '2', '3', '4', '5'],
                        selectedSeat: (countryCode) {
                          controller.seatPickerController.text = countryCode;
                          controller.update();
                          Get.back();
                        },
                      ),
                    );
                  },
                  // contentPadding: EdgeInsets.all(margin_10),
                  textController: controller.seatPickerController,
                  shadow: true,
                  validate: (String? value) {
                    return null;
                  },
                ),
              ],
            ),
          );
        });
  }
}
