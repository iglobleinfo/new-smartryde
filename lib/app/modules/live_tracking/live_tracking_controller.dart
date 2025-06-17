import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ryde/app/modules/authentication/model/my_booking_response.dart';
import 'package:smart_ryde/app/modules/live_tracking/model/bus_detail_response.dart';
import 'package:smart_ryde/app/core/services/mqtt_service.dart';
import 'package:smart_ryde/app/modules/live_tracking/model/hkglobal_data.dart';
import 'package:smart_ryde/app/modules/live_tracking/model/smart_ryde_data.dart';
import '../../../export.dart';

class LiveTrackingController extends GetxController {
  GoogleMapController? _mapController;
  final List<LatLng> polylineCoordinates = [];
  final RxSet<Polyline> polyLines = RxSet();
  Rx<LatLng> currentLatLng = Rx(LatLng(22.3193, 114.1694));
  MqttService mqttService = MqttService();
  // Stream for receiving MQTT messages
  StreamSubscription<TrackData>? _trackDataStream;
  StreamSubscription<SmartRydeData>? _smartRydeStream;

  Marker? _liveTrackingMarker;
  LatLng? _previousPosition;

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
      'assets/images/bus.webp',
    );
  }

  Future<void> _fetchIotaSmartDeviceId() async {
    String busNumber = 'YX2984';
    APIRepository.fetchBusDetail(busNumber)
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
    _trackDataStream = mqttService.hkStreamData.listen((TrackData data) {
      double currentLat = data.lat!;
      double currentLng = data.lon!;
      currentLatLng.value = LatLng(currentLat, currentLng);
      // Update or add marker
      moveMarkerSmoothly(currentLatLng.value);
    });
    _smartRydeStream = mqttService.sRStreamData.listen((SmartRydeData data) {
      double currentLat = data.lastGps!.lastgps!.latitude!;
      double currentLng = data.lastGps!.lastgps!.longitude!;
      currentLatLng.value = LatLng(currentLat, currentLng);
      // Update or add marker
      moveMarkerSmoothly(currentLatLng.value);
    });
  }

  void moveMarkerSmoothly(LatLng newPosition) {
    if (_previousPosition == null) {
      _previousPosition = newPosition;
      _updateMarker(newPosition);
      return;
    }

    const int steps = 60;
    const Duration stepDuration = Duration(milliseconds: 16);

    double latDiff = newPosition.latitude - _previousPosition!.latitude;
    double lngDiff = newPosition.longitude - _previousPosition!.longitude;

    int currentStep = 0;

    Timer.periodic(stepDuration, (timer) {
      if (currentStep >= steps) {
        timer.cancel();
        _previousPosition = newPosition;
        return;
      }

      double lat =
          _previousPosition!.latitude + (latDiff * (currentStep / steps));
      double lng =
          _previousPosition!.longitude + (lngDiff * (currentStep / steps));
      LatLng interpolated = LatLng(lat, lng);

      _updateMarker(interpolated);
      currentStep++;
    });
  }

  void _updateMarker(LatLng position) {
    final marker = Marker(
      markerId: MarkerId('liveTracking'),
      position: position,
      icon: _customBusIcon!,
      anchor: Offset(0.5, 0.5),
    );
    _liveTrackingMarker = marker;
    markers.removeWhere((m) => m.markerId == marker.markerId);
    markers.add(marker);
  }

  @override
  void dispose() {
    mqttService.disconnectClient();
    _trackDataStream?.cancel();
    _smartRydeStream?.cancel();
    super.dispose();
  }
}
