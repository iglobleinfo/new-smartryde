import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ryde/app/core/widgets/custom_flashbar.dart';
import 'package:smart_ryde/app/data/remote_service/network/api_provider.dart';
import 'package:smart_ryde/app/modules/home_booking/models/stop_model.dart';

class BusRouteController extends GetxController {
  BusRouteController({
    this.routeId,
    this.dNumber,
  });
  int? routeId;
  String? dNumber;
  RxBool isLoading = RxBool(false);
  RxList<StopList> stopList = RxList(<StopList>[]);

  @override
  void onInit() {
    if (routeId != null && dNumber != null) {
      fetchStopTracks();
    } else {
      debugPrint('Route ID or Department Number is null');
    }
    super.onInit();
  }

  Future<void> fetchStopTracks() async {
    isLoading.value = true;
    stopList.clear();
    update();
    APIRepository.getStopByRoute(
      routeId: routeId ?? 0,
      deptNo: dNumber ?? '',
    ).then((StopResponseModel? stopResponseModel) async {
      stopList.addAll(stopResponseModel?.data ?? []);
      isLoading.value = false;
      update();
    }).onError((error, stackTrace) {
      isLoading.value = false;
      update();
      toast(error);
    });
  }
}
