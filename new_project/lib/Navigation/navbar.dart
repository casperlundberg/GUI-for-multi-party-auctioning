import 'package:flutter/material.dart';

import '../mainGUI.dart';

class NavigationBar extends StatefulWidget implements PreferredSizeWidget {
  final Function navigate;
  final Function showContractTemplateGUI;
  final Function showNotifications;
  int counter;
  NavigationBar(this.navigate, this.showContractTemplateGUI, this.showNotifications, this.counter);

  NavigationState createState() => NavigationState(navigate, showContractTemplateGUI, showNotifications, counter);

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class NavigationState extends State<NavigationBar> {
  final Function navigate;
  final Function showContractTemplateGUI;
  final Function showNotifications;
  int counter;
  NavigationState(this.navigate, this.showContractTemplateGUI, this.showNotifications, this.counter);

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
        new Stack(
          children: <Widget>[
            new IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  setState(() {
                    //print(counter);
                  });
                  showNotifications(context);
                }),
            counter != 0
                ? new Positioned(
                    right: 11,
                    top: 11,
                    child: new Container(
                      padding: EdgeInsets.all(2),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '$counter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : new Container()
          ],
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
}
