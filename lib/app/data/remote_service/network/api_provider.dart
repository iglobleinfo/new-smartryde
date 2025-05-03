import 'package:device_info_plus/device_info_plus.dart';
import 'package:smart_ryde/app/data/remote_service/network/network_exceptions.dart';
import 'package:smart_ryde/app/modules/authentication/model/my_booking_response.dart';
import 'package:smart_ryde/app/modules/bus/model/bus_response.dart';
import 'package:smart_ryde/app/modules/home_booking/models/district_model.dart';
import 'package:smart_ryde/app/modules/home_booking/models/region_model.dart';
import 'package:smart_ryde/app/modules/home_booking/models/stop_model.dart';
import 'package:smart_ryde/model/error_response_model.dart';
import 'package:smart_ryde/model/responseModal/home_model.dart';

import '../../../../export.dart';
import 'dio_client.dart';

class APIRepository {
  static late DioClient? dioClient;
  static var deviceName, deviceType, deviceID, deviceVersion;

  APIRepository() {
    var dio = Dio();
    dioClient = DioClient(baseUrl, dio);
    getDeviceData();
  }

  getDeviceData() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await info.androidInfo;
      deviceName = androidDeviceInfo.model;
      deviceID = androidDeviceInfo.id;
      deviceVersion = androidDeviceInfo.version.release;
      deviceType = "1";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await info.iosInfo;
      deviceName = iosDeviceInfo.model;
      deviceID = iosDeviceInfo.identifierForVendor;
      deviceVersion = iosDeviceInfo.systemVersion;
      deviceType = "2";
    }
  }

  /*===================================================================== login API Call  ==========================================================*/
  static Future<LoginResponseModel?> loginApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(endPointLogin, data: dataBody);
      return LoginResponseModel.fromJson(response);
    } catch (e, str) {
      return Future.error(NetworkExceptions.getDioException(e, str));
    }
  }

  /*===================================================================== signup API Call  ==========================================================*/
  static Future<LoginResponseModel?> signUpApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(endPointSignUp, data: dataBody);
      return LoginResponseModel.fromJson(response);
    } catch (e, str) {
      return Future.error(
        NetworkExceptions.getDioException(e, str),
      );
    }
  }

  /*===================================================================== Generate Otp API Call  ==========================================================*/
  static Future generateOtpApi(String phoneNumber) async {
    try {
      final response = await dioClient!.get(
        endPointGenerateOtp + phoneNumber,
        skipAuth: false,
      );
      return response;
    } catch (e, str) {
      return Future.error(
        NetworkExceptions.getDioException(e, str),
      );
    }
  }

  /*===================================================================== Forgot Password Api  ==========================================================*/
  static Future forgotPasswordApi(Map<String, dynamic> data) async {
    try {
      final response = await dioClient!.post(
        endPointForgotPassword,
        skipAuth: false,
        data: data,
      );
      return response;
    } catch (e, str) {
      return Future.error(
        NetworkExceptions.getDioException(e, str),
      );
    }
  }

  /*===================================================================== Verify Otp API Call  ==========================================================*/
  static Future verifyOtpApi({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final response = await dioClient!.get(
        endPointVerifyOtp + phoneNumber,
        queryParameters: {
          'otp': otp,
        },
        skipAuth: false,
      );
      return response;
    } catch (e, str) {
      customLoader.hide();
      toast('Incorrect OTP');
      return Future.error(
        NetworkExceptions.getDioException(e, str),
      );
    }
  }

  /*===================================================================== update API Call  ==========================================================*/
  static Future<LoginResponseModel?> updateProfileApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.put(endPointSignUp, data: dataBody);
      return LoginResponseModel.fromJson(response);
    } catch (e, str) {
      return Future.error(NetworkExceptions.getDioException(e, str));
    }
  } /*===================================================================== feedback API Call  ==========================================================*/

  static Future<MessageResponseModel?> addFeedbackApiCall(
      {Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(endPointFeedback, data: dataBody);
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      return Future.error(NetworkExceptions.getDioException(e, str));
    }
  }

  /*===================================================================== Generate Otp API Call  ==========================================================*/
  static Future getUserApi(String userId) async {
    try {
      final response = await dioClient!.get(
        endPointGetUser + userId,
        skipAuth: false,
      );
      return LoginResponseModel.fromJson(response);
    } catch (e, str) {
      return Future.error(
        NetworkExceptions.getDioException(e, str),
      );
    }
  }

  /*===================================================================== Get My Bookings API Call  ==========================================================*/
  static Future<BookingListResponse?> getMyBookingApi(String userId) async {
    try {
      final response = await dioClient!.get(
        endPointGetMyBooking + userId,
        skipAuth: false,
      );
      return BookingListResponse.fromJson(response);
    } catch (e, str) {
      debugPrint(e.toString());
      debugPrint(str.toString());
      return Future.error(
        NetworkExceptions.getDioException(e, str),
      );
    }
  }

  /*===================================================================== Delete Cancel All Bookings API Call  ==========================================================*/
  static Future<ErrorMessageResponseModel?> deleteCancelBookingApi(String userId) async {
    try {
      final response = await dioClient!.get(
        endPointDeleteCancelBooking,
        skipAuth: false,
        queryParameters: {'userId':userId},
      );
      return ErrorMessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint(e.toString());
      debugPrint(str.toString());
      return Future.error(
        NetworkExceptions.getDioException(e, str),
      );
    }
  }

  /*===================================================================== Get My Bookings API Call  ==========================================================*/
  static Future<ErrorMessageResponseModel?> cancelBookingApi(
      String endPoint, String userId) async {
    try {
      final response = await dioClient!.get(
        endPoint,
        queryParameters: {
          'userId': userId,
        },
        skipAuth: false,
      );
      return ErrorMessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint(e.toString());
      debugPrint(str.toString());
      return Future.error(
        NetworkExceptions.getDioException(e, str),
      );
    }
  }

  /*===================================================================== Get District API Call  ==========================================================*/
  static Future<DistrictResponseModel?> getDistrictApi() async {
    try {
      var response = await dioClient!.get(
        endPointGetDistrict,
        skipAuth: false,
      );
      DistrictResponseModel districtResponseModel =
          DistrictResponseModel.fromJson(response);
      return districtResponseModel;
    } catch (e, str) {
      debugPrint('Error:$e');
      debugPrint('StackTrace:$str');
      return Future.error(
        NetworkExceptions.getDioException(e, str),
      );
    }
  }

  /*===================================================================== Get Region API Call  ==========================================================*/
  static Future<RegionResponseModel?> getRegionApi(int districtId) async {
    try {
      var response = await dioClient!.get(
        endPointGetRegion + districtId.toString(),
        skipAuth: false,
      );
      RegionResponseModel regionResponseModel =
          RegionResponseModel.fromJson(response);
      return regionResponseModel;
    } catch (e, str) {
      debugPrint('Error:$e');
      debugPrint('StackTrace:$str');
      return Future.error(
        NetworkExceptions.getDioException(e, str),
      );
    }
  }

  /*===================================================================== Get Stop API Call  ==========================================================*/
  static Future<StopResponseModel?> getStopApi(int regionId) async {
    try {
      var response = await dioClient!.get(endPointGetStopByRegion,
          skipAuth: false, queryParameters: {'region': regionId});
      StopResponseModel stopResponseModel =
          StopResponseModel.fromJson(response);
      return stopResponseModel;
    } catch (e, str) {
      debugPrint('Error:$e');
      debugPrint('StackTrace:$str');
      return Future.error(
        NetworkExceptions.getDioException(e, str),
      );
    }
  }

  /*===================================================================== Get Stop API Call By Route==========================================================*/
  static Future<StopResponseModel?> getStopByRoute({
    required int routeId,
    required String deptNo,
  }) async {
    try {
      var response = await dioClient!.get(
        endPointGetStopByRoute,
        skipAuth: false,
        queryParameters: {
          'routeId': routeId,
          'deptNo': deptNo,
        },
      );
      StopResponseModel stopResponseModel =
          StopResponseModel.fromJson(response);
      return stopResponseModel;
    } catch (e, str) {
      debugPrint('Error:$e');
      debugPrint('StackTrace:$str');
      return Future.error(
        NetworkExceptions.getDioException(e, str),
      );
    }
  }

  /*===================================================================== Get Bus List API Call  ==========================================================*/
  static Future<BusListResponseModel?> getBusListApi(
      int fromId, int toId, String selectedDate) async {
    try {
      var response = await dioClient!
          .get(endPointGetBusList, skipAuth: false, queryParameters: {
        'fromStopId': fromId,
        'toStopId': toId,
        'journeyDate': selectedDate,
      });
      BusListResponseModel busListResponseModel =
          BusListResponseModel.fromJson(response);
      return busListResponseModel;
    } catch (e, str) {
      debugPrint('Error:$e');
      debugPrint('StackTrace:$str');
      return Future.error(
        NetworkExceptions.getDioException(e, str),
      );
    }
  }

  /*===================================================================== Book Ticket Api  ==========================================================*/
  static Future bookTicketApi(Map<String, dynamic> data) async {
    try {
      final response = await dioClient!.post(
        endPointBookTicket,
        skipAuth: false,
        data: data,
      );
      return response;
    } catch (e, str) {
      return Future.error(
        NetworkExceptions.getDioException(e, str),
      );
    }
  }

  /*===================================================================== login API Call  ==========================================================*/
  static Future socialLoginApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
          await dioClient!.post(endPointSocialLogin, data: dataBody);
      return LoginResponseModel.fromJson(response);
    } catch (e, str) {
      return Future.error(NetworkExceptions.getDioException(e, str));
    }
  }

  static Future forgetApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(endPointForgot, data: dataBody);
      return MyAccountModel.fromJson(response);
    } catch (e, str) {
      return Future.error(NetworkExceptions.getDioException(e, str));
    }
  }

  static Future myAccountApiCall() async {
    try {
      final response = await dioClient!.post(endPointMyAccount);
      return MyAccountModel.fromJson(response);
    } catch (e, str) {
      return Future.error(NetworkExceptions.getDioException(e, str));
    }
  }

  static Future faqApiCall() async {
    try {
      final response = await dioClient!.post(endPointMyAccount);
      return MyAccountModel.fromJson(response);
    } catch (e, str) {
      return Future.error(NetworkExceptions.getDioException(e, str));
    }
  }

  static Future homeListApiCall() async {
    try {
      final response = await dioClient!.post(myBook);
      return (response as List).map((p) => HomeModel.fromJson(p)).toList();
    } catch (e, str) {
      return Future.error(NetworkExceptions.getDioException(e, str));
    }
  }

  /*===================================================================== Subscription Plans list API Call  ==========================================================*/
  static Future subscriptionPlansListApiCall() async {
    try {
      final response = await dioClient!.get(
        plansListEndPt,
        skipAuth: false,
      );
      return response;
    } catch (e, str) {
      return Future.error(NetworkExceptions.getDioException(e, str));
    }
  }

  /*===================================================================== Buy Subscription API Call  ==========================================================*/
  static Future buySubscriptionPlanApiCall(id) async {
    try {
      final response = await dioClient!.get(buySubscriptionEndPt,
          skipAuth: false, queryParameters: {'id': id});
      return response;
    } catch (e, str) {
      return Future.error(NetworkExceptions.getDioException(e, str));
    }
  }

  //*===================================================================== Report Any crashes or errors to logger API Call  ==========================================================*
  static Future<ErrorMessageResponseModel?> reportCrashLogApiCall(
      {data}) async {
    try {
      final res = await dioClient!.post(
          crashBaseUrl + logCrashesExceptionsEndPoint,
          data: FormData.fromMap(data));
      var response = res.data;
      return ErrorMessageResponseModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}
//
// reportCrash(stackTrace) async {
//   PackageInfo packageInfo = await PackageInfo.fromPlatform();
//   String version = packageInfo.version;
//   CustomLoader customLoader = CustomLoader();
//   var req = AuthRequestModel.logCrashErrorReq(
//       error: packageInfo.packageName,
//       packageVersion: version,
//       phoneModel: APIRepository.deviceName,
//       ip: APIRepository.deviceVersion,
//       stackTrace: stackTrace);
//   debugPrint('Log req: $req', wrapWidth: 1000);
//   await APIRepository.reportCrashLogApiCall(data: req).then((value) async {
//     customLoader.hide();
//     if (value != null) {}
//   }).onError((error, stackTrace) {
//     customLoader.hide();
//     initApp();
//     toast(error.toString());
//   });
// }
