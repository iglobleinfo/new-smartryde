class BusDetailResponse {
  String? timestamp;
  int? statusCode;
  Data? data;
  String? message;
  String? details;
  bool? status;

  BusDetailResponse(
      {this.timestamp,
      this.statusCode,
      this.data,
      this.message,
      this.details,
      this.status});

  BusDetailResponse.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    details = json['details'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['details'] = details;
    data['status'] = status;
    return data;
  }
}

class Data {
  String? busNumber;
  String? remark;
  String? createTime;
  int? totalSeat;
  String? iotaSmartDeviceId;
  bool? deleted;
  bool? active;

  Data(
      {this.busNumber,
      this.remark,
      this.createTime,
      this.totalSeat,
      this.iotaSmartDeviceId,
      this.deleted,
      this.active});

  Data.fromJson(Map<String, dynamic> json) {
    busNumber = json['busNumber'];
    remark = json['remark'];
    createTime = json['createTime'];
    totalSeat = json['totalSeat'];
    iotaSmartDeviceId = json['iotaSmartDeviceId'];
    deleted = json['deleted'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['busNumber'] = busNumber;
    data['remark'] = remark;
    data['createTime'] = createTime;
    data['totalSeat'] = totalSeat;
    data['iotaSmartDeviceId'] = iotaSmartDeviceId;
    data['deleted'] = deleted;
    data['active'] = active;
    return data;
  }
}
