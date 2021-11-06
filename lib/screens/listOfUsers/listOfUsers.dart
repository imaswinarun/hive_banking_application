import 'package:banking_application/models/userModel.dart';
import 'package:banking_application/repository/dbHelper.dart';
import 'package:banking_application/utils/appBar.dart';
import 'package:banking_application/utils/constants.dart';
import 'package:banking_application/utils/navigationHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfUsers extends StatefulWidget {
  const ListOfUsers({Key? key}) : super(key: key);

  @override
  _ListOfUsersState createState() => _ListOfUsersState();
}

class _ListOfUsersState extends State<ListOfUsers> {
  @override
  Widget build(BuildContext context) {
    context.watch<DBHelper>().getAllUsers();
    return Scaffold(
      appBar: CustomAppBar("Users", AppBar()),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Consumer<DBHelper>(builder: (context, dbHelper, child) {
      return dbHelper.userList.length == 0
          ? Center(child: Text("No Users to Display"))
          : ListView.builder(
              itemCount: dbHelper.userList.length,
              itemBuilder: (context, index) {
                UserModel user = dbHelper.userList[index];
                return InkWell(
                    onTap: () {
                      NavigationHelper()
                          .gotoUserDetailScreen(context, user, index);
                    },
                    child: buildUserDetail(user));
              });
    });
  }

  Card buildUserDetail(UserModel user) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  user.name,
                  style: Constants().userinfoTextStyle,
                ),
                Text(
                  user.phoneNumber,
                  style: Constants().userinfoTextStyle,
                ),
              ],
            ),
            Text(
              "₹ " + user.balance.toString(),
              style: Constants().userAmountTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
