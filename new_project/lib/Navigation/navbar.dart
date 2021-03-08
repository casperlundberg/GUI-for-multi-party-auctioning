import 'package:flutter/material.dart';

import '../mainGUI.dart';

class NavigationBar extends StatelessWidget implements PreferredSizeWidget {
  final Function navigate;
  final Function showContractTemplateGUI;
  NavigationBar(this.navigate, this.showContractTemplateGUI);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return AppBar(
      automaticallyImplyLeading: false,
      //color cheat sheet
      //https://api.flutter.dev/flutter/material/Colors-class.html
      backgroundColor: themeData.primaryColor,
      title: Text("GUI for multi-party auctioning"),
      leading: IconButton(
        icon: Icon(Icons.home),
        tooltip: 'Home',
        onPressed: () {
          navigate(WidgetMarker.auctions);
        },
      ),

      actions: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: ElevatedButton(
              onPressed: () {
                showContractTemplateGUI(context);
              },
              child: Text("New Contract Template")),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: ElevatedButton(
              onPressed: () {
                navigate(WidgetMarker.login);
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Text("Log out")),
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          tooltip: 'Notifications',
          onPressed: () {
            // Fixa potentiellt interface för detta i framtiden
          },
        ),
        IconButton(
          icon: Icon(Icons.account_circle),
          tooltip: 'Profile',
          onPressed: () {
            navigate(WidgetMarker.profile);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
