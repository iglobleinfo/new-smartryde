import 'package:intl/intl.dart';
import 'package:smart_ryde/app/modules/authentication/model/login_data_model.dart';
import 'package:smart_ryde/app/modules/bus/model/bus_response.dart';
import 'package:smart_ryde/export.dart';
import 'package:smart_ryde/model/responseModal/bookmark_response_model.dart';

import '../../home_booking/controller/home_booking_controller.dart';

class BusController extends GetxController {
  late TextEditingController destiny1Controller = TextEditingController();
  late TextEditingController destiny2Controller = TextEditingController();
  late TextEditingController region1Controller = TextEditingController();
  late TextEditingController region2Controller = TextEditingController();
  late TextEditingController stop1Controller = TextEditingController();
  late TextEditingController stop2Controller = TextEditingController();

  String selectedDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.parse(DateTime.now().toString()));

  bool isBookmark = false;
  int bookmarkId = 0;

  bool isLoader = true;

  List<Map<String, dynamic>> dateList = [
    {
      'check': true,
      'date': DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(DateTime.now().toString())),
    },
    {
      'check': false,
      'date': DateFormat('yyyy-MM-dd').format(
          DateTime.parse(DateTime.now().add(Duration(days: 1)).toString())),
    },
    {
      'check': false,
      'date': DateFormat('yyyy-MM-dd').format(
          DateTime.parse(DateTime.now().add(Duration(days: 2)).toString())),
    },
    {
      'check': false,
      'date': DateFormat('yyyy-MM-dd').format(
          DateTime.parse(DateTime.now().add(Duration(days: 3)).toString())),
    },
  ];

  // List<Map<String, dynamic>> dateListTCH = [
  //   {
  //     'check': true,
  //     'date': DateFormat('yyyy-MM-dd')
  //         .format(DateTime.parse(DateTime.now().toString())),
  //   },
  //   {
  //     'check': false,
  //     'date': DateFormat('yyyy-MM-dd').format(
  //         DateTime.parse(DateTime.now().add(Duration(days: 1)).toString())),
  //   },
  //   {
  //     'check': false,
  //     'date': DateFormat('yyyy-MM-dd').format(
  //         DateTime.parse(DateTime.now().add(Duration(days: 2)).toString())),
  //   },
  //   {
  //     'check': false,
  //     'date': DateFormat('yyyy-MM-dd').format(
  //         DateTime.parse(DateTime.now().add(Duration(days: 3)).toString())),
  //   },
  // ];
  //
  // List<Map<String, dynamic>> dateListSCH = [
  //   {
  //     'check': true,
  //     'date': DateFormat('yyyy年MMMMd日', 'zh_CN')
  //         .format(DateTime.parse(DateTime.now().toString())),
  //   },
  //   {
  //     'check': false,
  //     'date': DateFormat('yyyy年MMMMd日', 'zh_CN').format(
  //         DateTime.parse(DateTime.now().add(Duration(days: 1)).toString())),
  //   },
  //   {
  //     'check': false,
  //     'date': DateFormat('yyyy年MMMMd日', 'zh_CN').format(
  //         DateTime.parse(DateTime.now().add(Duration(days: 2)).toString())),
  //   },
  //   {
  //     'check': false,
  //     'date': DateFormat('yyyy年MMMMd日', 'zh_CN').format(
  //         DateTime.parse(DateTime.now().add(Duration(days: 3)).toString())),
  //   },
  // ];

  BusListResponseModel? busListResponseModel;
  List<BusList> busList = [];
  int? fromId;
  int? toId;
  String? fromName;
  String? toName;

  @override
  void onInit() {
    customLoader = CustomLoader();
    fromId = Get.arguments['fromId'];
    toId = Get.arguments['toId'];
    fromName = Get.arguments['fromName'];
    toName = Get.arguments['toName'];
    hitGetBookmark();
    super.onInit();
  }

  @override
  void onClose() {
    customLoader.hide();
    super.onClose();
  }

  @override
  void onReady() {
    hitGetBusList();
    update();
  }

  LoginDataModel? userData;

  Future<void> hitBookmarkApi(context) async {
    customLoader.show(context);
    userData = await PreferenceManger().getUserData();
    // Hit Bookmark Api
    var bookmarkRequest = AuthRequestModel.bookMarkReq(
      // actionType: isBookmark ? 'D' : 'S',
      actionType: 'S',
      fromStopId: fromId!,
      toStopId: toId!,
      bookmarkId: bookmarkId,
      userId: userData!.id!,
      routeId: toId!,
    );
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.bookMarkApi(bookmarkRequest).then((value) async {
      // isBookmark = !isBookmark;
      isBookmark = true;
      customLoader.hide();
      Get.find<HomeBookingController>().hitGetBookmark();
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
    isLoader = false;
    update();
  }

  BookmarkListResponseModel? bookmarkListResponseModel;
  List<BookmarkList> bookmarkList = [];

  Future<void> hitGetBookmark() async {
    FocusManager.instance.primaryFocus!.unfocus();
    userData = await PreferenceManger().getUserData();
    APIRepository.getBookmarkApi(userData!.id.toString()).then((value) async {
      bookmarkListResponseModel = value;
      bookmarkList
        ..clear()
        ..addAll(bookmarkListResponseModel?.data ?? []);

      if (bookmarkList.isNotEmpty) {
        for (int i = 0; i < bookmarkList.length; i++) {
          if (fromId.toString() == bookmarkList[i].fromStopId.toString() &&
              toId.toString() == bookmarkList[i].toStopId.toString()) {
            isBookmark = true;
            bookmarkId = bookmarkList[i].id;
          }
        }
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint(stackTrace.toString());
      customLoader.hide();
      toast(error);
    });
  }

  Future<void> hitGetBusList() async {
    isLoader = true;
    APIRepository.getBusListApi(fromId!, toId!, selectedDate)
        .then((BusListResponseModel? value) async {
      busListResponseModel = value;
      if (busListResponseModel?.data != null) {
        busList.addAll(busListResponseModel?.data?.busList ?? []);
      }
      isLoader = false;
      update();
    }).onError((error, stackTrace) {
      isLoader = false;
      customLoader.hide();
      toast(error);
    });
    update();
  }
}
