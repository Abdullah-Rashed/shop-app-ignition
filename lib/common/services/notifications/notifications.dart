import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/app/ignition_shop.dart';
import 'package:shop_app/common/services/shared_prefs/shared_prefs.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

String? fcmToken;

class FirebaseNotifications {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  void handleMessage(RemoteMessage? message) {
    if (message != null) {
      logger.w(message.data);
      display(message);
    }
  }

  Future<void> initNotifictaions() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // if (request.authorizationStatus == AuthorizationStatus.authorized ||
    //     request.authorizationStatus == AuthorizationStatus.provisional) {
    //   const AndroidInitializationSettings initializationSettingsAndroid =
    //       AndroidInitializationSettings('@drawable/ic_notification');
    //   var iosInitializationSettings = const DarwinInitializationSettings();
    //   final InitializationSettings initializationSettings =
    //       InitializationSettings(
    //     android: initializationSettingsAndroid,
    //     iOS: iosInitializationSettings,
    //   );
    //   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //       onDidReceiveNotificationResponse: (payload) {});
    //   await initPushNotifications();
    fcmToken = await _firebaseMessaging.getToken();
    SharedPrefs.setString(
      "fcmToken",
      fcmToken ?? "",
    );
    logger.e('TOKEN: $fcmToken');
    // }
  }

  Future initPushNotifications() async {
    //  RemoteMessage? initialMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.requestNotificationsPermission();
    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.w("::::::::::::onMessage:::::::::::::::::");
      if (message.notification != null) {
        logger.w(message.notification.toString());
        display(message);
      }
    });
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  static display(RemoteMessage message) async {
    // log('Got a message whilst in the foreground!');
    // log('Message title: ${message.notification!.title.toString()}');
    // log('Message data: ${message.notification!.body.toString()}');

    try {
      // final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      // AndroidNotificationChannel channel = const AndroidNotificationChannel(
      //   "01",
      //   "cc",
      //   description: 'Show Notification',
      //   importance: Importance.max,
      // );
      // AndroidNotificationDetails notificationDetails =
      //     AndroidNotificationDetails(
      //   channel.id,
      //   channel.name,
      //   channelDescription: 'your channel Description',
      //   importance: Importance.high,
      //   priority: Priority.high,
      //   ticker: 'ticker',
      // );
      // const DarwinNotificationDetails darwinNotificationDetails =
      //     DarwinNotificationDetails(
      //         presentAlert: true, presentBadge: true, presentSound: true);
      // NotificationDetails notificationDetailsBoth = NotificationDetails(
      //   android: notificationDetails,
      //   iOS: darwinNotificationDetails,
      // );
      // await FlutterLocalNotificationsPlugin().show(
      //   0,
      //   message.notification!.title,
      //   message.notification!.body,
      //   notificationDetailsBoth,
      //   // payload: jsonEncode(message.data),
      // );
    } on Exception catch (e) {
      logger.e(e);
    }
  }
}
