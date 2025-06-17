class SmartRydeData {
  int? id;
  String? name;
  String? uniqueId;
  int? ownerId;
  String? status;
  int? hasDtc;
  int? lastUpdate;
  int? lastAccOn;
  int? lastGpsTime;
  int? groupId;
  String? carType;
  String? driverName;
  bool? isGpsOnly;
  LastGps? lastGps;

  SmartRydeData({
    this.id,
    this.name,
    this.uniqueId,
    this.ownerId,
    this.status,
    this.hasDtc,
    this.lastUpdate,
    this.lastAccOn,
    this.lastGpsTime,
    this.groupId,
    this.carType,
    this.driverName,
    this.isGpsOnly,
    this.lastGps,
  });

  SmartRydeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    uniqueId = json['uniqueId'];
    ownerId = json['ownerId'];
    status = json['status'];
    hasDtc = json['hasDtc'];
    lastUpdate = json['lastUpdate'];
    lastAccOn = json['lastAccOn'];
    lastGpsTime = json['lastGpsTime'];
    groupId = json['groupId'];
    carType = json['carType'];
    driverName = json['driverName'];
    isGpsOnly = json['is_Gps_Only'];
    lastGps =
        json['lastGps'] != null ? LastGps.fromJson(json['lastGps']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['uniqueId'] = uniqueId;
    data['ownerId'] = ownerId;
    data['status'] = status;
    data['hasDtc'] = hasDtc;
    data['lastUpdate'] = lastUpdate;
    data['lastAccOn'] = lastAccOn;
    data['lastGpsTime'] = lastGpsTime;
    data['groupId'] = groupId;
    data['carType'] = carType;
    data['driverName'] = driverName;
    data['is_Gps_Only'] = isGpsOnly;
    if (lastGps != null) {
      data['lastGps'] = lastGps!.toJson();
    }
    return data;
  }
}

class LastGps {
  Lastgps? lastgps;

  LastGps({this.lastgps});

  LastGps.fromJson(Map<String, dynamic> json) {
    lastgps =
        json['lastgps'] != null ? Lastgps.fromJson(json['lastgps']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lastgps != null) {
      data['lastgps'] = lastgps!.toJson();
    }
    return data;
  }
}

class Lastgps {
  double? latitude;
  double? longitude;

  Lastgps({this.latitude, this.longitude});

  Lastgps.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
