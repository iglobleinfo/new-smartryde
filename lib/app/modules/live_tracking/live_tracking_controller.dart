import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ryde/app/data/remote_service/network/mqtt_client.dart';

class LiveTrackingController extends GetxController {
  GoogleMapController? _mapController;
  Rx<LatLng> currentLatLng = Rx(LatLng(49.4543, 11.0746));
  double _currentLat = 49.4543;
  double _currentLong = 11.0746;
  final List<LatLng> polylineCoordinates = [];
  final RxSet<Polyline> polyLines = RxSet();
  MqttService mqttService = MqttService();

  @override
  void onInit() {
    initializeLocationTracking();
    mqttService.connect();
    super.onInit();
  }

  void onMapInitialize(GoogleMapController controller) {
    _mapController = controller;
  }

  void initializeLocationTracking() async {
    _currentLat += 1;
    _currentLong += 1;
    currentLatLng.value = LatLng(_currentLat, _currentLong);
    polylineCoordinates.add(currentLatLng.value);
    polyLines.clear();
    polyLines.add(
      Polyline(
        polylineId: PolylineId('tracking_line'),
        points: polylineCoordinates,
        width: 5,
        color: Colors.blue,
      ),
    );
    update();
    _mapController?.animateCamera(CameraUpdate.newLatLng(currentLatLng.value));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
