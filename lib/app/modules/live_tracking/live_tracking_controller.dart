import 'dart:math' as math;
import 'dart:ui' as ui;
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
  StreamSubscription<TrackData>? _trackDataStream;
  StreamSubscription<SmartRydeData>? _smartRydeStream;
  RxSet<Marker> markers = RxSet<Marker>();
  late BookingList busData;
  LatLng? _previousLatLng;

  // *******************************************
  // *******************************************
  final List<LatLng> _testCoordinates = [
    LatLng(22.3193, 114.1694),
    LatLng(22.3200, 114.1700),
    LatLng(22.3210, 114.1710),
    LatLng(22.3220, 114.1720),
    LatLng(22.3230, 114.1730),
  ];
  int _testIndex = 0;
  Timer? _testTimer;
  bool enableTestMode = false; // set to false for real tracking

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      busData = Get.arguments['busData'];
    }
    if (enableTestMode) {
      _startTestSimulation();
    }
    super.onInit();
  }

  void _startTestSimulation() {
    _testTimer?.cancel();
    _testTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_testIndex >= _testCoordinates.length) {
        _testIndex = 0;
      }
      final simulatedPosition = _testCoordinates[_testIndex++];
      moveMarkerSmoothly(simulatedPosition);
    });
  }

  Future<void> onMapInitialize(GoogleMapController controller) async {
    _mapController = controller;
    await _fetchIotaSmartDeviceId();
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

  void startLocationTracking(String iotaSmartId, String busNumber) {
    mqttService.connect(iotaSmartId, busNumber);
    _trackDataStream = mqttService.hkStreamData.listen((TrackData data) {
      double currentLat = data.lat!;
      double currentLng = data.lon!;
      currentLatLng.value = LatLng(currentLat, currentLng);
      moveMarkerSmoothly(currentLatLng.value);
    });
    _smartRydeStream = mqttService.sRStreamData.listen((SmartRydeData data) {
      double currentLat = data.lastGps!.lastgps!.latitude!;
      double currentLng = data.lastGps!.lastgps!.longitude!;
      currentLatLng.value = LatLng(currentLat, currentLng);
      moveMarkerSmoothly(currentLatLng.value);
    });
  }

  Future<void> moveMarkerSmoothly(LatLng newPosition) async {
    debugPrint('NewPosition Value ${newPosition.toJson()}');

    double bearing = 0.0;
    if (_previousLatLng != null) {
      bearing = _calculateBearing(_previousLatLng!, newPosition);
    }
    _previousLatLng = newPosition;

    final rotatedIcon = await _getRotatedBusIcon(bearing);

    final marker = Marker(
      markerId: MarkerId('liveTracking'),
      position: newPosition,
      icon: rotatedIcon,
      anchor: Offset(0.5, 0.5),
    );

    currentLatLng.value = newPosition;
    markers.removeWhere((m) => m.markerId == MarkerId('liveTracking'));
    markers.add(marker);

    Future.delayed(const Duration(seconds: 3), () {
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: newPosition,
            zoom: 17,
          ),
        ),
      );
    });
  }

  double _calculateBearing(LatLng start, LatLng end) {
    final lat1 = start.latitude * math.pi / 180.0;
    final lon1 = start.longitude * math.pi / 180.0;
    final lat2 = end.latitude * math.pi / 180.0;
    final lon2 = end.longitude * math.pi / 180.0;

    final dLon = lon2 - lon1;
    final y = math.sin(dLon) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLon);
    final bearing = math.atan2(y, x);

    return (bearing * 180.0 / math.pi + 360.0) % 360.0;
  }

  Future<BitmapDescriptor> _getRotatedBusIcon(double bearing) async {
    final ByteData data =
        await rootBundle.load('assets/images/icons8-full-stop-90.png');

    // Decode original high-res image (e.g. 64x64)
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    final image = frame.image;

    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    // Desired output size on map (small visually)
    const double targetSize = 30.0;
    final size = Size(targetSize, targetSize);

    // Scale down inside canvas to keep icon small
    final scaleX = targetSize / image.width;
    final scaleY = targetSize / image.height;

    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate((bearing - 90) * math.pi / 180);
    canvas.scale(scaleX, scaleY); // scale down image
    canvas.translate(-image.width / 2, -image.height / 2);
    canvas.drawImage(image, Offset.zero, Paint());

    final rotatedImage = await pictureRecorder.endRecording().toImage(
          size.width.toInt(),
          size.height.toInt(),
        );

    final pngBytes =
        await rotatedImage.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.bytes(pngBytes!.buffer.asUint8List());
  }

  @override
  void dispose() {
    mqttService.disconnectClient();
    _trackDataStream?.cancel();
    _smartRydeStream?.cancel();
    _testTimer?.cancel(); // clean up test timer
    super.dispose();
  }
}
