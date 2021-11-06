import 'package:banking_application/models/userModel.dart';
import 'package:banking_application/repository/dbHelper.dart';
import 'package:banking_application/screens/createUser/createUser.dart';
import 'package:banking_application/screens/listOfUsers/listOfUsers.dart';
import 'package:banking_application/screens/listOfUsers/userDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationHelper {
  void gotoCreateUserScreen(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => CreateUser()));
  }

  void gotoListOfUsersScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ChangeNotifierProvider<DBHelper>(
          create: (context) => DBHelper(),
          child: ListOfUsers(),
        ),
      ),
    );
  }

  void gotoUserDetailScreen(BuildContext context, UserModel user, int index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => UserDetail(user, index)));
  }
}
