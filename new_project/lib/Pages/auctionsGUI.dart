import 'package:flutter/material.dart';
import 'package:new_project/Handlers/auctionHandler.dart';
import 'package:new_project/Handlers/filterHandler.dart';
import 'package:new_project/Handlers/userInfoHandler.dart';

import '../Filters/filtersGUI.dart';
import '../Auctions/auctions.dart';
import '../Auctions/myauctions.dart';

class AuctionsGUI extends StatelessWidget {
  final Function setMainState;
  final Function navigate;
  final FilterHandler filterHandler;
  final AuctionHandler auctionHandler;
  final UserInfoHandler userHandler;

  AuctionsGUI(this.setMainState, this.navigate, this.filterHandler, this.auctionHandler, this.userHandler);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally
      crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically
      children: <Widget>[
        FiltersGUI(setMainState, filterHandler),
        Center(child: Auctions(setMainState, navigate, filterHandler, auctionHandler, userHandler)),
        Center(child: MyAuctions(navigate, auctionHandler)),
      ],
    );
  }
}
