import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

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

class MqttService {
  MqttServerClient? _client;

  // stream controller for mqtt data
  final StreamController<TrackData> _mqttStreamData =
      StreamController<TrackData>();

  // stream for outside listening
  Stream<TrackData> get mqttMessages => _mqttStreamData.stream;

  Future<void> connect(String iotaId, String busNumber) async {
    String topic;
    if (iotaId == '0') {
      _client = MqttServerClient('hk.igloble.com', '');
      topic = busNumber;
    } else {
      _client = MqttServerClient('52.66.130.18', '');
      topic = iotaId;
    }

    _client?.port = 1883;
    _client?.logging(on: true);
    _client?.keepAlivePeriod = 20;
    _client?.onDisconnected = onDisconnected;
    _client?.onConnected = onConnected;
    _client?.onSubscribed = onSubscribed;
    _client?.pongCallback = pong;

    _client?.connectionMessage = MqttConnectMessage()
        .withClientIdentifier(
            'flutter_client_${DateTime.now().millisecondsSinceEpoch}')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    try {
      await _client?.connect();
    } catch (e) {
      log('MQTT connection error: $e');
      _client?.disconnect();
    }

    if (_client?.connectionStatus?.state == MqttConnectionState.connected) {
      log('MQTT Connected');
      _client?.subscribe(topic, MqttQos.atLeastOnce);
      _client?.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        if (c.isNotEmpty) {
          final recMess = c[0].payload as MqttPublishMessage;
          String message =
              MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
          TrackData trackData = TrackData.fromJson(jsonDecode(message));
          log('trackData ${trackData.toJson()}');
          _mqttStreamData.add(trackData);
        }
      });
    } else {
      log('Connection failed: ${_client?.connectionStatus}');
      _client?.disconnect();
    }
  }

  void onDisconnected() {
    log('MQTT Disconnected');
  }

  void onConnected() {
    log('MQTT Connected Callback');
  }

  void onSubscribed(String topic) {
    log('Subscribed to $topic');
  }

  void pong() {
    log('Ping response received');
  }

  void disconnectClient() {
    _mqttStreamData.close();
    _client?.disconnect();
  }
}
