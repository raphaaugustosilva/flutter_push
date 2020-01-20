import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationFCMService {
  FirebaseMessaging _firebaseMessaging;

  final void Function(String) aoRegistrar;
  final void Function(Map<String, dynamic>) aoReceberPush;

  PushNotificationFCMService(this.aoRegistrar, this.aoReceberPush);

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessagingListeners();
  }

  void firebaseCloudMessagingListeners() async {
    if (Platform.isIOS) iOSPermission();

    String token = await _firebaseMessaging.getToken();
    print("token p ush: $token");
    aoRegistrar(token);

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("on message $message");

        // for (var keys in message.keys) {
        //   if (keys == "data") {
        //     print('$keys was written by ${message[keys]}');
        //   }
        // }
        aoReceberPush(message);
      },
      onResume: (Map<String, dynamic> message) async {},
      onLaunch: (Map<String, dynamic> message) async {},
    );
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
