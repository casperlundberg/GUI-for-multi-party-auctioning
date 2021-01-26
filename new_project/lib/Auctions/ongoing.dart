import 'package:flutter/material.dart';
import 'AuctionsTemplateGUI.dart';
import 'FiltersTemplateGUI.dart';

class Ongoing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.grey[900],
      child: new Column(
        children: <Widget>[
          Text(
            'ONGOING AUCTIONS\n',
            style: TextStyle(fontSize: 30),
          ),
          Column(children: [
            new Container(
              width: 320.0,
              height: 110.0,
              child: Text('s'),
              color: Colors.orange,
              margin: EdgeInsets.all(5.0),
            ),
          ]),
          Column(children: [
            new Container(
              child: Text('s'),
              width: 320.0,
              height: 110.0,
              color: Colors.green,
              margin: EdgeInsets.all(5.0),
            ),
          ]),
          Column(children: [
            new Container(
              child: Text('s'),
              width: 320.0,
              height: 110.0,
              color: Colors.green,
              margin: EdgeInsets.all(5.0),
            ),
          ]),
          Column(children: [
            new Container(
              child: Text('s'),
              width: 320.0,
              height: 110.0,
              color: Colors.green,
              margin: EdgeInsets.all(5.0),
            ),
          ]),
          Column(children: [
            new Container(
              child: AuctionTemplateGUI(),
              width: 320.0,
              height: 110.0,
              margin: EdgeInsets.all(5.0),
            ),
          ]),
        ],
      ),
    );
  }
}
