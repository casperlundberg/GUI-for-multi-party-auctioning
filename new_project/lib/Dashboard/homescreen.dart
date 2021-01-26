import 'package:flutter/material.dart';
import '../navigationbar/navbar.dart';
import '../Auctions/filters.dart';
import '../Auctions/ongoing.dart';
import '../Auctions/finished.dart';
import '../Auctions/myauctions.dart';

class AuctionContainers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, //Center Row contents horizontally
      crossAxisAlignment:
          CrossAxisAlignment.center, //Center Row contents vertically
      children: <Widget>[
        Container(
          color: Colors.orange,
          margin: EdgeInsets.all(25.0),
          child: Filter(),
        ),
        Row(children: [
          Container(
            color: Colors.blue,
            margin: EdgeInsets.only(top: 25.0, bottom: 25.0),
            child: Ongoing(),
          ),
          Container(
            color: Colors.blue,
            margin: EdgeInsets.only(top: 25.0, bottom: 25.0),
            child: Finished(),
          ),
        ]),
        Container(
          color: Colors.purple,
          margin: EdgeInsets.all(25.0),
          child: MyAuctions(),
        ),
      ],
    );
  }
}
