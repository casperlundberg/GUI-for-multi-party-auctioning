import 'package:flutter/material.dart';
import 'package:new_project/Entities/auctionDetailsJSON.dart';
import '../State/mainGUI.dart';
import '../Entities/user.dart';

class MyAuctions extends StatelessWidget {
  final Function navigate;
  AuctionDetails auctionDetails;
  User user;
  MyAuctions(this.navigate, this.auctionDetails, this.user);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return new Container(
      color: Colors.grey[900],
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.2,
      margin: EdgeInsets.all(5.0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Row(children: [
              Text("My Auctions"),
              Spacer(),
              IconButton(
                icon: Icon(Icons.add),
                tooltip: 'New auction',
                onPressed: () {
                  //Add auction code goes here
                },
              ),
            ]),
          ),
          SliverFixedExtentList(
              itemExtent: 100.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(5.0),
                    color: Colors.pink[600],
                    child: Column(children: [
                      Text(
                          'Name: Room ${user.participatingAuctions[index].auctionId}'),
                      Text('Material: ${auctionDetails.material}'),
                      Text(
                          'Participants: ${auctionDetails.participants.length}'),
                      TextButton(
                          child: Text('Visit room'),
                          onPressed: () {
                            navigate(WidgetMarker.room);
                          }),
                    ]),
                  );
                },
                childCount: user.participatingAuctions.length,
              )),
        ],
      ),
    );
  }
}
