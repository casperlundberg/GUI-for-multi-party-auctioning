import 'package:flutter/material.dart';

import '../Handlers/auctionHandler.dart';
import '../Handlers/filterHandler.dart';
import '../mainGUI.dart';
import '../Entities/auctionListJSON.dart';
import '../Filters/searchBar.dart';

enum PageMarker { ongoing, finished, offers }

class Auctions extends StatefulWidget {
  final Function navigate;
  final FilterHandler filterHandler;
  final AuctionHandler auctionHandler;

  Auctions(this.navigate, this.filterHandler, this.auctionHandler);

  @override
  _AuctionsState createState() => _AuctionsState(navigate, filterHandler, auctionHandler);
}

class _AuctionsState extends State<Auctions> with SingleTickerProviderStateMixin<Auctions> {
  final Function navigate;
  final FilterHandler filterHandler;
  final AuctionHandler auctionHandler;
  PageMarker _currentPage;

  _AuctionsState(this.navigate, this.filterHandler, this.auctionHandler);

  @override
  void initState() {
    super.initState();
    _currentPage = PageMarker.ongoing;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.4,
      color: Colors.grey[900],
      margin: EdgeInsets.all(5.0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            actions: <Widget>[
              Expanded(
                child: Container(
                  height: double.infinity,
                  color: (_currentPage == PageMarker.ongoing) ? Colors.black : themeData.primaryColor,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _currentPage = PageMarker.ongoing;
                      });
                    },
                    child: Text(
                      "Ongoing auctions",
                      style: TextStyle(fontSize: 20, color: (_currentPage == PageMarker.ongoing) ? Colors.white : Colors.white60),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  color: (_currentPage == PageMarker.finished) ? Colors.black : themeData.primaryColor,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _currentPage = PageMarker.finished;
                      });
                    },
                    child: Text(
                      "Finished auctions",
                      style: TextStyle(fontSize: 20, color: (_currentPage == PageMarker.finished) ? Colors.white : Colors.white60),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  color: (_currentPage == PageMarker.offers) ? Colors.black : themeData.primaryColor,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _currentPage = PageMarker.offers;
                      });
                    },
                    child: Text(
                      "Offers",
                      style: TextStyle(fontSize: 20, color: (_currentPage == PageMarker.offers) ? Colors.white : Colors.white60),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            //--------------CASPER KOLLA HIT
            child: Container(
              width: double.infinity,
              height: 50,
              color: Colors.pink,
              child: SearchBarGUI(),
            ),
          ),
          FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot snaptshot) {
              return _getPageContainer();
            },
          ),
        ],
      ),
    );
  }

  SliverFixedExtentList _getPageContainer() {
    switch (_currentPage) {
      case PageMarker.ongoing:
        return _getOngoing();
      case PageMarker.finished:
        return _getFinished();
      case PageMarker.offers:
        return _getOffers();
    }
    return _getOngoing();
  }

  SliverFixedExtentList _getOngoing() {
    List<Auction> output = [];
    var now = new DateTime.now();

    if (filterHandler.activeFilters.length == 0) {
      for (int i = 0; i < auctionHandler.allAuctions.auctionList.length; i++) {
        if (now.isBefore(auctionHandler.allAuctions.auctionList[i].stopDate)) {
          output.add(auctionHandler.allAuctions.auctionList[i]);
        }
      }
    } else {
      for (int i = 0; i < auctionHandler.allAuctions.auctionList.length; i++) {
        for (int y = 0; y < filterHandler.activeFilters.length; y++) {
          if (auctionHandler.allAuctions.auctionList[i].material == filterHandler.activeFilters[y].name) {
            if (now.isBefore(auctionHandler.allAuctions.auctionList[i].stopDate)) {
              output.add(auctionHandler.allAuctions.auctionList[i]);
            }
          }
        }
      }
    }

    return _generateBoxes(output);
  }

  SliverFixedExtentList _getFinished() {
    List<Auction> output = [];
    var now = new DateTime.now();
    if (filterHandler.activeFilters.length == 0) {
      for (int i = 0; i < auctionHandler.allAuctions.auctionList.length; i++) {
        if (now.isAfter(auctionHandler.allAuctions.auctionList[i].stopDate)) {
          output.add(auctionHandler.allAuctions.auctionList[i]);
        }
      }
    } else {
      for (int i = 0; i < auctionHandler.allAuctions.auctionList.length; i++) {
        for (int y = 0; y < filterHandler.activeFilters.length; y++) {
          if (auctionHandler.allAuctions.auctionList[i].material == filterHandler.activeFilters[y].name) {
            if (now.isAfter(auctionHandler.allAuctions.auctionList[i].stopDate)) {
              output.add(auctionHandler.allAuctions.auctionList[i]);
            }
          }
        }
      }
    }

    return _generateBoxes(output);
  }

  SliverFixedExtentList _getOffers() {
    List<Auction> output = [];
    var now = new DateTime.now();
    if (filterHandler.activeFilters.length == 0) {
      for (int i = 0; i < auctionHandler.allAuctions.auctionList.length; i++) {
        if (now.isAfter(auctionHandler.allAuctions.auctionList[i].stopDate)) {
          output.add(auctionHandler.allAuctions.auctionList[i]);
        }
      }
    } else {
      for (int i = 0; i < auctionHandler.allAuctions.auctionList.length; i++) {
        for (int y = 0; y < filterHandler.activeFilters.length; y++) {
          if (auctionHandler.allAuctions.auctionList[i].material == filterHandler.activeFilters[y].name) {
            if (now.isAfter(auctionHandler.allAuctions.auctionList[i].stopDate)) {
              output.add(auctionHandler.allAuctions.auctionList[i]);
            }
          }
        }
      }
    }

    return _generateBoxes(output);
  }

  //Generates the auctionboxes themselves
  SliverFixedExtentList _generateBoxes(output) {
    var now = new DateTime.now();
    return SliverFixedExtentList(
      itemExtent: 100.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.only(left: 10, right: 10),
            color: now.isAfter(output[index].stopDate) ? Colors.redAccent : Colors.greenAccent[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name: Room ' + output[index].id.toString()),
                    Text('Material: ' + output[index].material),
                    Text('Participants: ' + output[index].currentParticipants.toString()),
                  ],
                ),
                Spacer(),
                Container(
                  child: ElevatedButton(
                    child: Text('Visit room'),
                    onPressed: () {
                      auctionHandler.setCurrentAuction(output[index].id);
                      navigate(WidgetMarker.room);
                    },
                  ),
                ),
              ],
            ),
          );
        },
        childCount: output.length,
      ),
    );
  }
}
