import 'package:flutter/material.dart';
import '../navigationbar/navbar.dart';
import '../Auctions/filters.dart';
import '../Auctions/ongoing.dart';
import '../Auctions/finished.dart';

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
                child: Filter(),
              ),
              Container(
                color: Colors.blue,
                margin: EdgeInsets.all(25.0),
                child: Ongoing(),
              ),
              Container(
                color: Colors.purple,
                margin: EdgeInsets.all(25.0),
                child: Finished(),
              ),
            ],
          ),
        ]));
  }
}
/*
class MainGUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center, //Center Row contents horizontally
      crossAxisAlignment:
          CrossAxisAlignment.center, //Center Row contents vertically
      children: [
        NavigationBar(

        ),
        Row(
          Container(
            color: Colors.orange,
            child: FlutterLogo(
              size: 400.0, //Insert 1st class
            ),
          ),
          Container(
            color: Colors.blue,
            child: FlutterLogo(
              size: 400.0, //Insert 2nd class
            ),
          ),
          Container(
            color: Colors.purple,
            child: FlutterLogo(
              size: 400.0, //Insert 3rd class
            ),
          ),
        ),
      ],
    );
  }
}
*/
