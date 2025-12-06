import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../export.dart';

var messageNew = "";
var deviceToken = "";

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.data}');
}

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;
  static final PushNotificationsManager _instance =
      PushNotificationsManager._();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;

  Future init() async {
    if (!_initialized) {
      await Firebase.initializeApp();
      // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
      // For iOS request permission first.
      await _firebaseMessaging.requestPermission(alert: true, sound: true);
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
      // For testing purposes, print the Firebase Messaging token
      await _firebaseMessaging.getToken().then((value) {
        deviceToken = value!;
        print("Firebase Messaging token $value");
      });
      getInitialMessage();
      onMessage();
      onAppOpened();

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      _initialized = true;
    }
  }

  getInitialMessage() async {
    await Future.delayed(Duration(milliseconds: 500));
    _firebaseMessaging.getInitialMessage().then((message) async {
      if (message != null) {
        print("message1  listen ${message.data}");
        notificationRedirection(message.data);
      } else {
        // preferenceManger.isNotifyCheck(isNotifiedCheck: false);
      }
    });
  }

  int number = 0;

  onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("Remote Message::: ${message.toMap()}");
      print("notification title ${message.notification?.title}");
      print("notification  body ${message.notification?.body}");
      // app foreground
      var notification = message.data;
      var androids = AndroidInitializationSettings("ic_drawable");
      var ios = new DarwinInitializationSettings();
      var platform = new InitializationSettings(android: androids, iOS: ios);

      flutterLocalNotificationsPlugin.initialize(platform,
          onDidReceiveNotificationResponse: (NotificationResponse data) {
        notificationRedirection(message.data);
      });

      if (Platform.isAndroid) {
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'com.igloble.minibus',
          'smart_ryde',
          importance: Importance.max,
          groupKey: "smart_ryde",
          setAsGroupSummary: true,
          groupAlertBehavior: GroupAlertBehavior.all,
          styleInformation: BigTextStyleInformation(''),
          playSound: true,
          enableVibration: true,
        );
        var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            android: androidPlatformChannelSpecifics,
            iOS: iOSPlatformChannelSpecifics);
        var jsonData = message.notification;
        var rng = Random();
        await flutterLocalNotificationsPlugin.show(
            rng.nextInt(1000),
            jsonData?.title ?? '',
            jsonData?.body ?? '',
            platformChannelSpecifics,
            payload: jsonEncode(notification));
      }
    });
  }

  onAppOpened() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // resume app
      print("message4  openapp ${message.data['action']}");
      notificationRedirection(message.data);
    });
  }

  notificationRedirection(Map data) async {}

  void navigateToMain() {
    // Get.offNamed(AppRoutes.mainScreen);
  }
}

class GlobalVariable {
  static final GlobalKey navState = GlobalKey();
}
