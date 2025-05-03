import 'package:intl/intl.dart';
import 'package:smart_ryde/app/modules/authentication/model/my_booking_response.dart';
import 'package:smart_ryde/app/modules/bus/model/bus_response.dart';
import 'package:smart_ryde/export.dart';
import 'package:smart_ryde/model/error_response_model.dart';

import '../model/login_data_model.dart';

class MyBookingController extends GetxController  {
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

  BookingListResponse? bookingListResponse;
  List<BookingList> bookingList = [];
  List<BookingList> currentBookingList = [];
  List<BookingList> cancelledBookingList = [];
  List<BookingList> pastBookingList = [];
  LoginDataModel? userData;

  @override
  void onInit() {
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
    hitGetBookingList();
    update();
  }

  Future<void> hitGetBookingList() async {
    userData = await PreferenceManger().getUserData();
    isLoader = true;
    bookingList.clear();
    currentBookingList.clear();
    cancelledBookingList.clear();
    pastBookingList.clear();
    APIRepository.getMyBookingApi(userData!.id.toString())
        .then((BookingListResponse? value) async {
      bookingListResponse = value;
      if (bookingListResponse?.data != null) {
        bookingList.addAll(bookingListResponse!.data ?? []);
        for (int i = 0; i < bookingList.length; i++) {
          if (bookingList[i].canceled ?? false) {
            cancelledBookingList.add(bookingList[i]);
          } else if (bookingList[i].tripEnd ?? false) {
            pastBookingList.add(bookingList[i]);
          } else if (!(bookingList[i].tripEnd ?? false) &&
              !(bookingList[i].canceled ?? false)) {
            currentBookingList.add(bookingList[i]);
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

  Future<void> hitCancelBooking(String ticketId) async {
    APIRepository.cancelBookingApi(
            endPointCancelBooking + ticketId, userData!.id.toString())
        .then((ErrorMessageResponseModel? value) async {
      hitGetBookingList();
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
    APIRepository.deleteCancelBookingApi( userData!.id.toString())
        .then((ErrorMessageResponseModel? value) async {
      hitGetBookingList();
      update();
    }).onError((error, stackTrace) {
      isLoader = false;
      debugPrint(stackTrace.toString());
      customLoader.hide();
      toast(error);
    });
    update();
  }
}
