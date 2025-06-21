import 'package:smart_ryde/app/modules/bus/model/bus_response.dart';
import 'package:smart_ryde/app/modules/bus_route/bus_route_controller.dart';
import 'package:smart_ryde/app/modules/home_booking/models/stop_model.dart';
import 'package:smart_ryde/export.dart';

void showBusRouteSheet({
  required BuildContext context,
  required BusList busData,
  required String fromName,
  required String toName,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    showDragHandle: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.3,
      maxChildSize: 1,
      builder: (_, controller) => BusRouteBottomSheet(
        scrollController: controller,
        busData: busData,
        fromName: fromName,
        toName: toName,
      ),
    ),
  );
}

class BusRouteBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  final BusList busData;
  final String fromName;
  final String toName;

  const BusRouteBottomSheet({
    super.key,
    required this.scrollController,
    required this.busData,
    required this.fromName,
    required this.toName,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusRouteController>(
        init: BusRouteController(
          routeId: busData.routeId,
          dNumber: busData.deptNo,
        ),
        builder: (controller) {
          return Column(
            children: [
              SizedBox(height: 16),
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
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
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: TextView(
                              text: fromName,
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
                              text: toName,
                              textStyle: textStyleLabelSmall(context).copyWith(
                                fontSize: 12,
                                color: busData.totalSeat == 0
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.busLocation,
                              arguments: {
                                'routeId': busData.routeId,
                                'dNumber': busData.deptNo,
                              },
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextView(
                              text: 'Map',
                              textStyle: textStyleLabelSmall(context).copyWith(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.grey[700],
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: controller.stopList.length,
                  itemBuilder: (context, index) {
                    StopList stop = controller.stopList[index];
                    final isCurrent =
                        stop.ename == fromName || stop.ename == toName;
                    return ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.fiber_manual_record,
                              size: 12,
                              color: isCurrent ? Colors.blue : Colors.grey),
                          Container(
                            width: 2,
                            height: 30,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                      title: Text(
                        stop.ename ?? '',
                        style: TextStyle(
                          fontWeight:
                              isCurrent ? FontWeight.bold : FontWeight.normal,
                          color: isCurrent ? Colors.blue : Colors.black,
                        ),
                      ),
                      trailing: Text(stop.deptTime ?? '',
                          style: TextStyle(color: Colors.grey[700])),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
