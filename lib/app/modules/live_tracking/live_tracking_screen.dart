import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ryde/app/modules/live_tracking/live_tracking_controller.dart';
import '../../../export.dart';

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
      body: Obx(
        () => GoogleMap(
          initialCameraPosition: CameraPosition(
            target: controller.currentLatLng.value,
            zoom: 5,
          ),
          onMapCreated: controller.onMapInitialize,
          polylines: controller.polyLines,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              controller.initializeLocationTracking();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<LiveTrackingController>(
      tag: tag,
    );
    super.dispose();
  }
}
