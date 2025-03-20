// To parse this JSON data, do
//
//     final districtResponseModel = districtResponseModelFromJson(jsonString);

import 'dart:convert';

DistrictResponseModel districtResponseModelFromJson(String str) =>
    DistrictResponseModel.fromJson(json.decode(str));

String districtResponseModelToJson(DistrictResponseModel data) =>
    json.encode(data.toJson());

class DistrictResponseModel {
  String? timestamp;
  int? statusCode;
  List<DistrictList>? data;
  String? message;
  String? details;
  bool? status;

  DistrictResponseModel({
    this.timestamp,
    this.statusCode,
    this.data,
    this.message,
    this.details,
    this.status,
  });

  factory DistrictResponseModel.fromJson(Map<String, dynamic> json) =>
      DistrictResponseModel(
        timestamp: json["timestamp"],
        statusCode: json["statusCode"],
        data: json["data"] == null
            ? []
            : List<DistrictList>.from(
                json["data"]!.map((x) => DistrictList.fromJson(x))),
        message: json["message"],
        details: json["details"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "statusCode": statusCode,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "details": details,
        "status": status,
      };
}

class DistrictList {
  int? districtId;
  String? nameEng;
  String? nameChi;
  String? nameChiSim;
  bool? deleted;
  bool? active;

  DistrictList({
    this.districtId,
    this.nameEng,
    this.nameChi,
    this.nameChiSim,
    this.deleted,
    this.active,
  });

  factory DistrictList.fromJson(Map<String, dynamic> json) => DistrictList(
        districtId: json["districtId"],
        nameEng: json["nameEng"],
        nameChi: json["nameChi"],
        nameChiSim: json["nameChiSim"],
        deleted: json["deleted"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "districtId": districtId,
        "nameEng": nameEng,
        "nameChi": nameChi,
        "nameChiSim": nameChiSim,
        "deleted": deleted,
        "active": active,
      };
}
