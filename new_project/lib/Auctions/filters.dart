import 'package:flutter/material.dart';
import '../Dashboard/mainGUI.dart';
import 'AuctionsTemplateGUI.dart';
import 'FiltersTemplateGUI.dart';
import '../Auctions/room.dart';

class Filter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.grey[900],
      child: new Column(
        children: <Widget>[
          Text(
            'FILTERS\n',
            style: TextStyle(fontSize: 30),
          ),
          Column(children: [
            new Container(
              width: 320.0,
              height: 110.0,
              child: Column(children: [
                Text(''),
                Text('Material: Wood'),
                Text(
                    'Description: Soft material which often is used i the paper industri.'),
                TextButton(
                    child: Text('Visit room'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Room()),
                      );
                    }),
              ]),
              color: Colors.blue,
              margin: EdgeInsets.all(5.0),
            ),
          ]),
          Column(children: [
            new Container(
              child: Text('s'),
              width: 320.0,
              height: 110.0,
              color: Colors.blue,
              margin: EdgeInsets.all(5.0),
            ),
          ]),
          Column(children: [
            new Container(
              child: Text('s'),
              width: 320.0,
              height: 110.0,
              color: Colors.blue,
              margin: EdgeInsets.all(5.0),
            ),
          ]),
          Column(children: [
            new Container(
              child: Text('s'),
              width: 320.0,
              height: 110.0,
              color: Colors.blue,
              margin: EdgeInsets.all(5.0),
            ),
          ]),
          Column(children: [
            new Container(
              child: FilterTemplateGUI(),
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
