import 'package:banking_application/models/userModel.dart';
import 'package:banking_application/repository/dbHelper.dart';
import 'package:banking_application/utils/appBar.dart';
import 'package:banking_application/utils/constants.dart';
import 'package:banking_application/utils/customButtonUi.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  final UserModel user;
  final int index;
  UserDetail(this.user, this.index);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("${widget.user.name}", AppBar()),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          buildUserDetail(widget.user),
          buildAmountTrans(),
        ],
      ),
    );
  }

  Widget buildAmountTrans() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            controller: amountController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(labelText: "₹"),
            validator: (value) {
              if (value!.isEmpty) {
                return '₹ cant be Empty';
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  withdrawLogic();
                },
                child: CustomButonUi("Withdraw"),
              ),
              TextButton(
                onPressed: () {
                  depositLogic();
                },
                child: CustomButonUi("Deposit"),
              )
            ],
          ),
        ],
      ),
    );
  }

  void depositLogic() async {
    int wAmount = int.parse(amountController.text);
    widget.user.balance = widget.user.balance + wAmount;
    await DBHelper().updateUserBalance(widget.index, widget.user);
    setState(() {
      amountController.clear();
    });
  }

  void withdrawLogic() async {
    int wAmount = int.parse(amountController.text);
    if (wAmount < widget.user.balance) {
      widget.user.balance = widget.user.balance - wAmount;
      DBHelper().updateUserBalance(widget.index, widget.user);
      setState(() {
        amountController.clear();
      });
    }
  }

  Card buildUserDetail(UserModel user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              user.phoneNumber,
              style: Constants().userinfoTextStyle,
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
