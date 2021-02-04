import 'package:flutter/material.dart';

import '../State/mainGUI.dart';
import 'nav_item.dart';

class NavigationBar extends StatelessWidget implements PreferredSizeWidget {
  final Function navigate;
  NavigationBar(this.navigate);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      //color cheat sheet
      //https://api.flutter.dev/flutter/material/Colors-class.html
      backgroundColor: Colors.grey[900],
      title: Text("Auctioneer"),
      leading: IconButton(
        icon: Icon(Icons.home),
        tooltip: 'Home',
        onPressed: () {
          navigate(WidgetMarker.login);
        },
      ),

      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications),
          tooltip: 'Notifications',
          onPressed: () {
            //TODO: Fixa interface för notiser?
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
