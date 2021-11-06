import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarText;
  final AppBar appBar;

  CustomAppBar(this.appBarText, this.appBar);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("$appBarText"),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
