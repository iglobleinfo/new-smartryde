import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final client = MqttServerClient('52.66.130.18', '');

  Future<void> connect(String topic) async {
    client.port = 1883;
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client_${DateTime.now().millisecondsSinceEpoch}')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    try {
      await client.connect();
    } catch (e) {
      print('MQTT connection error: $e');
      client.disconnect();
    }

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      print('MQTT Connected');
      client.subscribe(topic, MqttQos.atLeastOnce);
    } else {
      print('Connection failed: ${client.connectionStatus}');
      client.disconnect();
    }

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('MQTT Message: topic: <${c[0].topic}>, message: <$message>');
    });
  }

  void onDisconnected() {
    print('MQTT Disconnected');
  }

  void onConnected() {
    print('MQTT Connected Callback');
  }

  void onSubscribed(String topic) {
    print('Subscribed to $topic');
  }

  void pong() {
    print('Ping response received');
  }
}
