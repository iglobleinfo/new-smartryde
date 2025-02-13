

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:smart_ryde/app/data/remote_service/network/network_exceptions.dart';
import 'package:smart_ryde/model/error_response_model.dart';
import 'package:smart_ryde/model/responseModal/home_model.dart';
import 'package:smart_ryde/model/responseModal/login_model.dart';
import 'package:smart_ryde/model/responseModal/myaccount_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
  static Future loginApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(login, data: dataBody);
      return LoginModel.fromJson(response);
    } catch (e,str) {
      return Future.error(NetworkExceptions.getDioException(e,str));
    }
  }

  /*===================================================================== login API Call  ==========================================================*/
  static Future socialLoginApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(endPointSocialLogin, data: dataBody);
      return LoginModel.fromJson(response);
    } catch (e,str) {
      return Future.error(NetworkExceptions.getDioException(e,str));
    }
  }

  static Future forgetApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(endPointForgot, data: dataBody);
      return MyAccountModel.fromJson(response);
    } catch (e,str) {
      return Future.error(NetworkExceptions.getDioException(e,str));
    }
  }

  static Future myAccountApiCall() async {
    try {
      final response = await dioClient!.post(endPointMyAccount);
      return MyAccountModel.fromJson(response);
    } catch (e,str) {
      return Future.error(NetworkExceptions.getDioException(e,str));
    }
  }

  static Future faqApiCall() async {
    try {
      final response = await dioClient!.post(endPointMyAccount);
      return MyAccountModel.fromJson(response);
    } catch (e,str) {
      return Future.error(NetworkExceptions.getDioException(e,str));
    }
  }

  static Future homeListApiCall() async {
    try {
      final response = await dioClient!.post(myBook);
      return (response as List).map((p) => HomeModel.fromJson(p)).toList();
    } catch (e,str) {
      return Future.error(NetworkExceptions.getDioException(e,str));
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
    } catch (e,str) {
      return Future.error(NetworkExceptions.getDioException(e,str));
    }
  }

  /*===================================================================== Buy Subscription API Call  ==========================================================*/
  static Future buySubscriptionPlanApiCall(id) async {
    try {
      final response = await dioClient!.get(buySubscriptionEndPt,
          skipAuth: false, queryParameters: {'id': id});
      return response;
    } catch (e,str) {
      return Future.error(NetworkExceptions.getDioException(e,str));
    }
  }

  //*===================================================================== Report Any crashes or errors to logger API Call  ==========================================================*
  static Future<ErrorMessageResponseModel?> reportCrashLogApiCall(
      {data}) async {
    try {
      final res = await Dio().post(crashBaseUrl + logCrashesExceptionsEndPoint,
          data: FormData.fromMap(data));
      var response = res.data;
      return ErrorMessageResponseModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}

reportCrash(stackTrace) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  CustomLoader customLoader = CustomLoader();
  var req = AuthRequestModel.logCrashErrorReq(
      error: packageInfo.packageName,
      packageVersion: version,
      phoneModel: APIRepository.deviceName,
      ip: APIRepository.deviceVersion,
      stackTrace: stackTrace);
  debugPrint('Log req: $req', wrapWidth: 1000);
  await APIRepository.reportCrashLogApiCall(data: req).then((value) async {
    customLoader.hide();
    if (value != null) {}
  }).onError((error, stackTrace) {
    customLoader.hide();
    initApp();
    toast(error.toString());
  });
}
