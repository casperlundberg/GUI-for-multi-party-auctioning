import 'package:flutter/material.dart';
import '../navigationbar/navbar.dart';

class MainGUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: NavigationBar(),
        body: Column(children: <Widget>[
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Row contents horizontally
            crossAxisAlignment:
                CrossAxisAlignment.center, //Center Row contents vertically
            children: [
              Container(
                color: Colors.orange,
                margin: EdgeInsets.all(25.0),
                child: FlutterLogo(
                  size: 400.0,
                ),
              ),
              Container(
                color: Colors.blue,
                margin: EdgeInsets.all(25.0),
                child: FlutterLogo(
                  size: 400.0,
                ),
              ),
              Container(
                color: Colors.purple,
                margin: EdgeInsets.all(25.0),
                child: FlutterLogo(
                  size: 400.0,
                ),
              ),
            ],
          ),
        ]));
  }
}
