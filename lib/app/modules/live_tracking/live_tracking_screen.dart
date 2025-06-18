import 'package:animated_marker/animated_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ryde/app/modules/live_tracking/live_tracking_controller.dart';
import '../../../export.dart';
import '../authentication/model/my_booking_response.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  late LiveTrackingController controller;
  final String tag = UniqueKey().toString();

  @override
  void initState() {
    controller = Get.put<LiveTrackingController>(
      LiveTrackingController(),
      tag: tag,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitleText: 'Live Tracking',
        leadingIcon: getInkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: Colors.grey,
            size: 26,
          ),
        ),
      ),
      body: Obx(
        () => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AnimatedMarker(
              staticMarkers: controller.markers,
              animatedMarkers: controller.markers,
              duration: const Duration(seconds: 1),
              fps: 30,
              curve: Curves.easeOut,
              builder: (context, animatedMarkers) {
                return GoogleMap(
                  key: ValueKey('GoogleMap'),
                  onMapCreated: controller.onMapInitialize,
                  initialCameraPosition: CameraPosition(
                    target: controller.currentLatLng.value,
                    zoom: 18,
                  ),
                  markers: animatedMarkers,
                );
              },
            ),
            busDetail(context),
          ],
        ),
      ),
    );
  }

  Widget busDetail(BuildContext context) {
    BookingList busData = controller.busData;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: busData.totalSeat == 0 ? Colors.grey : Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        textStyle: textStyleLabelSmall(context).copyWith(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextView(
                          text: busData.fromEng,
                          textAlign: TextAlign.start,
                          maxLine: 2,
                          textStyle: textStyleLabelSmall(context).copyWith(
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
                          text: busData.toEng,
                          textStyle: textStyleLabelSmall(context).copyWith(
                            fontSize: 12,
                            color: busData.totalSeat == 0
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      TextView(
                        text: busData.deptTime.toString().split('.').first,
                        textStyle: textStyleLabelSmall(context).copyWith(
                          fontSize: 12,
                          color: busData.totalSeat == 0
                              ? Colors.white
                              : Colors.black26,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextView(
                        text: 'Total Booked Seats:${busData.totalSeat}',
                        textStyle: textStyleLabelSmall(context).copyWith(
                          fontSize: 12,
                          color: busData.totalSeat == 0
                              ? Colors.white
                              : Colors.black26,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextView(
                        text: 'Booking No:${busData.refrenceNumber}',
                        textStyle: textStyleLabelSmall(context).copyWith(
                          fontSize: 12,
                          color: busData.totalSeat == 0
                              ? Colors.white
                              : Colors.black26,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    Get.delete<LiveTrackingController>(
      tag: tag,
    );
    super.dispose();
  }
}
