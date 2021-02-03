import 'package:flutter/material.dart';
import '../Dashboard/mainGUI.dart';
import 'AuctionsTemplateGUI.dart';
import 'FiltersTemplateGUI.dart';
import '../Auctions/room.dart';

class Ongoing extends StatelessWidget {
  final Function navigate;
  Ongoing(this.navigate);

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
              child: Column(children: [
                Text('Name: Room 1'),
                Text('Material: Wood'),
                Text('Participants: 5'),
                TextButton(
                    child: Text('Visit room'),
                    onPressed: () {
                      navigate(WidgetMarker.room);
                    }),
              ]),
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
