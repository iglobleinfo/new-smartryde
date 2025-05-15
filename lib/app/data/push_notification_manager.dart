// import 'dart:math';
//
// import '../../export.dart';
//
// var messageNew = "";
// var deviceToken = "";
//
// Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.data}');
// }
//
// class PushNotificationsManager {
//   PushNotificationsManager._();
//
//   factory PushNotificationsManager() => _instance;
//   static final PushNotificationsManager _instance =
//       PushNotificationsManager._();
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   bool _initialized = false;
//
//   Future init() async {
//     if (!_initialized) {
//       await Firebase.initializeApp();
//       // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
//       // For iOS request permission first.
//       await _firebaseMessaging.requestPermission(alert: true, sound: true);
//       await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//           alert: true, badge: true, sound: true);
//       // For testing purposes, print the Firebase Messaging token
//       await _firebaseMessaging.getToken().then((value) {
//         deviceToken = value!;
//         debugPrint("Firebase Messaging token $value");
//       });
//       getInitialMessage();
//       onMessage();
//       onAppOpened();
//
//       FirebaseMessaging.onBackgroundMessage(
//           _firebaseMessagingBackgroundHandler);
//
//       _initialized = true;
//     }
//   }
//
//   getInitialMessage() async {
//     await Future.delayed(Duration(milliseconds: 500));
//     _firebaseMessaging.getInitialMessage().then((message) async {
//       if (message != null) {
//         debugPrint("message1  listen ${message.data}");
//         notificationRedirection(message.data);
//       } else {
//         // preferenceManger.isNotifyCheck(isNotifiedCheck: false);
//       }
//     });
//   }
//
//   int number = 0;
//
//   onMessage() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       debugPrint("message2  action ${message.data['action']}");
//       debugPrint(number.toString());
//       // app foreground
//       var notification = message.data;
//       var androids = AndroidInitializationSettings("ic_drawable");
//       var ios = new DarwinInitializationSettings();
//       var platform = new InitializationSettings(android: androids, iOS: ios);
//
//       flutterLocalNotificationsPlugin.initialize(platform,
//           onDidReceiveNotificationResponse: (NotificationResponse data) {
//         debugPrint("message3 local ${message.data['detail']}");
//         notificationRedirection(message.data);
//       });
//
//       if (Platform.isAndroid) {
//         var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//           'com.app.smart_ryde',
//           'smart_ryde',
//           importance: Importance.max,
//           groupKey: "smart_ryde",
//           setAsGroupSummary: true,
//           groupAlertBehavior: GroupAlertBehavior.all,
//           playSound: true,
//           enableVibration: true,
//         );
//         var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
//         var platformChannelSpecifics = NotificationDetails(
//             android: androidPlatformChannelSpecifics,
//             iOS: iOSPlatformChannelSpecifics);
//         debugPrint("value ${message.data}");
//         // debugPrint("details : ${message.data['detail']['title']}");
//         var jsonData = jsonDecode(message.data["detail"]);
//         var rng = Random();
//         await flutterLocalNotificationsPlugin.show(rng.nextInt(1000),
//             "smart_ryde", jsonData["title"], platformChannelSpecifics,
//             payload: jsonEncode(notification));
//       }
//     });
//   }
//
//   onAppOpened() {
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       // resume app
//       debugPrint("message4  openapp ${message.data['action']}");
//       notificationRedirection(message.data);
//     });
//   }
//
//   notificationRedirection(Map data) async {}
//
//   void navigateToMain() {
//     // Get.offNamed(AppRoutes.mainScreen);
//   }
// }
//
// class GlobalVariable {
//   static final GlobalKey navState = GlobalKey();
// }
