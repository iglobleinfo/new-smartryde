import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ryde/app/modules/authentication/model/my_booking_response.dart';
import 'package:smart_ryde/app/modules/live_tracking/model/bus_detail_response.dart';
import 'package:smart_ryde/app/core/services/mqtt_service.dart';
import 'package:smart_ryde/app/modules/live_tracking/model/hkglobal_data.dart';
import 'package:smart_ryde/app/modules/live_tracking/model/smart_ryde_data.dart';
import '../../../export.dart';

class LiveTrackingController extends GetxController
    with GetTickerProviderStateMixin {
  GoogleMapController? _mapController;
  final List<LatLng> polylineCoordinates = [];
  final RxSet<Polyline> polyLines = RxSet();
  Rx<LatLng> currentLatLng = Rx(LatLng(22.3193, 114.1694));
  MqttService mqttService = MqttService();
  // Stream for receiving MQTT messages
  StreamSubscription<TrackData>? _trackDataStream;
  StreamSubscription<SmartRydeData>? _smartRydeStream;

  BitmapDescriptor? _customBusIcon;

  RxSet<Marker> markers = RxSet<Marker>();

  late BookingList busData;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      busData = Get.arguments['busData'];
    }
    // Timer.periodic(const Duration(seconds: 2), (Timer? timer) {
    //   moveMarkerSmoothly(LatLng(currentLatLng.value.latitude + 0.001,
    //       currentLatLng.value.longitude + 0.001));
    // });
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
    String busNumber = busData.busNumber;
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

  Future<void> moveMarkerSmoothly(LatLng newPosition) async {
    debugPrint('NewPosition Value ${newPosition.toJson()}');
    final marker = Marker(
      markerId: MarkerId('liveTracking'),
      position: newPosition,
      icon: _customBusIcon!,
    );
    currentLatLng.value = newPosition;
    markers.add(marker);
    Future.delayed(const Duration(milliseconds: 500), () {
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: newPosition,
            zoom: 18,
          ),
        ),
      ); // ensure initial position is centered
    });
  }

  @override
  void dispose() {
    mqttService.disconnectClient();
    _trackDataStream?.cancel();
    _smartRydeStream?.cancel();
    super.dispose();
  }
}
