class TrackData {
  double? lat;
  double? lon;
  bool? isTripRunning;

  TrackData({this.lat, this.lon, this.isTripRunning});

  TrackData.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    isTripRunning = json['isTripRunning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['isTripRunning'] = isTripRunning;
    return data;
  }
}
