import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../Dashboard/mainGUI.dart';
=======
import '../Dashboard/login.dart';
>>>>>>> 24b4025e03a7ed5c3f435c4c79232c92e3a11272
import 'AuctionsTemplateGUI.dart';
import 'FiltersTemplateGUI.dart';
import '../Auctions/room.dart';

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
              child: Column(children: [
                Text('Name: Room 1'),
                Text('Material: Wood'),
                Text('Participants: 5'),
                TextButton(
                    child: Text('Visit room'),
                    onPressed: () {
                      Navigator.push(
                        context,
<<<<<<< HEAD
                        MaterialPageRoute(builder: (context) => MainGUI()),
=======
                        MaterialPageRoute(builder: (context) => Room()),
>>>>>>> 24b4025e03a7ed5c3f435c4c79232c92e3a11272
                      );
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
