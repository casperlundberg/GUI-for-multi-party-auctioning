import 'package:flutter/material.dart';

import '../Auctions/filters.dart';
import '../Auctions/ongoing.dart';
import '../Auctions/finished.dart';
import '../Auctions/myauctions.dart';
import '../Auctions/filtersTemplateGUI.dart';
import '../Entities/localJSONFilter.dart';

class AuctionsGUI extends StatelessWidget {
  final Function navigate;
  final List<LocalJSONFilter> filters;
  final Function updateFilters;
  AuctionsGUI(this.navigate, this.filters, this.updateFilters);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, //Center Row contents horizontally
      crossAxisAlignment:
          CrossAxisAlignment.center, //Center Row contents vertically
      children: <Widget>[
        Column(
          children: [
            Container(
              color: Colors.orange,
              margin: EdgeInsets.only(top: 25.0, right: 25.0, left: 25.0),
              child: Filter(),
            ),
            Container(
              child: FilterTemplateGUI(filters, updateFilters),
              width: 330.0,
              height: 120.0,
              margin: EdgeInsets.only(bottom: 25.0, right: 25.0, left: 25.0),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              color: Colors.blue,
              margin: EdgeInsets.only(top: 25.0, bottom: 25.0),
              child: Ongoing(navigate),
            ),
            Container(
              color: Colors.blue,
              margin: EdgeInsets.only(top: 25.0, bottom: 25.0),
              child: Finished(navigate),
            ),
          ],
        ),
        Container(
          color: Colors.purple,
          margin: EdgeInsets.all(25.0),
          child: MyAuctions(navigate),
        ),
      ],
    );
  }
}
