// To parse this JSON data, do
//
//     final bookingListResponse = bookingListResponseFromJson(jsonString);

import 'dart:convert';

BookingListResponse bookingListResponseFromJson(String str) => BookingListResponse.fromJson(json.decode(str));

String bookingListResponseToJson(BookingListResponse data) => json.encode(data.toJson());

class BookingListResponse {
  var timestamp;
  var statusCode;
  List<BookingList>? data;
  var message;
  var details;
  bool? status;

  BookingListResponse({
    this.timestamp,
    this.statusCode,
    this.data,
    this.message,
    this.details,
    this.status,
  });

  factory BookingListResponse.fromJson(Map<String, dynamic> json) => BookingListResponse(
    timestamp: json["timestamp"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? [] : List<BookingList>.from(json["data"]!.map((x) => BookingList.fromJson(x))),
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

class BookingList {
  var ticketId;
  var tripRecordId;
  var totalPrice;
  var totalSeat;
  var busNumber;
  var fromStopId;
  var fromEng;
  var toStopId;
  var toEng;
  var fromCh;
  var toCh;
  DateTime? bookingTime;
  DateTime? deptTime;
  var deptNo;
  bool? canceled;
  double? fromLat;
  var toLat;
  double? fromLng;
  double? toLng;
  bool? tripEnd;
  var refrenceNumber;
  var colorCode;
  var adjusttedTime;
  var fromChSim;
  var toChSim;
  var routeId;

  BookingList({
    this.ticketId,
    this.tripRecordId,
    this.totalPrice,
    this.totalSeat,
    this.busNumber,
    this.fromStopId,
    this.fromEng,
    this.toStopId,
    this.toEng,
    this.fromCh,
    this.toCh,
    this.bookingTime,
    this.deptTime,
    this.deptNo,
    this.canceled,
    this.fromLat,
    this.toLat,
    this.fromLng,
    this.toLng,
    this.tripEnd,
    this.refrenceNumber,
    this.colorCode,
    this.adjusttedTime,
    this.fromChSim,
    this.toChSim,
    this.routeId,
  });

  factory BookingList.fromJson(Map<String, dynamic> json) => BookingList(
    ticketId: json["ticketId"],
    tripRecordId: json["tripRecordId"],
    totalPrice: json["totalPrice"],
    totalSeat: json["totalSeat"],
    busNumber: json["busNumber"],
    fromStopId: json["fromStopId"],
    fromEng: json["fromEng"],
    toStopId: json["toStopId"],
    toEng: json["toEng"],
    fromCh: json["fromCh"],
    toCh: json["toCh"],
    bookingTime: json["bookingTime"] == null ? null : DateTime.parse(json["bookingTime"]),
    deptTime: json["deptTime"] == null ? null : DateTime.parse(json["deptTime"]),
    deptNo: json["deptNo"],
    canceled: json["canceled"],
    fromLat: json["fromLat"]?.toDouble(),
    toLat: json["toLat"],
    fromLng: json["fromLng"]?.toDouble(),
    toLng: json["toLng"]?.toDouble(),
    tripEnd: json["tripEnd"],
    refrenceNumber: json["refrenceNumber"],
    colorCode: json["colorCode"],
    adjusttedTime: json["adjusttedTime"],
    fromChSim: json["fromChSim"],
    toChSim: json["toChSim"],
    routeId: json["routeId"],
  );

  Map<String, dynamic> toJson() => {
    "ticketId": ticketId,
    "tripRecordId": tripRecordId,
    "totalPrice": totalPrice,
    "totalSeat": totalSeat,
    "busNumber": busNumber,
    "fromStopId": fromStopId,
    "fromEng": fromEng,
    "toStopId": toStopId,
    "toEng": toEng,
    "fromCh": fromCh,
    "toCh": toCh,
    "bookingTime": bookingTime?.toIso8601String(),
    "deptTime": deptTime?.toIso8601String(),
    "deptNo": deptNo,
    "canceled": canceled,
    "fromLat": fromLat,
    "toLat": toLat,
    "fromLng": fromLng,
    "toLng": toLng,
    "tripEnd": tripEnd,
    "refrenceNumber": refrenceNumber,
    "colorCode": colorCode,
    "adjusttedTime": adjusttedTime,
    "fromChSim": fromChSim,
    "toChSim": toChSim,
    "routeId": routeId,
  };
}
