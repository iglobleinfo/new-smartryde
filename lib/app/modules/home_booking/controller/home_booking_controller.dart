import 'package:smart_ryde/app/modules/home_booking/models/district_model.dart';
import 'package:smart_ryde/export.dart';

import '../../../core/utils/validators.dart';
import '../models/region_model.dart';
import '../models/stop_model.dart';

class HomeBookingController extends GetxController {
  late TextEditingController destiny1Controller = TextEditingController();
  late TextEditingController destiny2Controller = TextEditingController();
  late TextEditingController region1Controller = TextEditingController();
  late TextEditingController region2Controller = TextEditingController();
  late TextEditingController stop1Controller = TextEditingController();
  late TextEditingController stop2Controller = TextEditingController();

  int? pickUp1DistrictId;
  int? pickUp1RegionId;
  int? pickUp1StopId;

  DistrictResponseModel? districtResponseModel;
  RegionResponseModel? regionResponseModel;
  StopResponseModel? stopResponseModel;
  List<DistrictList> districtList = [];
  List<DistrictList> districtList2 = [];
  List<RegionList> regionList = [];
  List<RegionList> regionList2 = [];
  List<StopList> stopList = [];
  List<StopList> stopList2 = [];

  @override
  void onInit() {
    // destiny1Controller.text = 'Select Your Destiny';
    destiny2Controller.text = 'Select Your Destiny';
    region1Controller.text = 'Select Your Area';
    region2Controller.text = 'Select Your Area';
    stop1Controller.text = 'Select Your Stop';
    stop2Controller.text = 'Select Your Stop';
    customLoader = CustomLoader();

    super.onInit();
  }

  @override
  void onClose() {
    customLoader.hide();
    super.onClose();
  }

  @override
  void onReady() {
    hitGetDistrict();
    update();
  }

  Future<void> hitGetDistrict() async {
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.getDistrictApi().then((DistrictResponseModel? value) async {
      districtResponseModel = value;
      // districtList.addAll(districtResponseModel?.data ?? []);
      districtList2.addAll(districtResponseModel?.data ?? []);
      if (districtList2.isNotEmpty) {
        districtList.add(districtList2[0]);
        districtList.add(districtList2[1]);
        districtList[0].nameEng = 'Delhi';
        districtList[1].nameEng = 'Bihar';
      }
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  Future<void> hitGetRegion() async {
    FocusManager.instance.primaryFocus!.unfocus();
    regionList.clear();
    APIRepository.getRegionApi(pickUp1DistrictId!)
        .then((RegionResponseModel? value) async {
      regionResponseModel = value;
      // regionList.addAll(regionResponseModel?.data ?? []);
      regionList2.addAll(regionResponseModel?.data ?? []);
      if (regionList2.isNotEmpty) {
        regionList.add(regionList2[0]);
        regionList.add(regionList2[1]);
        regionList[0].nameEng = 'Okhla vihar';
        regionList[1].nameEng = 'Patna';
      }

      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  Future<void> hitGetStop() async {
    stopList.clear();
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.getStopApi(pickUp1RegionId!)
        .then((StopResponseModel? value) async {
      stopResponseModel = value;
      stopList2.addAll(stopResponseModel?.data ?? []);
      if (stopList2.isNotEmpty) {
        stopList.add(stopList2[0]);
        stopList.add(stopList2[1]);
        stopList[0].ename = 'Okhla Bus stop';
        stopList[1].ename = 'Bailey Road';
      }
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }
}
