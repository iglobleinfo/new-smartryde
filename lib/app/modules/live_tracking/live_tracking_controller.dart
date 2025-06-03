import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ryde/app/modules/authentication/model/my_booking_response.dart';
import 'package:smart_ryde/app/modules/live_tracking/model/bus_detail_response.dart';
import 'package:smart_ryde/app/core/services/mqtt_service.dart';

import '../../../export.dart';

class LiveTrackingController extends GetxController {
  GoogleMapController? _mapController;
  final List<LatLng> polylineCoordinates = [];
  final RxSet<Polyline> polyLines = RxSet();
  Rx<LatLng> currentLatLng = Rx(LatLng(49.4543, 11.0746));
  MqttService mqttService = MqttService();
  StreamSubscription<TrackData>? _mqttStream;

  Marker? _liveTrackingMarker;
  BitmapDescriptor? _customBusIcon;

  RxSet<Marker> markers = RxSet<Marker>();

  late BookingList busData;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      busData = Get.arguments['busData'];
    }
    super.onInit();
  }

  Future<void> onMapInitialize(GoogleMapController controller) async {
    _mapController = controller;
    await _loadCustomMarker();
    await _fetchIotaSmartDeviceId();
  }

  Future<void> _loadCustomMarker() async {
    _customBusIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48, 48)),
      'assets/images/bus.webp', // your asset path
    );
  }

  Future<void> _fetchIotaSmartDeviceId() async {
    String busNumber = busData.busNumber;
    APIRepository.fetchBusDetail(busData.busNumber)
        .then((BusDetailResponse? busDetail) {
      if (busDetail?.data?.iotaSmartDeviceId != null) {
        startLocationTracking(busDetail!.data!.iotaSmartDeviceId!, busNumber);
      }
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  void startLocationTracking(
    String iotaSmartId,
    String busNumber,
  ) {
    // Fetch immediately
    mqttService.connect(iotaSmartId, busNumber);
    _mqttStream = mqttService.mqttMessages.listen((TrackData data) {
      double currentLat = data.lat!;
      double currentLng = data.lon!;
      currentLatLng.value = LatLng(currentLat, currentLng);
      // Update or add marker
      updateLiveMarker(currentLatLng.value);
    });
  }

  void updateLiveMarker(LatLng position) {
    // Animate the camera to the new location
    _mapController?.animateCamera(
      CameraUpdate.newLatLng(currentLatLng.value),
    );
    _liveTrackingMarker = Marker(
      markerId: MarkerId('liveTracking'),
      position: position,
      icon: _customBusIcon!,
    );
    markers.clear();
    markers.add(_liveTrackingMarker!);
  }

  @override
  void dispose() {
    mqttService.disconnectClient();
    _mqttStream?.cancel();
    super.dispose();
  }
}
