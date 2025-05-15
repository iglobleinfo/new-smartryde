// import 'dart:math';
//
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';
//
// class MqttService {
//   late MqttServerClient mqttClient;
//   final String broker = 'pubsub.iotasmart.com';
//   final int port = 443;
//   final String username = 'consumer';
//   final String password = 'iotaSmart@7890';
//   final List<String> deviceList = []; // Add your device IDs here
//   final String clientId = 'clientId-${Random().nextInt(6000) + 1}';
//
//   void connectToBroker() async {
//     print('connect to broker function');
//     mqttClient = MqttServerClient.withPort(
//       broker,
//       clientId,
//       port,
//     );
//     mqttClient.secure = true;
//     mqttClient.logging(on: false);
//     mqttClient.keepAlivePeriod = 50;
//     mqttClient.setProtocolV311();
//     mqttClient.onDisconnected = onDisconnected;
//     mqttClient.onConnected = onConnected;
//     mqttClient.onSubscribed = onSubscribed;
//     mqttClient.onUnsubscribed = onUnsubscribed;
//     mqttClient.onSubscribeFail = onSubscribeFail;
//
//     final connMessage = MqttConnectMessage()
//         .withClientIdentifier(clientId)
//         .withWillTopic('willtopic')
//         .withWillMessage('My Will message')
//         .authenticateAs(username, password)
//         .withWillQos(MqttQos.atLeastOnce);
//
//     mqttClient.connectionMessage = connMessage;
//
//     try {
//       await mqttClient.connect();
//     } catch (e) {
//       print('Connection Exception: $e');
//       disconnectFromBroker();
//     }
//
//     mqttClient.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
//       final recMess = c![0].payload as MqttPublishMessage;
//       final pt =
//           MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
//
//       print('Message arrived: topic=<${c[0].topic}>, payload=<$pt>');
//       updateLiveData(pt);
//     });
//   }
//
//   void onConnected() {
//     print('Connected to broker.');
//     subscribeDevices();
//   }
//
//   void onDisconnected() {
//     print('Connection lost, reconnecting...');
//     connectToBroker();
//   }
//
//   void onSubscribed(String topic) {
//     print('Subscribed to topic: $topic');
//   }
//
//   void onUnsubscribed(String? topic) {
//     print('Unsubscribed from topic: $topic');
//   }
//
//   void onSubscribeFail(String topic) {
//     print('Failed to subscribe to topic: $topic');
//   }
//
//   void subscribeDevices() {
//     for (var deviceId in deviceList) {
//       subscribeToTopic(deviceId);
//     }
//   }
//
//   void subscribeToTopic(String topicName) {
//     if (mqttClient.connectionStatus?.state == MqttConnectionState.connected) {
//       mqttClient.subscribe(topicName, MqttQos.atLeastOnce);
//     }
//   }
//
//   void unsubscribeDevices() {
//     print('Unsubscribing from all devices...');
//     for (var deviceId in deviceList) {
//       unsubscribeToTopic(deviceId);
//     }
//   }
//
//   void unsubscribeToTopic(String topicName) {
//     if (mqttClient.connectionStatus?.state == MqttConnectionState.connected) {
//       mqttClient.unsubscribe(topicName);
//     }
//   }
//
//   void disconnectFromBroker() {
//     if (mqttClient.connectionStatus?.state == MqttConnectionState.connected) {
//       mqttClient.disconnect();
//     }
//   }
//
//   void updateLiveData(String payload) {
//     // Your live data update logic
//     print('Update live data with: $payload');
//     // Example: parse JSON and update UI or state
//   }
// }
//
// // import 'dart:developer';
// // import 'package:mqtt_client/mqtt_client.dart';
// // import 'package:mqtt_client/mqtt_server_client.dart';
//
// // class MqttService {
// //   late MqttServerClient _client;
// //   // final String _broker = 'broker.hivemq.com';
// //   final String _topic = 'flutter/test';
// //   // final String _broker = 'hk.igloble.com';
// //   final String _broker = 'pubsub.iotasmart.com';
// //   final String _username = 'consumer';
// //   // final String _password = 'kcis123';
// //   final String _password = 'iotaSmart@7890';
// //   final String _clientId = 'clientId-${DateTime.now().millisecondsSinceEpoch}';
//
// //   Future<void> connect() async {
// //     try {
// //       _client = MqttServerClient.withPort(_broker, _clientId,443);
// //       // _client.port = 1883;
// //       _client.keepAlivePeriod = 60;
// //       _client.useWebSocket = true;
// //       _client.logging(on: true);
// //       _client.secure = true;
// //       // Set connection message
// //       final connMess = MqttConnectMessage()
// //           .withClientIdentifier(_clientId)
// //           .authenticateAs(_username,_password) // <- important
// //           .withWillQos(MqttQos.atLeastOnce);
// //       _client.connectionMessage = connMess;
// //       // _client.setProtocolV311();
// //       _client.autoReconnect = true;
// //       _client.onConnected = _onConnected;
// //       _client.onDisconnected = _onDisconnected;
// //       _client.onSubscribed = _onSubscribed;
// //       log('Connecting to MQTT broker...');
// //       await _client.connect();
// //       // await _client.connect(_username, _password);
// //     } catch (e) {
// //       log('Connection failed: $e');
// //       _client.disconnect();
// //     }
//
// //     _client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
// //       if (c == null || c.isEmpty) {
// //         log('No messages received');
// //         return;
// //       }
// //       final MqttPublishMessage? message = c[0].payload as MqttPublishMessage?;
// //       final String payload = MqttPublishPayload.bytesToStringAsString(
// //         message!.payload.message,
// //       );
// //       log('Received message: $payload');
// //     });
// //   }
//
// //   void _subscribeToTopic() {
// //     _client.subscribe(_topic, MqttQos.atMostOnce);
// //     log('Subscribed to topic: $_topic');
// //   }
//
// //   void _onConnected() {
// //     log('Connected To MQTT broker');
// //     _subscribeToTopic();
// //   }
//
// //   void _onDisconnected() {
// //     log('Disconnected from MQTT broker');
// //   }
//
// //   void _onSubscribed(String topic) {
// //     log('Subscribed to topic: $topic');
// //   }
//
// //   void publish(String message) {
// //     final builder = MqttClientPayloadBuilder();
// //     builder.addString(message);
// //     _client.publishMessage(_topic, MqttQos.atMostOnce, builder.payload!);
// //     log('Published message: $message');
// //   }
//
// //   void disconnect() {
// //     _client.disconnect();
// //     log('Disconnected from MQTT broker');
// //   }
// // }
