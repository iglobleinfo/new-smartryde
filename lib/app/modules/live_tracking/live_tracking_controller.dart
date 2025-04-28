import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ryde/app/modules/live_tracking/model/live_tracking_response.dart';

class LiveTrackingController extends GetxController {
  GoogleMapController? _mapController;
  final List<LatLng> polylineCoordinates = [];
  final RxSet<Polyline> polyLines = RxSet();
  Rx<LatLng> currentLatLng = Rx(LatLng(49.4543, 11.0746));

  Timer? _locationUpdateTimer;
  Marker? _liveTrackingMarker;
  BitmapDescriptor? _customBusIcon;

  RxSet<Marker> markers = RxSet<Marker>();

  Rx<LiveTrackingResponse?> liveTrackingResponse = Rx(null);

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> onMapInitialize(GoogleMapController controller) async {
    _mapController = controller;
    await _loadCustomMarker();
    startLocationTracking();
  }

  Future<void> _loadCustomMarker() async {
    _customBusIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48, 48)),
      'assets/images/bus.webp', // your asset path
    );
  }

  void startLocationTracking() {
    if (_locationUpdateTimer != null) return;

    // Fetch immediately
    initializeLocationTracking();

    // Then repeat every 15 seconds
    _locationUpdateTimer = Timer.periodic(Duration(seconds: 10), (_) {
      initializeLocationTracking();
    });
  }

  void stopLocationTracking() {
    _locationUpdateTimer?.cancel();
  }

  void initializeLocationTracking() async {
    try {
      Dio dio = Dio();
      dio.options.headers = {
        "token": "IOTASMART",
      };

      Response response = await dio
          .get('https://api.iotasmart.com/userdeviceservice/v1/device/4078');

      if (response.statusCode == 200) {
        LiveTrackingResponse liveTrackingResponse =
            LiveTrackingResponse.fromJson(response.data);
        this.liveTrackingResponse.value = liveTrackingResponse;
        double currentLat = liveTrackingResponse.lat!;
        double currentLng = liveTrackingResponse.lng!;
        currentLatLng.value = LatLng(currentLat, currentLng);
        // Animate the camera to the new location
        _mapController?.animateCamera(CameraUpdate.newLatLng(currentLatLng.value));
        // _mapController
        //     ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        //   target: currentLatLng.value,
        //   zoom: 18,
        // )));
        // Update or add marker
        updateLiveMarker(currentLatLng.value);
      }
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  void updateLiveMarker(LatLng position) {
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
    _locationUpdateTimer?.cancel();
    super.dispose();
  }
}
