import 'package:flutter/material.dart';
import 'package:new_project/Handlers/auctionHandler.dart';
import 'package:new_project/Handlers/filterHandler.dart';
import 'package:new_project/Handlers/offerHandler.dart';
import 'package:new_project/Handlers/userInfoHandler.dart';

import '../Filters/filtersGUI.dart';
import '../Auctions/allAuctions.dart';
import '../Auctions/myauctions.dart';

class AuctionsGUI extends StatelessWidget {
  final Function navigate;
  final FilterHandler filterHandler;
  final AuctionHandler auctionHandler;
  final OfferHandler offerHandler;
  final UserInfoHandler userHandler;

  AuctionsGUI(this.navigate, this.filterHandler, this.auctionHandler, this.offerHandler, this.userHandler);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally
      crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically
      children: <Widget>[
        FiltersGUI(filterHandler),
        Center(child: AllAuctions(navigate, filterHandler, auctionHandler, offerHandler, userHandler)),
        Center(child: MyAuctions(navigate, auctionHandler, offerHandler, filterHandler, userHandler)),
      ],
    );
  }
}
