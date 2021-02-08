import 'package:flutter/material.dart';

import '../State/filtersGUI.dart';
import '../Auctions/auctions.dart';
import '../Auctions/myauctions.dart';
import '../Entities/filtersJSON.dart';
import '../Entities/auctionsJSON.dart';

class AuctionsGUI extends StatelessWidget {
  final Function navigate;

  //FILTERS JSON
  final List<Filter> availableFilters;
  final List<Filter> activeFilters;
  final List<Filter> inactiveFilters;
  final Function updateFilters;
  final Function deleteFilter;
  final Function activateFilter;
  final Function deactivateFilter;

  //AUCTION JSON
  final List<AuctionsJSON> ongoingAuctionList;
  final Function auctionList;

  AuctionsGUI(this.navigate, this.availableFilters, this.activeFilters, this.inactiveFilters, this.updateFilters,
      this.deleteFilter, this.activateFilter, this.deactivateFilter, this.ongoingAuctionList, this.auctionList);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally
      crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically
      children: <Widget>[
        Container(
          color: Colors.grey[900],
          margin: EdgeInsets.all(25.0),
          child: FiltersGUI(availableFilters, activeFilters, inactiveFilters, updateFilters, deleteFilter,
              activateFilter, deactivateFilter),
        ),
        Row(children: [
          Container(
            color: Colors.blue,
            margin: EdgeInsets.only(top: 25.0, bottom: 25.0),
            child: Auctions(navigate, ongoingAuctionList, auctionList),
          ),
        ]),
        Container(
          color: Colors.purple,
          margin: EdgeInsets.all(25.0),
          child: MyAuctions(navigate),
        ),
      ],
    );
  }
}
