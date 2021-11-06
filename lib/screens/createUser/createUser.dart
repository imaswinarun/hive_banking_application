import 'package:banking_application/models/userModel.dart';
import 'package:banking_application/repository/dbHelper.dart';
import 'package:banking_application/utils/appBar.dart';
import 'package:banking_application/utils/customButtonUi.dart';
import 'package:flutter/material.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userPhoneNumberContoller =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Create User", AppBar()),
      body: buildBody(),
    );
  }

  Center buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: userNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: "User Name"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'User Name cannot be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: userPhoneNumberContoller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "User Phone Number"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'User Number cannot be empty';
                  }
                  return null;
                },
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await DBHelper().addUser(UserModel(
                        name: userNameController.text,
                        phoneNumber: userPhoneNumberContoller.text,
                        balance: 500));
                    Navigator.pop(context);
                  }
                },
                child: CustomButonUi("Add User"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
