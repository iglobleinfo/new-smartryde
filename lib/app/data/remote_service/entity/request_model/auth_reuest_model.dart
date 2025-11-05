// Project imports:
import 'dart:io';

import '../../../push_notification_manager.dart';

class AuthRequestModel {
  static loginReq({
    required String phoneNumber,
    required String password,
    deviceType,
    deviceName,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = phoneNumber;
    data['password'] = password;
    data['fcmToken'] = deviceToken;
    data['platform'] = Platform.isAndroid?'Android':'iOS';
    return data;
  }

  static registerReq({
    required String phoneNumber,
    required String password,
    required String email,
    required String name,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['phone'] = phoneNumber;
    return data;
  }

  static profileReq({
    required String phoneNumber,
    required String userId,
    required String email,
    required String name,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['id'] = userId;
    data['name'] = name;
    data['phone'] = phoneNumber;
    return data;
  }
  static feedbackReq({
    required String phoneNumber,
    required String userId,
    required String email,
    required String feedbackType,
    required String incidentDetails,
    required String name,
    required String route,
    required String incidentDate,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emailId'] = email;
    data['feedbackType'] = feedbackType;
    data['incidentDetails'] = incidentDetails;
    data['incidentDate'] = incidentDate;
    data['route'] = route;
    data['name'] = name;
    data['phone'] = phoneNumber;
    return data;
  }

  static forgetReq({
    required String phoneNumber,
    required String otp,
    required String password,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = phoneNumber;
    data['otp'] = otp;
    data['newPassword'] = password;
    return data;
  }

  static bookTicketReq({
    required String bookedBy,
    required int fromStopId,
    required int toStopId,
    required int totalSeat,
    required int tripRecordId,
    required int userId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookedBy'] = bookedBy;
    data['fromStopId'] = fromStopId;
    data['toStopId'] = toStopId;
    data['totalSeat'] = totalSeat;
    data['tripRecordId'] = tripRecordId;
    data['userId'] = userId;
    {}
    return data;
  }

  static bookMarkReq({
    required String actionType,
    required int fromStopId,
    required int toStopId,
    required int routeId,
    required int bookmarkId,
    required int userId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['actionType'] = actionType;
    data['fromStopId'] = fromStopId;
    data['toStopId'] = toStopId;
    data['routeId'] = routeId;
    data['userId'] = userId;
    data['bookmarkId'] = bookmarkId;
    {}
    return data;
  }

  static socialLoginReq({
    var userId,
    var email,
    var fullName,
    var username,
    var provider,
    var img_url,
    var deviceToken,
    var deviceType,
    var deviceName,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['User[userId]'] = userId;
    data['User[email]'] = email;
    data['User[full_name]'] = fullName;
    data['LoginForm[username]'] = username;
    data['LoginForm[provider]'] = provider;
    data['LoginForm[device_token]'] = deviceToken;
    data['LoginForm[device_type]'] = deviceType;
    data['LoginForm[device_name]'] = deviceName;
    data['img_url'] = img_url;
    return data;
  }

  static logCrashErrorReq({
    error,
    packageVersion,
    phoneModel,
    ip,
    stackTrace,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Log[error]'] = error;
    data['Log[link]'] = packageVersion;
    data['Log[referer_link]'] = phoneModel;
    data['Log[user_ip]'] = ip;
    data['Log[description]'] = stackTrace;
    return data;
  }
}
