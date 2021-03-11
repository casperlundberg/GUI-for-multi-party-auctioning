import 'package:flutter/material.dart';
import 'package:new_project/Entities/userList.dart';
import 'package:new_project/Handlers/userInfoHandler.dart';

import '../mainGUI.dart';

class NavigationBar extends StatefulWidget implements PreferredSizeWidget {
  final Function navigate;
  final Function showContractTemplateGUI;
  final Function showNotifications;
  final UserInfoHandler userHandler;
  int counter;
  NavigationBar(this.navigate, this.showContractTemplateGUI, this.showNotifications, this.counter, this.userHandler);

  NavigationState createState() => NavigationState(navigate, showContractTemplateGUI, showNotifications, counter, userHandler);

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class NavigationState extends State<NavigationBar> {
  final Function navigate;
  final Function showContractTemplateGUI;
  final Function showNotifications;
  final UserInfoHandler userHandler;
  int counter;
  NavigationState(this.navigate, this.showContractTemplateGUI, this.showNotifications, this.counter, this.userHandler);

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
                userHandler.user = new User();
                navigate(WidgetMarker.login);
              },
              //style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Text("Log out")),
        ),
        Center(
          child: Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  setState(() {
                    //print(counter);
                  });
                  showNotifications(context, null);
                },
              ),
              getNotificationsWidgetCounter(),
            ],
          ),
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

  Widget getNotificationsWidgetCounter() {
    if (counter != 0) {
      return Positioned(
        right: 5,
        top: 5,
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          constraints: BoxConstraints(
            minWidth: 16,
            minHeight: 16,
          ),
          child: Center(
            child: Text(
              '$counter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
}
