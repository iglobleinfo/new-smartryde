import 'package:intl/intl.dart';
import 'package:smart_ryde/app/modules/authentication/model/login_data_model.dart';
import 'package:smart_ryde/app/modules/bus/booking_confirm_screen.dart';
import 'package:smart_ryde/app/modules/bus/model/bus_response.dart';
import 'package:smart_ryde/export.dart';

class BookSeatController extends GetxController {
  TextEditingController seatPickerController = TextEditingController();

  String selectedDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.parse(DateTime.now().toString()));

  bool isLoader = true;

  BusList? busData;
  String? fromName;
  String? toName;

  BusListResponseModel? busListResponseModel;
  List<BusList> busList = [];
  int? fromId;
  int? toId;
  LoginDataModel? userData;

  @override
  void onInit() {
    customLoader = CustomLoader();
    busData = Get.arguments['busData'];
    fromId = Get.arguments['fromId'];
    toId = Get.arguments['toId'];
    fromName = Get.arguments['fromName'];
    toName = Get.arguments['toName'];
    super.onInit();
  }

  @override
  void onClose() {
    customLoader.hide();
    super.onClose();
  }

  @override
  void onReady() {
    update();
  }

  Future<void> hitBookingApi(context) async {
    userData = await PreferenceManger().getUserData();
    isLoader = true;
    // Hit Booking Api
    var bookingRequest = AuthRequestModel.bookTicketReq(
        bookedBy: userData?.name ?? '',
        fromStopId: fromId!,
        toStopId: toId!,
        totalSeat: int.parse(seatPickerController.text),
        tripRecordId: busData!.id!,
        userId: userData!.id!);
    customLoader.show(context);
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.bookTicketApi(bookingRequest).then((value) async {
      customLoader.hide();
      Get.to(BookingConfirmScreen(stopName: fromName??'',));
      toast('Booked successfully'.tr);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
    isLoader = false;
    update();
  }
}
