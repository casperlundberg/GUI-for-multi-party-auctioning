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

  AuctionsGUI(
      this.navigate,
      this.availableFilters,
      this.activeFilters,
      this.inactiveFilters,
      this.updateFilters,
      this.deleteFilter,
      this.activateFilter,
      this.deactivateFilter,
      this.ongoingAuctionList,
      this.auctionList);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, //Center Row contents horizontally
      crossAxisAlignment:
          CrossAxisAlignment.center, //Center Row contents vertically
      children: <Widget>[
        FiltersGUI(availableFilters, activeFilters, inactiveFilters,
            updateFilters, deleteFilter, activateFilter, deactivateFilter),
        Center(child: Auctions(navigate, ongoingAuctionList, auctionList)),
        Center(child: MyAuctions(navigate)),
      ],
    );
  }
}
