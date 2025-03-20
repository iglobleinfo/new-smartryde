import 'package:smart_ryde/app/modules/home_booking/models/district_model.dart';
import 'package:smart_ryde/export.dart';
import '../../home_booking/models/region_model.dart';
import '../../home_booking/models/stop_model.dart';

class HomeDestinyController extends GetxController {
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
  List<RegionList> regionList = [];
  List<StopList> stopList = [];

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

  hitGetDistrict() {
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.getDistrictApi().then((DistrictResponseModel? value) async {
      districtResponseModel = value;
      districtList.addAll(districtResponseModel?.data ?? []);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  Future<void> hitGetRegion() async {
    FocusManager.instance.primaryFocus!.unfocus();
    regionList.clear();
    APIRepository.getRegionApi(pickUp1DistrictId!).then((RegionResponseModel? value) async {
      regionResponseModel = value;
      regionList.addAll(regionResponseModel?.data ?? []);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  Future<void> hitGetStop() async {
    stopList.clear();
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.getStopApi(pickUp1RegionId!).then((StopResponseModel? value) async {
      stopResponseModel = value;
      stopList.addAll(stopResponseModel?.data ?? []);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }
}
