import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ryde/app/modules/stop_locations/stop_location_controller.dart';
import '../../../export.dart';

class StopLocationPage extends StatefulWidget {
  const StopLocationPage({super.key});

  @override
  State<StopLocationPage> createState() => _StopLocationPageState();
}

class _StopLocationPageState extends State<StopLocationPage> {
  late StopLocationController controller;
  final String tag = UniqueKey().toString();

  @override
  void initState() {
    controller = Get.put<StopLocationController>(
      StopLocationController(),
      tag: tag,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          Set<Marker> markers = controller.markers;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {});
          });
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: controller.currentLatLng.value,
              zoom: 5,
            ),
            onMapCreated: controller.onMapInitialize,
            polylines: controller.polyLines,
            myLocationEnabled: true,
            markers: markers,
            myLocationButtonEnabled: true,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<StopLocationController>(
      tag: tag,
    );
    super.dispose();
  }
}
