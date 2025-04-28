import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ryde/app/core/widgets/custom_flashbar.dart';
import 'package:smart_ryde/app/data/remote_service/network/api_provider.dart';
import 'package:smart_ryde/app/modules/home_booking/models/stop_model.dart';
import 'package:smart_ryde/main.dart';

class StopLocationController extends GetxController {
  GoogleMapController? _mapController;
  Rx<LatLng> currentLatLng = Rx(LatLng(49.4543, 11.0746));
  final List<LatLng> polylineCoordinates = [];
  final RxSet<Polyline> polyLines = RxSet();
  final RxSet<Marker> markers = RxSet(); // ✅ Marker set
  BitmapDescriptor? _customStopIcons;

  List<StopList> stopList = [];

  Future<void> onMapInitialize(GoogleMapController controller) async {
    _mapController = controller;
    await _loadCustomMarker();
    fetchStopTracks();
  }

  Future<void> _loadCustomMarker() async {
    _customStopIcons = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48, 48)),
      'assets/images/bus.webp', // your asset path
    );
  }

  Future<void> fetchStopTracks() async {
    stopList.clear();
    customLoader.show(Get.overlayContext);
    APIRepository.getStopByRoute(
      routeId: 14,
      deptNo: 'AN1S142225',
    ).then((StopResponseModel? stopResponseModel) async {
      stopList.addAll(stopResponseModel?.data ?? []);
      customLoader.hide();
      initializeLocationTracking();
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  void initializeLocationTracking() async {
    polyLines.clear();
    polylineCoordinates.clear();
    markers.clear(); // ✅ Clear old markers
    for (var stop in stopList) {
      final latLng = LatLng(stop.latitude!, stop.longitude!);
      polylineCoordinates.add(latLng);
      // ✅ Add marker for each stop
      markers.add(
        Marker(
          markerId: MarkerId('${stop.id}'),
          position: latLng,
          infoWindow: InfoWindow(title: stop.ename ?? 'Stop'),
          icon: _customStopIcons!,
        ),
      );
      markers.refresh();
    }

    debugPrint('polylineCoordinates ${polylineCoordinates.length}');
    polyLines.add(
      Polyline(
        polylineId: PolylineId('tracking_line'),
        points: polylineCoordinates,
        width: 5,
        color: Colors.blue,
      ),
    );
    polyLines.refresh();
    update();
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: polylineCoordinates.first,
          zoom: 15,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
