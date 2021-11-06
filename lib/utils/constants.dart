import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static String fcmToken = '';
  static const String fcmServerKey =
      'key=AAAAfNC_bRA:APA91bFZ5gnsggjPUEjPJOWxRg8tPHlI4txY8CYIqLWPxuQDAETL_xs5jDxwzEobM2f1DleVwJmHqxoLDnlWoBnhRZUI3BETF8lDvbLIvxZtnmVFLvuUGlCFwdHWXoqMr8-eimcC_KoK';
  static const String fcmPushNotificationUrl = "https://fcm.googleapis.com/fcm/send";
  

  final TextStyle userinfoTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0);
  final TextStyle userAmountTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0);
  final TextStyle snackbarTextStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
}
