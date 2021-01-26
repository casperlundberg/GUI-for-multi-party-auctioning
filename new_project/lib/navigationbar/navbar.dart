import 'package:flutter/material.dart';
import 'nav_item.dart';

class NavigationBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      //color cheat sheet
      //https://api.flutter.dev/flutter/material/Colors-class.html
      backgroundColor: Colors.indigo[900],

      actions: <Widget>[
        /* NavigationItem(title: 'Home'),
        NavigationItem(title: 'About'),
        NavigationItem(title: 'Contact'), */
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
