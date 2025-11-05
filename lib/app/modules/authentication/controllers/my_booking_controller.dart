import 'package:intl/intl.dart';
import 'package:smart_ryde/app/modules/authentication/model/my_booking_response.dart';
import 'package:smart_ryde/app/modules/bus/model/bus_response.dart';
import 'package:smart_ryde/export.dart';
import 'package:smart_ryde/model/error_response_model.dart';

import '../model/booking_response.dart';
import '../model/login_data_model.dart';

class MyBookingController extends GetxController
    with GetTickerProviderStateMixin {
  late TextEditingController destiny1Controller = TextEditingController();
  late TextEditingController destiny2Controller = TextEditingController();
  late TextEditingController region1Controller = TextEditingController();
  late TextEditingController region2Controller = TextEditingController();
  late TextEditingController stop1Controller = TextEditingController();
  late TextEditingController stop2Controller = TextEditingController();

  String selectedDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.parse(DateTime.now().toString()));

  late TabController tabController;

  int index = 0;

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

  // BookingListResponse? bookingListResponse;
  BookingResponseModel? bookingResponseModel;
  BookingData? bookingData;
  int page = 0;
  List<Content> bookingDataList = [];
  ScrollController currentScrollController = ScrollController();
  ScrollController cancelledScrollController = ScrollController();
  ScrollController pastScrollController = ScrollController();
  // List<BookingList> bookingList = [];
  // List<BookingList> currentBookingList = [];
  // List<BookingList> cancelledBookingList = [];
  // List<BookingList> pastBookingList = [];
  LoginDataModel? userData;

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    listenerCurrentScrollControllers();
    listenerCancelledScrollControllers();
    listenerPastScrollControllers();
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
    hitGetBookingData();
    update();
  }

  listenerCurrentScrollControllers() async {
    currentScrollController.addListener(() {
      if (currentScrollController.position.pixels ==
          currentScrollController.position.maxScrollExtent) {
        if ((page + 1) * 20 <= bookingDataList.length) {
          page++;
          debugPrint('page:::$page');
          hitGetBookingData(isLoading: false);
        }
      }
    });
  }

  listenerCancelledScrollControllers() async {
    cancelledScrollController.addListener(() {
      if (cancelledScrollController.position.pixels ==
          cancelledScrollController.position.maxScrollExtent) {
        if ((page + 1) * 20 <= bookingDataList.length) {
          page++;
          debugPrint('page:::$page');
          hitGetBookingData(isLoading: false);
        }
      }
    });
  }

  listenerPastScrollControllers() async {
    pastScrollController.addListener(() {
      if (pastScrollController.position.pixels ==
          pastScrollController.position.maxScrollExtent) {
        if ((page + 1) * 20 <= bookingDataList.length) {
          page++;
          debugPrint('page:::$page');
          hitGetBookingData(isLoading: false);
        }
      }
    });
  }

  String bookingType = 'current';

  Future<void> hitGetBookingData({bool? isLoading}) async {
    userData = await PreferenceManger().getUserData();

    if (page == 0) {
      isLoader = true;
      bookingDataList.clear();
    }
    APIRepository.getBookingApi(userData!.id.toString(), bookingType, page)
        .then((BookingResponseModel? value) async {
      if (value != null) {
        bookingResponseModel = value;
        debugPrint('bookingResponseModel::$bookingResponseModel');
        if (bookingResponseModel?.data != null) {
          bookingData = bookingResponseModel!.data;
          if (bookingData != null) {
            debugPrint(
                'bookingData?.content ?? []::${bookingData?.content?.length ?? []}');
            bookingDataList.addAll(bookingData?.content ?? []);
          }
        }
      }
      isLoader = false;
      update();
    }).onError((error, stackTrace) {
      isLoader = false;
      debugPrint(stackTrace.toString());
      customLoader.hide();
      toast(error);
    });
    update();
  }

  /// Old My Booking Api
  // Future<void> hitGetBookingList() async {
  //   userData = await PreferenceManger().getUserData();
  //   isLoader = true;
  //   bookingList.clear();
  //   currentBookingList.clear();
  //   cancelledBookingList.clear();
  //   pastBookingList.clear();
  //   APIRepository.getMyBookingApi(userData!.id.toString())
  //       .then((BookingListResponse? value) async {
  //     bookingListResponse = value;
  //     if (bookingListResponse?.data != null) {
  //       bookingList.addAll(bookingListResponse!.data ?? []);
  //       for (int i = 0; i < bookingList.length; i++) {
  //         if (bookingList[i].canceled ?? false) {
  //           cancelledBookingList.add(bookingList[i]);
  //         } else if (bookingList[i].tripEnd ?? false) {
  //           pastBookingList.add(bookingList[i]);
  //         } else if (!(bookingList[i].tripEnd ?? false) &&
  //             !(bookingList[i].canceled ?? false)) {
  //           currentBookingList.add(bookingList[i]);
  //         }
  //       }
  //     }
  //     isLoader = false;
  //     update();
  //   }).onError((error, stackTrace) {
  //     isLoader = false;
  //     debugPrint(stackTrace.toString());
  //     customLoader.hide();
  //     toast(error);
  //   });
  //   update();
  // }

  Future<void> hitGetBusVerificationApi(BookingList busData) async {
    APIRepository.getBusVerificationApi(busData.tripRecordId.toString())
        .then((ErrorMessageResponseModel? value) async {
      Get.toNamed(
        AppRoutes.liveTracking,
        arguments: {'busData': busData},
      );
      update();
    }).onError((error, stackTrace) {
      debugPrint(stackTrace.toString());
      debugPrint(error.toString());
      customLoader.hide();
      toast(error);
    });
    update();
  }

  Future<void> hitCancelBooking(String ticketId) async {
    isLoader = true;
    APIRepository.cancelBookingApi(
            endPointCancelBooking + ticketId, userData!.id.toString())
        .then((ErrorMessageResponseModel? value) async {
      hitGetBookingData();
      isLoader = false;
      update();
    }).onError((error, stackTrace) {
      isLoader = false;
      debugPrint(stackTrace.toString());
      customLoader.hide();
      toast(error);
    });
    update();
  }

  Future<void> hitDeleteAllCancelBooking() async {
    isLoader = true;
    APIRepository.deleteCancelBookingApi(userData!.id.toString())
        .then((ErrorMessageResponseModel? value) async {
      hitGetBookingData();
      isLoader = false;
      update();
    }).onError((error, stackTrace) {
      isLoader = false;
      debugPrint(stackTrace.toString());
      customLoader.hide();
      toast(error);
    });
    update();
  }

  Future<void> hitDeleteCancelBooking(String ticketId) async {
    isLoader = true;
    APIRepository.deleteBookingApi(ticketId, userData!.id.toString())
        .then((ErrorMessageResponseModel? value) async {
      hitGetBookingData();
      isLoader = false;
      update();
    }).onError((error, stackTrace) {
      isLoader = false;
      debugPrint(stackTrace.toString());
      customLoader.hide();
      toast(error);
    });
    update();
  }

  void onTabChange(int selectedIndex) {
    index = selectedIndex;
    page = 0;
    if (index == 0) {
      bookingType = 'current';
    } else if (index == 1) {
      bookingType = 'canceled';
    } else {
      bookingType = 'past';
    }
    hitGetBookingData();
    update();
  }
}
