// To parse this JSON data, do
//
//     final bookingResponseModel = bookingResponseModelFromJson(jsonString);

import 'dart:convert';

BookingResponseModel bookingResponseModelFromJson(String str) => BookingResponseModel.fromJson(json.decode(str));

String bookingResponseModelToJson(BookingResponseModel data) => json.encode(data.toJson());

class BookingResponseModel {
  String? timestamp;
  int? statusCode;
  BookingData? data;
  String? message;
  String? details;
  bool? status;

  BookingResponseModel({
    this.timestamp,
    this.statusCode,
    this.data,
    this.message,
    this.details,
    this.status,
  });

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) => BookingResponseModel(
    timestamp: json["timestamp"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? null : BookingData.fromJson(json["data"]),
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

class BookingData {
  List<Content>? content;
  Pageable? pageable;
  int? totalPages;
  int? totalElements;
  bool? last;
  bool? first;
  Sort? sort;
  int? numberOfElements;
  int? size;
  int? number;
  bool? empty;

  BookingData({
    this.content,
    this.pageable,
    this.totalPages,
    this.totalElements,
    this.last,
    this.first,
    this.sort,
    this.numberOfElements,
    this.size,
    this.number,
    this.empty,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
    content: json["content"] == null ? [] : List<Content>.from(json["content"]!.map((x) => Content.fromJson(x))),
    pageable: json["pageable"] == null ? null : Pageable.fromJson(json["pageable"]),
    totalPages: json["totalPages"],
    totalElements: json["totalElements"],
    last: json["last"],
    first: json["first"],
    sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
    numberOfElements: json["numberOfElements"],
    size: json["size"],
    number: json["number"],
    empty: json["empty"],
  );

  Map<String, dynamic> toJson() => {
    "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
    "pageable": pageable?.toJson(),
    "totalPages": totalPages,
    "totalElements": totalElements,
    "last": last,
    "first": first,
    "sort": sort?.toJson(),
    "numberOfElements": numberOfElements,
    "size": size,
    "number": number,
    "empty": empty,
  };
}

class Content {
  int? ticketId;
  int? tripRecordId;
  var totalPrice;
  var totalSeat;
  String? busNumber;
  int? fromStopId;
  String? fromEng;
  int? toStopId;
  String? toEng;
  String? fromCh;
  String? toCh;
  DateTime? bookingTime;
  DateTime? deptTime;
  var deptNo;
  bool? canceled;
  double? fromLat;
  var toLat;
  double? fromLng;
  double? toLng;
  bool? tripEnd;
  String? refrenceNumber;
  var colorCode;
  int? adjusttedTime;
  String? fromChSim;
  String? toChSim;
  int? routeId;

  Content({
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

  factory Content.fromJson(Map<String, dynamic> json) => Content(
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
    colorCode: colorCodeValues.map[json["colorCode"]]!,
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
    "toEng": toEngValues.reverse[toEng],
    "fromCh": fromChValues.reverse[fromCh],
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
    "colorCode": colorCodeValues.reverse[colorCode],
    "adjusttedTime": adjusttedTime,
    "fromChSim": fromChValues.reverse[fromChSim],
    "toChSim": toChSim,
    "routeId": routeId,
  };
}

enum ColorCode {
  ED5_F88,
  F9_A808,
  THE_5_BD6_C1
}

final colorCodeValues = EnumValues({
  "#ed5f88": ColorCode.ED5_F88,
  "#f9a808": ColorCode.F9_A808,
  "#5bd6c1": ColorCode.THE_5_BD6_C1
});

enum DeptNo {
  AN1_S142255,
  AN1_S142325,
  AN2_S141640,
  AN2_S141710
}

final deptNoValues = EnumValues({
  "AN1S142255": DeptNo.AN1_S142255,
  "AN1S142325": DeptNo.AN1_S142325,
  "AN2S141640": DeptNo.AN2_S141640,
  "AN2S141710": DeptNo.AN2_S141710
});

enum FromCh {
  EMPTY,
  FROM_CH,
  PURPLE,
  THE_2
}

final fromChValues = EnumValues({
  "恆麗園": FromCh.EMPTY,
  "??????": FromCh.FROM_CH,
  "???": FromCh.PURPLE,
  "??? / ????2?": FromCh.THE_2
});

enum ToEng {
  MEI_FOO_STATION,
  SERENADE_COVE_BELVEDERE_GARDEN_PHASE_1,
  TAI_NAN_WEST_STREET_LAWS_COMMERCIAL_PLAZA,
  TSUEN_WAN_GOVERNMENT_PRIMARY_SCHOOL
}

final toEngValues = EnumValues({
  "Mei Foo Station": ToEng.MEI_FOO_STATION,
  "Serenade Cove / Belvedere Garden Phase 1": ToEng.SERENADE_COVE_BELVEDERE_GARDEN_PHASE_1,
  "Tai Nan West Street / Laws Commercial Plaza": ToEng.TAI_NAN_WEST_STREET_LAWS_COMMERCIAL_PLAZA,
  "Tsuen Wan Government Primary School": ToEng.TSUEN_WAN_GOVERNMENT_PRIMARY_SCHOOL
});

class Pageable {
  Sort? sort;
  int? pageNumber;
  int? pageSize;
  int? offset;
  bool? unpaged;
  bool? paged;

  Pageable({
    this.sort,
    this.pageNumber,
    this.pageSize,
    this.offset,
    this.unpaged,
    this.paged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
    sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
    pageNumber: json["pageNumber"],
    pageSize: json["pageSize"],
    offset: json["offset"],
    unpaged: json["unpaged"],
    paged: json["paged"],
  );

  Map<String, dynamic> toJson() => {
    "sort": sort?.toJson(),
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "offset": offset,
    "unpaged": unpaged,
    "paged": paged,
  };
}

class Sort {
  bool? sorted;
  bool? unsorted;
  bool? empty;

  Sort({
    this.sorted,
    this.unsorted,
    this.empty,
  });

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
    sorted: json["sorted"],
    unsorted: json["unsorted"],
    empty: json["empty"],
  );

  Map<String, dynamic> toJson() => {
    "sorted": sorted,
    "unsorted": unsorted,
    "empty": empty,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
