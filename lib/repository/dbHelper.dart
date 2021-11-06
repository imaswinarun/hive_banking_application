import 'dart:convert';
import 'package:banking_application/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:banking_application/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DBHelper with ChangeNotifier {
  String _hiveDB = 'userDb';

  List _userList = <UserModel>[];

  List get userList => _userList;

  addUser(UserModel user) async {
    var hiveBox = await Hive.openBox<UserModel>(_hiveDB);
    hiveBox.add(user);
    notifyListeners();
  }

  getAllUsers() async {
    final hiveBox = await Hive.openBox<UserModel>(_hiveDB);
    _userList = hiveBox.values.toList();
    notifyListeners();
  }

  updateUserBalance(int index, UserModel user) async {
    var hiveBox = await Hive.openBox<UserModel>(_hiveDB);
    hiveBox.putAt(index, user);
    notifyListeners();
    sendFcmPushNotification(["${Constants.fcmToken}"], user);
  }

  sendFcmPushNotification(List<String> userToken, UserModel user) async {
    final url = Uri.parse(Constants.fcmPushNotificationUrl);

    final data = {
      "registration_ids": userToken,
      "collapse_key": "type_a",
      "notification": {
        "title": '${user.name}',
        "body": 'Balance Updated',
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': Constants.fcmServerKey
    };

    final response = await http.post(url,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      print('FCM Push Notification Sent');
    } else {
      print('FCM Push Notification Error');
    }
  }
}
