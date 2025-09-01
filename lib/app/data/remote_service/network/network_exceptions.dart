// Package imports:

import 'package:dio/dio.dart';
import 'package:flutter_logger/FlutterLogger.dart';
import 'package:smart_ryde/model/error_response_model.dart';

import '../../../../export.dart';

class NetworkExceptions {
  static String messageData = "";

  static getDioException(error, stacktrace) {
    // reportCrash(error.toString());
    if (error is Exception) {
      // FlutterLogger.getInstance().recordCrash(
      //   reportURL: crashBaseUrl + logCrashesExceptionsEndPoint,
      //   stackTrace: stacktrace.toString(),
      // );
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return messageData = stringRequestCancelled;
            case DioExceptionType.connectionTimeout:
              return messageData = stringConnectionTimeout;
            case DioExceptionType.unknown:
              List<String> dateParts = error.message!.split(":");
              List<String> message = dateParts[2].split(",");

              if (message[0].trim() == stringConnectionRefused) {
                return messageData = stringServerMaintenance;
              } else if (message[0].trim() == stringNetworkUnreachable) {
                return messageData = stringNetworkUnreachable;
              } else if (dateParts[1].trim() == stringFailedToConnect) {
                return messageData = stringInternetConnection;
              } else {
                return messageData = dateParts[1];
              }
            case DioExceptionType.receiveTimeout:
              return messageData = stringTimeOut;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 400:
                  return messageData = error.response?.data['message'] ?? '';
                case 401:
                  storage.remove(LOCALKEY_token);
                  PreferenceManger().clearLoginData();
                  Get.offAllNamed(AppRoutes.logIn);
                  try {
                    return messageData =
                        error.response?.data['message'] ?? 'Session expired';
                  } catch (err) {
                    return messageData = 'Session expired';
                  }
                case 403:
                  storage.remove(LOCALKEY_token);
                  PreferenceManger().clearLoginData();
                  Get.offAllNamed(AppRoutes.logIn);
                  try {
                    return messageData =
                        error.response?.data['message'] ?? 'Session expired';
                  } catch (err) {
                    return messageData = 'Session expired';
                  }
                case 404:
                  return messageData = stringNotFound;
                case 408:
                  return messageData = stringRequestTimeOut;
                case 500:
                  return messageData =
                      'Something went wrong, Please try again later.';
                // return messageData = stringInternalServerError;
                case 503:
                  return messageData = stringInternetServiceUnavailable;
                default:
                  return messageData = stringSomethingsIsWrong;
              }
            case DioExceptionType.sendTimeout:
              return messageData = stringTimeOut;
            case DioExceptionType.badCertificate:
              // TODO: Handle this case.
              break;
            case DioExceptionType.badResponse:
            case DioExceptionType.connectionError:
              return messageData =
                  'Something went wrong, Please try again later.';
              // TODO: Handle this case.
              break;
          }
        } else if (error is SocketException) {
          return messageData = socketExceptions;
        } else {
          return messageData = stringUnexpectedException;
        }
      } on FormatException catch (_) {
        return messageData = stringFormatException;
      } catch (_) {
        return messageData = stringUnexpectedException;
      }
    } else {
      if (error.toString().contains(stringNotSubType)) {
        return messageData = stringUnableToProcessData;
      } else {
        return messageData = stringUnexpectedException;
      }
    }
  }
}
