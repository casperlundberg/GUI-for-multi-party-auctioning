import 'package:flutter/material.dart';
import '../navigationbar/navbar.dart';
import '../Auctions/filters.dart';
import '../Auctions/ongoing.dart';
import '../Auctions/finished.dart';
import '../Auctions/myauctions.dart';

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
              Row(children: [
                Container(
                  color: Colors.blue,
                  child: Ongoing(),
                ),
                Container(
                  color: Colors.blue,
                  child: Finished(),
                ),
              ]),
              Container(
                color: Colors.purple,
                margin: EdgeInsets.all(25.0),
                child: MyAuctions(),
              ),
            ],
          ),
        ]));
  }
}
