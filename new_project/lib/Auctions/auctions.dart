import 'package:flutter/material.dart';
import 'package:new_project/State/auction.dart';

import '../State/mainGUI.dart';
import 'auctionsTemplateGUI.dart';
import '../Entities/auctionsJSON.dart';


enum PageMarker { ongoing, finished }

class Auctions extends StatefulWidget {
  final List<Auction> ongoingAuctionList;
  final Function auctionList;
  auctions(this., this.auctionList);

  @override
  _AuctionState createState(auctionlist) => _AuctionState(
      );
}
  Auctions(this.navigate);

  @override
  State<StatefulWidget> createState() => AuctionsState(this.navigate);
}

class AuctionsState extends State<Auctions>
    with SingleTickerProviderStateMixin<Auctions> {
  PageMarker _currentPage;

  final Function navigate;
  AuctionsState(this.navigate);

  @override
  void initState() {
    super.initState();
    _currentPage = PageMarker.ongoing;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1000.0,
        width: 700.0,
        color: Colors.transparent,
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Row(children: [
              Container(
                  width: 330.0,
                  height: MediaQuery.of(context).size.width * 0.05,
                  color: (_currentPage == PageMarker.ongoing)
                      ? Colors.black
                      : Colors.grey[900],
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _currentPage = PageMarker.ongoing;
                      });
                    },
                    child: Container(
                      child: Text("Ongoing",
                          style: TextStyle(
                              color: (_currentPage == PageMarker.ongoing)
                                  ? Colors.white
                                  : Colors.white60)),
                    ),
                  )),
              Container(
                  width: 330.0,
                  height: MediaQuery.of(context).size.width * 0.05,
                  color: (_currentPage == PageMarker.finished)
                      ? Colors.black
                      : Colors.grey[900],
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _currentPage = PageMarker.finished;
                      });
                    },
                    child: Container(
                      child: Text("Finished",
                          style: TextStyle(
                              color: (_currentPage == PageMarker.finished)
                                  ? Colors.white
                                  : Colors.white60)),
                    ),
                  )),
            ]),
          ),
          FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot snaptshot) {
            return _getPageContainer();
          })
        ]));
  }

  SliverFixedExtentList _getPageContainer() {
    switch (_currentPage) {
      case PageMarker.ongoing:
        return _getOngoing();
      case PageMarker.finished:
        return _getFinished();
    }
    return _getOngoing();
  }

  SliverFixedExtentList _getOngoing() {
    return SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(5.0),
              color: Colors.lightGreen[100 * (index % 9)],
              child: Column(children: [
                Text('Name: Room $index'),
                Text('Material: Wood'),
                Text('Participants: 5'),
                TextButton(
                    child: Text('Visit room'),
                    onPressed: () {
                      navigate(WidgetMarker.room);
                    }),
              ]),
            );
          },
          childCount: 10,
        ));
  }

  SliverFixedExtentList _getFinished() {
    return SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(5.0),
              color: Colors.yellow[100 * (index % 9)],
              child: Column(children: [
                Text('Name: Room $index'),
                Text('Material: Wood'),
                Text('Participants: 5'),
                TextButton(
                    child: Text('Visit room'),
                    onPressed: () {
                      navigate(WidgetMarker.room);
                    }),
              ]),
            );
          },
          childCount: 10,
        ));
  }
}
