// To parse this JSON data, do
//
//     final regionResponseModel = regionResponseModelFromJson(jsonString);

import 'dart:convert';

RegionResponseModel regionResponseModelFromJson(String str) => RegionResponseModel.fromJson(json.decode(str));

String regionResponseModelToJson(RegionResponseModel data) => json.encode(data.toJson());

class RegionResponseModel {
  String? timestamp;
  int? statusCode;
  List<RegionList>? data;
  String? message;
  String? details;
  bool? status;

  RegionResponseModel({
    this.timestamp,
    this.statusCode,
    this.data,
    this.message,
    this.details,
    this.status,
  });

  factory RegionResponseModel.fromJson(Map<String, dynamic> json) => RegionResponseModel(
    timestamp: json["timestamp"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? [] : List<RegionList>.from(json["data"]!.map((x) => RegionList.fromJson(x))),
    message: json["message"],
    details: json["details"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp,
    "statusCode": statusCode,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "details": details,
    "status": status,
  };
}

class RegionList {
  int? regionId;
  int? districtId;
  String? nameEng;
  String? nameChi;
  String? nameChiSim;
  bool? deleted;
  bool? active;

  RegionList({
    this.regionId,
    this.districtId,
    this.nameEng,
    this.nameChi,
    this.nameChiSim,
    this.deleted,
    this.active,
  });

  factory RegionList.fromJson(Map<String, dynamic> json) => RegionList(
    regionId: json["regionId"],
    districtId: json["districtId"],
    nameEng: json["nameEng"],
    nameChi: json["nameChi"],
    nameChiSim: json["nameChiSim"],
    deleted: json["deleted"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "regionId": regionId,
    "districtId": districtId,
    "nameEng": nameEng,
    "nameChi": nameChi,
    "nameChiSim": nameChiSim,
    "deleted": deleted,
    "active": active,
  };
}
