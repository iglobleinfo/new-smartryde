class LiveTrackingResponse {
  int? id;
  String? name;
  int? ownerId;
  String? driverName;
  String? uniqueId;
  String? status;
  String? lastUpdate;
  int? groupId;
  var motion;
  String? carType;
  String? carMake;
  String? carModel;
  String? carImageUrl;
  int? engineCc;
  int? codometer;
  bool? active;
  String? expireDate;
  bool? hasDtc;
  String? fuelType;
  String? lastGps;
  Null lastPid;
  Null lastDtc;
  Null lastSnap;
  bool? ota;
  bool? geofenceEnable;
  int? targetPerDay;
  int? fuelTankL;
  double? dRating;
  String? phoneNo;
  String? createdDate;
  int? planType;
  double? lat;
  double? lng;
  String? lastAddress;
  bool? parking;
  String? lastGpsTime;
  bool? powerCut;
  int? port;
  int? productId;
  VehicleDetails? vehicleDetails;
  bool? gpsOnly;

  LiveTrackingResponse(
      {this.id,
      this.name,
      this.ownerId,
      this.driverName,
      this.uniqueId,
      this.status,
      this.lastUpdate,
      this.groupId,
      this.motion,
      this.carType,
      this.carMake,
      this.carModel,
      this.carImageUrl,
      this.engineCc,
      this.codometer,
      this.active,
      this.expireDate,
      this.hasDtc,
      this.fuelType,
      this.lastGps,
      this.lastPid,
      this.lastDtc,
      this.lastSnap,
      this.ota,
      this.geofenceEnable,
      this.targetPerDay,
      this.fuelTankL,
      this.dRating,
      this.phoneNo,
      this.createdDate,
      this.planType,
      this.lat,
      this.lng,
      this.lastAddress,
      this.parking,
      this.lastGpsTime,
      this.powerCut,
      this.port,
      this.productId,
      this.vehicleDetails,
      this.gpsOnly});

  LiveTrackingResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ownerId = json['ownerId'];
    driverName = json['driverName'];
    uniqueId = json['uniqueId'];
    status = json['status'];
    lastUpdate = json['lastUpdate'];
    groupId = json['groupId'];
    motion = json['motion'];
    carType = json['carType'];
    carMake = json['carMake'];
    carModel = json['carModel'];
    carImageUrl = json['carImageUrl'];
    engineCc = json['engineCc'];
    codometer = json['codometer'];
    active = json['active'];
    expireDate = json['expireDate'];
    hasDtc = json['hasDtc'];
    fuelType = json['fuelType'];
    lastGps = json['lastGps'];
    lastPid = json['lastPid'];
    lastDtc = json['lastDtc'];
    lastSnap = json['lastSnap'];
    ota = json['ota'];
    geofenceEnable = json['geofenceEnable'];
    targetPerDay = json['targetPerDay'];
    fuelTankL = json['fuelTankL'];
    dRating = json['dRating'];
    phoneNo = json['phoneNo'];
    createdDate = json['createdDate'];
    planType = json['planType'];
    lat = json['lat'];
    lng = json['lng'];
    lastAddress = json['lastAddress'];
    parking = json['parking'];
    lastGpsTime = json['lastGpsTime'];
    powerCut = json['powerCut'];
    port = json['port'];
    productId = json['productId'];
    vehicleDetails = json['vehicleDetails'] != null
        ? new VehicleDetails.fromJson(json['vehicleDetails'])
        : null;
    gpsOnly = json['gpsOnly'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['ownerId'] = ownerId;
    data['driverName'] = driverName;
    data['uniqueId'] = uniqueId;
    data['status'] = status;
    data['lastUpdate'] = lastUpdate;
    data['groupId'] = groupId;
    data['motion'] = motion;
    data['carType'] = carType;
    data['carMake'] = carMake;
    data['carModel'] = carModel;
    data['carImageUrl'] = carImageUrl;
    data['engineCc'] = engineCc;
    data['codometer'] = codometer;
    data['active'] = active;
    data['expireDate'] = expireDate;
    data['hasDtc'] = hasDtc;
    data['fuelType'] = fuelType;
    data['lastGps'] = lastGps;
    data['lastPid'] = lastPid;
    data['lastDtc'] = lastDtc;
    data['lastSnap'] = lastSnap;
    data['ota'] = ota;
    data['geofenceEnable'] = geofenceEnable;
    data['targetPerDay'] = targetPerDay;
    data['fuelTankL'] = fuelTankL;
    data['dRating'] = dRating;
    data['phoneNo'] = phoneNo;
    data['createdDate'] = createdDate;
    data['planType'] = planType;
    data['lat'] = lat;
    data['lng'] = lng;
    data['lastAddress'] = lastAddress;
    data['parking'] = parking;
    data['lastGpsTime'] = lastGpsTime;
    data['powerCut'] = powerCut;
    data['port'] = port;
    data['productId'] = productId;
    if (vehicleDetails != null) {
      data['vehicleDetails'] = vehicleDetails!.toJson();
    }
    data['gpsOnly'] = gpsOnly;
    return data;
  }
}

class VehicleDetails {
  int? deviceId;
  int? ownerId;
  String? purchageDate;
  var engineNumber;
  var chasisNumber;
  String? modelYear;
  var subType;
  var conditionalStatus;
  var operationalStatus;
  var zone;

  VehicleDetails(
      {this.deviceId,
      this.ownerId,
      this.purchageDate,
      this.engineNumber,
      this.chasisNumber,
      this.modelYear,
      this.subType,
      this.conditionalStatus,
      this.operationalStatus,
      this.zone});

  VehicleDetails.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    ownerId = json['ownerId'];
    purchageDate = json['purchageDate'];
    engineNumber = json['engineNumber'];
    chasisNumber = json['chasisNumber'];
    modelYear = json['modelYear'];
    subType = json['subType'];
    conditionalStatus = json['conditionalStatus'];
    operationalStatus = json['operationalStatus'];
    zone = json['zone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceId'] = deviceId;
    data['ownerId'] = ownerId;
    data['purchageDate'] = purchageDate;
    data['engineNumber'] = engineNumber;
    data['chasisNumber'] = chasisNumber;
    data['modelYear'] = modelYear;
    data['subType'] = subType;
    data['conditionalStatus'] = conditionalStatus;
    data['operationalStatus'] = operationalStatus;
    data['zone'] = zone;
    return data;
  }
}
