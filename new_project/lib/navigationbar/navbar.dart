import 'package:flutter/material.dart';
import '../Dashboard/mainGUI.dart';
import 'nav_item.dart';

class NavigationBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      //color cheat sheet
      //https://api.flutter.dev/flutter/material/Colors-class.html
      backgroundColor: Colors.indigo[900],
      title: Text("Auctioneer"),
      leading: IconButton(
        icon: Icon(Icons.home),
        tooltip: 'Home',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainGUI()));
        },
      ),

      actions: <Widget>[
        /* NavigationItem(title: 'Home'),
        NavigationItem(title: 'About'),
        NavigationItem(title: 'Contact'), */
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
            // TODO: Routa till profilsidan när den finns
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
