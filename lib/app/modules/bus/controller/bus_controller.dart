import 'package:intl/intl.dart';
import 'package:smart_ryde/app/modules/bus/model/bus_response.dart';
import 'package:smart_ryde/app/modules/home_booking/models/district_model.dart';
import 'package:smart_ryde/export.dart';
import '../../home_booking/models/region_model.dart';
import '../../home_booking/models/stop_model.dart';

class BusController extends GetxController {
  late TextEditingController destiny1Controller = TextEditingController();
  late TextEditingController destiny2Controller = TextEditingController();
  late TextEditingController region1Controller = TextEditingController();
  late TextEditingController region2Controller = TextEditingController();
  late TextEditingController stop1Controller = TextEditingController();
  late TextEditingController stop2Controller = TextEditingController();

  String selectedDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.parse(DateTime.now().toString()));

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
