import 'package:banking_application/utils/appBar.dart';
import 'package:banking_application/utils/constants.dart';
import 'package:banking_application/utils/customButtonUi.dart';
import 'package:banking_application/utils/navigationHelper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) {
      Constants.fcmToken = value != null ? value : '';
      print(Constants.fcmToken);
    });

    getNotificationStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar("HomeScreen", AppBar()),
      body: buildButtons(),
    );
  }

  Widget buildButtons() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              NavigationHelper().gotoCreateUserScreen(context);
            },
            child: CustomButonUi("Create User"),
          ),
          TextButton(
            onPressed: () {
              NavigationHelper().gotoListOfUsersScreen(context);
            },
            child: CustomButonUi("List of Users"),
          )
        ],
      ),
    );
  }

  getNotificationStatus() async {
    FirebaseMessaging.onMessage.listen((event) {
      print("message recieved");
      displayMeesage(event.notification!.body!);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('Message clicked!');
      FlutterAppBadger.removeBadge();
      displayMeesage(event.notification!.body!);
    });
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandler);
  }

  displayMeesage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Notification: $message',
          style: Constants().snackbarTextStyle,
        ),
        backgroundColor: Colors.blue,
        action: SnackBarAction(
          label: "Ok",
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}

Future<void> onBackgroundMessageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
  FlutterAppBadger.updateBadgeCount(1);
}
