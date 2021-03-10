import 'package:flutter/material.dart';
import 'package:new_project/Handlers/userInfoHandler.dart';

import '../mainGUI.dart';

class NavigationBar extends StatelessWidget implements PreferredSizeWidget {
  final Function navigate;
  final Function showContractTemplateGUI;
  final UserInfoHandler userHandler;
  NavigationBar(this.navigate, this.showContractTemplateGUI, this.userHandler);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return AppBar(
      automaticallyImplyLeading: false,
      //color cheat sheet
      //https://api.flutter.dev/flutter/material/Colors-class.html
      backgroundColor: themeData.primaryColor,
      title: Text(userHandler.user.currentType),
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
