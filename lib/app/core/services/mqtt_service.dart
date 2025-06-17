import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smart_ryde/app/modules/live_tracking/model/hkglobal_data.dart';
import 'package:smart_ryde/app/modules/live_tracking/model/smart_ryde_data.dart';



class MqttService {
  MqttServerClient? _client;

  // stream controller for mqtt data
  final StreamController<TrackData> _hkStreamController =
      StreamController<TrackData>.broadcast();
  // stream for mqtt data
  final StreamController<SmartRydeData> _sRStreamController =
      StreamController<SmartRydeData>.broadcast();

  // stream for outside listening
  Stream<TrackData> get hkStreamData => _hkStreamController.stream;
  Stream<SmartRydeData> get sRStreamData => _sRStreamController.stream;

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
          log('Received message on topic ${c[0].topic}: $message');   
          if(iotaId == '0'){
            SmartRydeData smartRydeData = SmartRydeData.fromJson(jsonDecode(message));
            log('smartRydeData ${smartRydeData.toJson()}');
            _sRStreamController.add(smartRydeData);
          }else{
            log('Received message on topic ${c[0].topic}: $message');
            _hkStreamController.add(TrackData.fromJson(jsonDecode(message)));
          }
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
    _hkStreamController.close();
    _sRStreamController.close();
    _client?.disconnect();
  }
}
