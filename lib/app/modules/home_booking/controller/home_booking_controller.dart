import 'package:smart_ryde/app/modules/authentication/model/login_data_model.dart';
import 'package:smart_ryde/app/modules/home_booking/models/district_model.dart';
import 'package:smart_ryde/export.dart';
import 'package:smart_ryde/model/responseModal/bookmark_response_model.dart';

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

  BookmarkListResponseModel? bookmarkListResponseModel;
  List<BookmarkList> bookmarkList = [];

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

  Future<void> hitBookmarkApi(context, index) async {
    customLoader.show(context);
    userData = await PreferenceManger().getUserData();
    // Hit Bookmark Api
    var bookmarkRequest = AuthRequestModel.bookMarkReq(
      actionType: 'D',
      fromStopId: bookmarkList[index].fromStopId,
      toStopId: bookmarkList[index].toStopId,
      bookmarkId: bookmarkList[index].id,
      userId: userData!.id!,
      routeId: bookmarkList[index].toStopId,
    );
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.bookMarkApi(bookmarkRequest).then((value) async {
      hitGetBookmark();
      customLoader.hide();
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
    update();
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

  LoginDataModel? userData;

  Future<void> hitGetBookmark() async {
    FocusManager.instance.primaryFocus!.unfocus();
    userData = await PreferenceManger().getUserData();
    APIRepository.getBookmarkApi(userData!.id.toString()).then((value) async {
      bookmarkListResponseModel = value;
      bookmarkList
        ..clear()
        ..addAll(bookmarkListResponseModel?.data ?? []);
      update();
    }).onError((error, stackTrace) {
      debugPrint(stackTrace.toString());
      customLoader.hide();
      toast(error);
    });
  }

  Future<void> hitGetDistrict() async {
    if (PreferenceManger().getStatusUserLogin() ?? false) {
      hitGetBookmark();
    }
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
    APIRepository.getRegionApi(pickUp1DistrictId!)
        .then((RegionResponseModel? value) async {
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
    APIRepository.getStopApi(pickUp1RegionId!)
        .then((StopResponseModel? value) async {
      stopResponseModel = value;
      stopList.addAll(stopResponseModel?.data ?? []);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }
}
