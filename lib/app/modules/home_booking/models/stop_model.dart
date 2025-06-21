// To parse this JSON data, do
//
//     final stopResponseModel = stopResponseModelFromJson(jsonString);

import 'dart:convert';

StopResponseModel stopResponseModelFromJson(String str) => StopResponseModel.fromJson(json.decode(str));

String stopResponseModelToJson(StopResponseModel data) => json.encode(data.toJson());

class StopResponseModel {
  String? timestamp;
  int? statusCode;
  List<StopList>? data;
  String? message;
  String? details;
  bool? status;

  StopResponseModel({
    this.timestamp,
    this.statusCode,
    this.data,
    this.message,
    this.details,
    this.status,
  });

  factory StopResponseModel.fromJson(Map<String, dynamic> json) => StopResponseModel(
    timestamp: json["timestamp"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? [] : List<StopList>.from(json["data"]!.map((x) => StopList.fromJson(x))),
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

class StopList {
  int? id;
  int? districtId;
  int? regionId;
  String? chName;
  String? schName;
  double? latitude;
  double? longitude;
  int? radius;
  String? deptTime;
  DateTime? creatingTime;
  bool? deleted;
  bool? active;
  String? ename;

  StopList({
    this.id,
    this.districtId,
    this.regionId,
    this.chName,
    this.schName,
    this.latitude,
    this.longitude,
    this.radius,
    this.deptTime,
    this.creatingTime,
    this.deleted,
    this.active,
    this.ename,
  });

  factory StopList.fromJson(Map<String, dynamic> json) => StopList(
    id: json["id"],
    districtId: json["districtId"],
    regionId: json["regionId"],
    chName: json["chName"],
    schName: json["schName"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    radius: json["radius"],
    deptTime: json["deptTime"],
    creatingTime: json["creatingTime"] == null ? null : DateTime.parse(json["creatingTime"]),
    deleted: json["deleted"],
    active: json["active"],
    ename: json["ename"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "districtId": districtId,
    "regionId": regionId,
    "chName": chName,
    "schName": schName,
    "latitude": latitude,
    "longitude": longitude,
    "radius": radius,
    "deptTime": deptTime,
    "creatingTime": creatingTime?.toIso8601String(),
    "deleted": deleted,
    "active": active,
    "ename": ename,
  };
}
