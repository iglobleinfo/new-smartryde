import 'dart:developer';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  late MqttServerClient _client;
  // final String _broker = 'broker.hivemq.com';
  final String _topic = 'flutter/test';
  // final String _broker = 'hk.igloble.com';
  final String _broker = 'pubsub.iotasmart.com';
  final String _username = 'consumer';
  // final String _password = 'kcis123';
  final String _password = 'iotaSmart@7890';
  final String clientId = 'clientId-${DateTime.now().millisecondsSinceEpoch}';

  Future<void> connect() async {
    try {
      _client = MqttServerClient(_broker, clientId);
      _client.port = 1883;
      _client.keepAlivePeriod = 60;
      _client.logging(on: true);
      _client.setProtocolV311();
      _client.autoReconnect = true;
      _client.onConnected = _onConnected;
      _client.onDisconnected = _onDisconnected;
      _client.onSubscribed = _onSubscribed;
      log('Connecting to MQTT broker...');
      // await _client.connect();
      await _client.connect(_username, _password);
    } catch (e) {
      log('Connection failed: $e');
      _client.disconnect();
    }

    _client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      if (c == null || c.isEmpty) {
        log('No messages received');
        return;
      }
      final MqttPublishMessage? message = c[0].payload as MqttPublishMessage?;
      final String payload = MqttPublishPayload.bytesToStringAsString(
        message!.payload.message,
      );
      log('Received message: $payload');
    });
  }

  void _subscribeToTopic() {
    _client.subscribe(_topic, MqttQos.atMostOnce);
    log('Subscribed to topic: $_topic');
  }

  void _onConnected() {
    log('Connected To MQTT broker');
    _subscribeToTopic();
  }

  void _onDisconnected() {
    log('Disconnected from MQTT broker');
  }

  void _onSubscribed(String topic) {
    log('Subscribed to topic: $topic');
  }

  void publish(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client.publishMessage(_topic, MqttQos.atMostOnce, builder.payload!);
    log('Published message: $message');
  }

  void disconnect() {
    _client.disconnect();
    log('Disconnected from MQTT broker');
  }
}
