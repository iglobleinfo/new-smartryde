// To parse this JSON data, do
//
//     final busListResponseModel = busListResponseModelFromJson(jsonString);

import 'dart:convert';

BusListResponseModel busListResponseModelFromJson(String str) => BusListResponseModel.fromJson(json.decode(str));

String busListResponseModelToJson(BusListResponseModel data) => json.encode(data.toJson());

class BusListResponseModel {
  String? timestamp;
  int? statusCode;
  BusData? data;
  String? message;
  String? details;
  bool? status;

  BusListResponseModel({
    this.timestamp,
    this.statusCode,
    this.data,
    this.message,
    this.details,
    this.status,
  });

  factory BusListResponseModel.fromJson(Map<String, dynamic> json) => BusListResponseModel(
    timestamp: json["timestamp"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? null : BusData.fromJson(json["data"]),
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

class BusData {
  List<BusList>? busList;
  bool? bookmark;

  BusData({
    this.busList,
    this.bookmark,
  });

  factory BusData.fromJson(Map<String, dynamic> json) => BusData(
    busList: json["busList"] == null ? [] : List<BusList>.from(json["busList"]!.map((x) => BusList.fromJson(x))),
    bookmark: json["bookmark"],
  );

  Map<String, dynamic> toJson() => {
    "busList": busList == null ? [] : List<dynamic>.from(busList!.map((x) => x.toJson())),
    "bookmark": bookmark,
  };
}

class BusList {
  int? id;
  int? timeTableId;
  String? driverId;
  String? busNumber;
  int? routeId;
  String? deptNo;
  bool? tripStart;
  bool? tripEnd;
  bool? deleted;
  String? enRouteName;
  String? chRouteName;
  String? enDriverName;
  String? chDriverName;
  DateTime? deptTime;
  DateTime? creatingTime;
  int? totalSeat;
  int? crrTotalSeat;
  String? colorCode;
  int? numberOfBooking;
  int? adjusttedTime;
  String? fromStopTime;
  String? iotaSmartDeviceId;

  BusList({
    this.id,
    this.timeTableId,
    this.driverId,
    this.busNumber,
    this.routeId,
    this.deptNo,
    this.tripStart,
    this.tripEnd,
    this.deleted,
    this.enRouteName,
    this.chRouteName,
    this.enDriverName,
    this.chDriverName,
    this.deptTime,
    this.creatingTime,
    this.totalSeat,
    this.crrTotalSeat,
    this.colorCode,
    this.numberOfBooking,
    this.adjusttedTime,
    this.fromStopTime,
    this.iotaSmartDeviceId,
  });

  factory BusList.fromJson(Map<String, dynamic> json) => BusList(
    id: json["id"],
    timeTableId: json["timeTableId"],
    driverId: json["driverId"],
    busNumber: json["busNumber"],
    routeId: json["routeId"],
    deptNo: json["deptNo"],
    tripStart: json["tripStart"],
    tripEnd: json["tripEnd"],
    deleted: json["deleted"],
    enRouteName: json["enRouteName"],
    chRouteName: json["chRouteName"],
    enDriverName: json["enDriverName"],
    chDriverName: json["chDriverName"],
    deptTime: json["deptTime"] == null ? null : DateTime.parse(json["deptTime"]),
    creatingTime: json["creatingTime"] == null ? null : DateTime.parse(json["creatingTime"]),
    totalSeat: json["totalSeat"],
    crrTotalSeat: json["crrTotalSeat"],
    colorCode: json["colorCode"],
    numberOfBooking: json["numberOfBooking"],
    adjusttedTime: json["adjusttedTime"],
    fromStopTime: json["fromStopTime"],
    iotaSmartDeviceId: json["iotaSmartDeviceId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "timeTableId": timeTableId,
    "driverId": driverId,
    "busNumber": busNumber,
    "routeId": routeId,
    "deptNo": deptNo,
    "tripStart": tripStart,
    "tripEnd": tripEnd,
    "deleted": deleted,
    "enRouteName": enRouteName,
    "chRouteName": chRouteName,
    "enDriverName": enDriverName,
    "chDriverName": chDriverName,
    "deptTime": deptTime?.toIso8601String(),
    "creatingTime": creatingTime?.toIso8601String(),
    "totalSeat": totalSeat,
    "crrTotalSeat": crrTotalSeat,
    "colorCode": colorCode,
    "numberOfBooking": numberOfBooking,
    "adjusttedTime": adjusttedTime,
    "fromStopTime": fromStopTime,
    "iotaSmartDeviceId": iotaSmartDeviceId,
  };
}
