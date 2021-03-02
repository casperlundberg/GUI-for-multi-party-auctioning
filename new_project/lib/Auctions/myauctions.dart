import 'package:flutter/material.dart';
import 'package:new_project/Handlers/userInfoHandler.dart';

import '../Handlers/auctionHandler.dart';
import '../mainGUI.dart';

class MyAuctions extends StatelessWidget {
  final Function navigate;
  final AuctionHandler auctionHandler;
  MyAuctions(this.navigate, this.auctionHandler);

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
                      padding: EdgeInsets.only(left: 10, right: 10),
                      color: Colors.lightGreen[600],
                      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text('Name: Room ${auctionHandler.myAuctions.auctionList[index].id}'),
                          Text('Material: ${auctionHandler.myAuctions.auctionList[index].material}'),
                          Text('Participants: ${auctionHandler.myAuctions.auctionList[index].currentParticipants}'),
                        ]),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                              child: Text('Visit room'),
                              onPressed: () {
                                auctionHandler.setCurrentAuction(auctionHandler.myAuctions.auctionList[index].id);
                                navigate(WidgetMarker.room);
                              }),
                        ),
                      ]));
                },
                childCount: auctionHandler.myAuctions.auctionList.length,
              ))
        ],
      ),
    );
  }
}
