// To parse this JSON data, do
//
//     final bookmarkListResponseModel = bookmarkListResponseModelFromJson(jsonString);

import 'dart:convert';

BookmarkListResponseModel bookmarkListResponseModelFromJson(String str) => BookmarkListResponseModel.fromJson(json.decode(str));

String bookmarkListResponseModelToJson(BookmarkListResponseModel data) => json.encode(data.toJson());

class BookmarkListResponseModel {
  String? timestamp;
  var statusCode;
  List<BookmarkList>? data;
  String? message;
  String? details;
  bool? status;

  BookmarkListResponseModel({
    this.timestamp,
    this.statusCode,
    this.data,
    this.message,
    this.details,
    this.status,
  });

  factory BookmarkListResponseModel.fromJson(Map<String, dynamic> json) => BookmarkListResponseModel(
    timestamp: json["timestamp"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? [] : List<BookmarkList>.from(json["data"]!.map((x) => BookmarkList.fromJson(x))),
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

class BookmarkList {
  var id;
  var userId;
  var routeId;
  String? enRouteName;
  String? chRouteName;
  String? schRouteName;
  String? fromStopEnName;
  String? fromStopChName;
  String? fromStopSchName;
  String? toStopEnName;
  String? toStopChName;
  String? toStopSchName;
  var fromStopId;
  var toStopId;
  var pickupStopLat;
  var pickupStopLon;
  var currentLat;
  var currentLon;
  bool? deleted;

  BookmarkList({
    this.id,
    this.userId,
    this.routeId,
    this.enRouteName,
    this.chRouteName,
    this.schRouteName,
    this.fromStopEnName,
    this.fromStopChName,
    this.fromStopSchName,
    this.toStopEnName,
    this.toStopChName,
    this.toStopSchName,
    this.fromStopId,
    this.toStopId,
    this.pickupStopLat,
    this.pickupStopLon,
    this.currentLat,
    this.currentLon,
    this.deleted,
  });

  factory BookmarkList.fromJson(Map<String, dynamic> json) => BookmarkList(
    id: json["id"],
    userId: json["userId"],
    routeId: json["routeId"],
    enRouteName: json["enRouteName"],
    chRouteName: json["chRouteName"],
    schRouteName: json["schRouteName"],
    fromStopEnName: json["fromStopEnName"],
    fromStopChName: json["fromStopChName"],
    fromStopSchName: json["fromStopSchName"],
    toStopEnName: json["toStopEnName"],
    toStopChName: json["toStopChName"],
    toStopSchName: json["toStopSchName"],
    fromStopId: json["fromStopId"],
    toStopId: json["toStopId"],
    pickupStopLat: json["pickupStopLat"],
    pickupStopLon: json["pickupStopLon"],
    currentLat: json["currentLat"],
    currentLon: json["currentLon"],
    deleted: json["deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "routeId": routeId,
    "enRouteName": enRouteName,
    "chRouteName": chRouteName,
    "schRouteName": schRouteName,
    "fromStopEnName": fromStopEnName,
    "fromStopChName": fromStopChName,
    "fromStopSchName": fromStopSchName,
    "toStopEnName": toStopEnName,
    "toStopChName": toStopChName,
    "toStopSchName": toStopSchName,
    "fromStopId": fromStopId,
    "toStopId": toStopId,
    "pickupStopLat": pickupStopLat,
    "pickupStopLon": pickupStopLon,
    "currentLat": currentLat,
    "currentLon": currentLon,
    "deleted": deleted,
  };
}
