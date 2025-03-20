import 'package:smart_ryde/app/modules/home_booking/controller/home_booking_controller.dart';
import 'package:smart_ryde/app/modules/home_booking/view/home_booking_screen.dart';

import '../../../export.dart';
import '../../core/widgets/annotated_region_widget.dart';

class BookingConfirmScreen extends StatelessWidget {
  const BookingConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegionWidget(
      statusBarColor: primaryColor,
      statusBarBrightness: Brightness.dark,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: primaryColor,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextView(
                text: 'Ride Confirmed',
                textStyle: textStyleLabelSmall(context).copyWith(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextView(
                  text:
                      'Your Bus Will arrive at Hanley Villa. Please reach the stop 3 minutes before the schedule arrival time.',
                  textStyle: textStyleLabelSmall(context).copyWith(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.find<HomeBookingController>().pickUp1DistrictId = null;
                  Get.find<HomeBookingController>().destiny1Controller.clear();
                  Get.find<HomeBookingController>().region1Controller.clear();
                  Get.find<HomeBookingController>().stop1Controller.clear();
                  Get.find<HomeBookingController>().pickUp1RegionId = null;
                  Get.find<HomeBookingController>().pickUp1StopId = null;
                  Get.find<HomeBookingController>().update();
                  Get.until((Route route) => route.isFirst);
                },
                child: TextView(
                  text: 'GOT IT',
                  textStyle: textStyleLabelSmall(context).copyWith(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
