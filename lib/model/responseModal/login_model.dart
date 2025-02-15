import 'dart:convert';

import 'package:smart_ryde/app/modules/authentication/model/login_data_model.dart';

LoginResponseModel welcomeFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String welcomeToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  String? timestamp;
  int? statusCode;
  LoginDataModel? data;
  String? message;
  String? details;
  bool? status;

  LoginResponseModel({
    this.timestamp,
    this.statusCode,
    this.data,
    this.message,
    this.details,
    this.status,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        timestamp: json["timestamp"],
        statusCode: json["statusCode"],
        data:
            json["data"] == null ? null : LoginDataModel.fromJson(json["data"]),
        message: json["message"],
        details: json["details"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "statusCode": statusCode,
        "data": data?.toJson(),
        "message": message,
        "details": details,
        "status": status,
      };
}
