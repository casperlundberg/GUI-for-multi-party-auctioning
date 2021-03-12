import 'dart:html';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:new_project/Entities/auctionDetailsListJSON.dart';
import 'package:new_project/Entities/materialAuctionListJSON.dart';
import 'package:new_project/Handlers/filterHandler.dart';
import 'package:new_project/Handlers/offerHandler.dart';
import 'package:new_project/Handlers/userInfoHandler.dart';
import '../Handlers/auctionHandler.dart';
import '../mainGUI.dart';
import '../Entities/templateListJSON.dart';
import '../Entities/referencetype2AuctionListJSON.dart';
import '../Entities/materialOfferListJSON.dart';
import '../Entities/referencetype2OfferListJSON.dart';

class MyAuctions extends StatefulWidget {
  final Function navigate;
  final AuctionHandler auctionHandler;
  final OfferHandler offerHandler;
  final FilterHandler filterHandler;
  final UserInfoHandler userHandler;

  MyAuctions(this.navigate, this.auctionHandler, this.offerHandler, this.filterHandler, this.userHandler);

  @override
  _MyAuctionsState createState() => _MyAuctionsState(navigate, auctionHandler, offerHandler, filterHandler, userHandler);
}

class _MyAuctionsState extends State<MyAuctions> with SingleTickerProviderStateMixin<MyAuctions> {
  final Function navigate;
  final AuctionHandler auctionHandler;
  final OfferHandler offerHandler;
  final FilterHandler filterHandler;
  final UserInfoHandler userHandler;
  final List<String> types = ["Auction", "Offer"];
  String typeDropdownValue;
  TextEditingController title = TextEditingController();
  TextEditingController maxParticipants = TextEditingController();
  TextEditingController duration = TextEditingController();
  List<List<String>> referenceTypes;
  List<List<String>> referenceParameters;
  List<List<String>> rangeReferenceParameters;
  List<List<String>> currentReferenceParameters;
  String referenceSectorDropdownValue;
  String referenceTypeDropdownValue;
  List<String> referenceParameterDropdownValues;
  List<TextEditingController> rangeReferenceParameterControllers;
  List<String> templateIDs;
  Template template;
  String templateIDDropdownValue;
  List<TextEditingController> offerControllers;

  _MyAuctionsState(this.navigate, this.auctionHandler, this.offerHandler, this.filterHandler, this.userHandler) {
    referenceTypes = [];
    referenceParameters = [];
    rangeReferenceParameters = [];
    for (int i = 0; i < filterHandler.filters.referenceSectors.length; i++) {
      for (int y = 0; y < filterHandler.filters.referenceSectors[i].referenceTypes.length; y++) {
        List<String> referenceType = [];
        referenceType.add(filterHandler.filters.referenceSectors[i].name);
        referenceType.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].name);
        for (int u = 0; u < filterHandler.filters.referenceSectors[i].referenceTypes[y].referenceParameters.length; u++) {
          List<String> l = [];
          l.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].name);
          l.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].referenceParameters[u].name);
          for (int o = 0; o < filterHandler.filters.referenceSectors[i].referenceTypes[y].referenceParameters[u].values.length; o++) {
            l.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].referenceParameters[u].values[o].filterValue);
          }
          referenceParameters.add(l);
        }
        for (int u = 0; u < filterHandler.filters.referenceSectors[i].referenceTypes[y].rangeReferenceParameters.length; u++) {
          List<String> l = [];
          l.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].name);
          l.add("min" + filterHandler.filters.referenceSectors[i].referenceTypes[y].rangeReferenceParameters[u].name);
          rangeReferenceParameters.add(l);
          l = [];
          l.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].name);
          l.add("max" + filterHandler.filters.referenceSectors[i].referenceTypes[y].rangeReferenceParameters[u].name);
          rangeReferenceParameters.add(l);
        }
        referenceTypes.add(referenceType);
      }
    }
    referenceSectorDropdownValue = referenceTypes[0][0];
    referenceTypeDropdownValue = referenceTypes[0][1];
    referenceParameterDropdownValues = [];
    currentReferenceParameters = [];
    for (int i = 0; i < referenceParameters.length; i++) {
      if (referenceParameters[i][0] == referenceTypeDropdownValue) {
        referenceParameterDropdownValues.add(referenceParameters[i][2]);
        List<String> l = [];
        for (int y = 1; y < referenceParameters[i].length; y++) {
          l.add(referenceParameters[i][y]);
        }
        currentReferenceParameters.add(l);
      }
    }
    rangeReferenceParameterControllers = [];
    for (int i = 0; i < rangeReferenceParameters.length; i++) {
      if (rangeReferenceParameters[i][0] == referenceTypeDropdownValue) {
        rangeReferenceParameterControllers.add(new TextEditingController());
        currentReferenceParameters.add([rangeReferenceParameters[i][1]]);
      }
    }
    typeDropdownValue = "Auction";
    if (userHandler.user.currentType == "Consumer") {
      templateIDDropdownValue = auctionHandler.consumerContractTemplates.templates[0].id.toString();
      templateIDs = [];
      for (int i = 0; i < auctionHandler.consumerContractTemplates.templates.length; i++) {
        templateIDs.add(auctionHandler.consumerContractTemplates.templates[i].id.toString());
      }
      template = auctionHandler.consumerContractTemplates.templates[0];
    }
    if (userHandler.user.currentType == "Supplier") {
      templateIDDropdownValue = auctionHandler.supplierContractTemplates.templates[0].id.toString();
      templateIDs = [];
      for (int i = 0; i < auctionHandler.supplierContractTemplates.templates.length; i++) {
        templateIDs.add(auctionHandler.supplierContractTemplates.templates[i].id.toString());
      }
      template = auctionHandler.supplierContractTemplates.templates[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    Map materialAuctions = split(materialAuctions: auctionHandler.myAuctions.materialAuctions.materialAuctions, time: now);
    Map referencetype2Auctions = split(referencetype2Auctions: auctionHandler.myAuctions.referencetype2Auctions.referencetype2Auctions, time: now);

    return new Container(
      color: Colors.grey[900],
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.35,
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
                tooltip: 'New listing',
                onPressed: () {
                  showTemplateGUI();
                },
              ),
            ]),
          ),
          //TODO: Collapseable categories?
          SliverToBoxAdapter(
            child: Container(
              height: Size.fromHeight(kToolbarHeight).height * 0.5,
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text("Ongoing auctions"),
            ),
          ),
          materialAuctions["ongoing"].length == 0 && referencetype2Auctions["ongoing"].length == 0
              ? SliverToBoxAdapter(
                  child: Center(
                  child: Text("No ongoing auctions"),
                ))
              : SliverToBoxAdapter(),
          buildAuctionList(materialAuctions: materialAuctions["ongoing"]),
          buildAuctionList(referencetype2Auctions: referencetype2Auctions["ongoing"]),
          SliverToBoxAdapter(
            child: Container(
              height: Size.fromHeight(kToolbarHeight).height * 0.5,
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text("Finished auctions"),
            ),
          ),
          materialAuctions["finished"].length == 0 && referencetype2Auctions["finished"].length == 0
              ? SliverToBoxAdapter(
                  child: Center(
                  child: Text("No finished auctions"),
                ))
              : SliverToBoxAdapter(),
          buildAuctionList(materialAuctions: materialAuctions["finished"]),
          buildAuctionList(referencetype2Auctions: referencetype2Auctions["finished"]),
          SliverToBoxAdapter(
            child: Container(
              height: Size.fromHeight(kToolbarHeight).height * 0.5,
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text("Offers"),
            ),
          ),
          offerHandler.myOffers.materialOffers.materialOffers.length == 0 && offerHandler.myOffers.referencetype2Offers.referencetype2Offers.length == 0
              ? SliverToBoxAdapter(
                  child: Center(
                  child: Text("No offers"),
                ))
              : SliverToBoxAdapter(),
          buildAuctionList(materialOffers: offerHandler.myOffers.materialOffers.materialOffers),
          buildAuctionList(referencetype2Offers: offerHandler.myOffers.referencetype2Offers.referencetype2Offers),
        ],
      ),
    );
  }

  //Maps the a list of auctions into "finished" and "ongoing"
  Map split({List<MaterialAuction> materialAuctions, List<Referencetype2Auction> referencetype2Auctions, DateTime time}) {
    if (materialAuctions != null) {
      List<MaterialAuction> finished = [];
      List<MaterialAuction> ongoing = [];

      for (int i = 0; i < materialAuctions.length; i++) {
        time.isAfter(materialAuctions[i].stopDate) ? finished.add(materialAuctions[i]) : ongoing.add(materialAuctions[i]);
      }

      return {"finished": finished, "ongoing": ongoing};
    }
    if (referencetype2Auctions != null) {
      List<Referencetype2Auction> finished = [];
      List<Referencetype2Auction> ongoing = [];

      for (int i = 0; i < referencetype2Auctions.length; i++) {
        time.isAfter(referencetype2Auctions[i].stopDate) ? finished.add(referencetype2Auctions[i]) : ongoing.add(referencetype2Auctions[i]);
      }

      return {"finished": finished, "ongoing": ongoing};
    }
    return {"finished": [], "ongoing": []};
  }

  //Builder function for the auction list
  SliverList buildAuctionList(
      {List<MaterialAuction> materialAuctions,
      List<Referencetype2Auction> referencetype2Auctions,
      List<MaterialOffer> materialOffers,
      List<Referencetype2Offer> referencetype2Offers}) {
    DateTime now = DateTime.now();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 3, offset: Offset(0, 4))],
              color: materialAuctions != null
                  ? (materialAuctions[index].stopDate.isAfter(now) ? Color.fromRGBO(26, 56, 84, 1) : Color.fromRGBO(90, 47, 100, 1))
                  : referencetype2Auctions != null
                      ? (referencetype2Auctions[index].stopDate.isAfter(now) ? Color.fromRGBO(26, 56, 84, 1) : Color.fromRGBO(90, 47, 100, 1))
                      : materialOffers != null
                          ? (materialOffers[index].stopDate.isAfter(now) ? Color.fromRGBO(26, 56, 84, 1) : Color.fromRGBO(90, 47, 100, 1))
                          : (referencetype2Offers != null
                              ? (referencetype2Offers[index].stopDate.isAfter(now) ? Color.fromRGBO(26, 56, 84, 1) : Color.fromRGBO(90, 47, 100, 1))
                              : null),
            ),
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Title: ",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                              Text(materialAuctions != null
                                  ? materialAuctions[index].title
                                  : (materialOffers != null
                                      ? materialOffers[index].title
                                      : (referencetype2Auctions != null ? referencetype2Auctions[index].title : referencetype2Offers[index].title))),
                            ],
                          ),
                          Row(
                            children: materialAuctions != null
                                ? [
                                    Row(
                                      children: [
                                        Text(
                                          "Participants: ",
                                          style: TextStyle(
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        Text(
                                          materialAuctions[index].currentParticipants.toString() + "/" + materialAuctions[index].maxParticipants.toString(),
                                        ),
                                      ],
                                    ),
                                  ]
                                : (referencetype2Auctions != null
                                    ? [
                                        Row(
                                          children: [
                                            Text(
                                              "Participants: ",
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                            Text(
                                              referencetype2Auctions[index].currentParticipants.toString() +
                                                  "/" +
                                                  referencetype2Auctions[index].maxParticipants.toString(),
                                            ),
                                          ],
                                        ),
                                      ]
                                    : [Text("")]),
                          ),
                          Row(
                            children: [
                              Text(
                                "Start date: ",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                              Text(materialAuctions != null
                                  ? materialAuctions[index].startDate.toString().substring(0, 19)
                                  : (materialOffers != null
                                      ? materialOffers[index].startDate.toString().substring(0, 19)
                                      : (referencetype2Auctions != null
                                          ? referencetype2Auctions[index].startDate.toString().substring(0, 19)
                                          : referencetype2Offers[index].startDate.toString().substring(0, 19)))),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Stop date: ",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                              Text(materialAuctions != null
                                  ? materialAuctions[index].stopDate.toString().substring(0, 19)
                                  : (materialOffers != null
                                      ? materialOffers[index].stopDate.toString().substring(0, 19)
                                      : (referencetype2Auctions != null
                                          ? referencetype2Auctions[index].stopDate.toString().substring(0, 19)
                                          : referencetype2Offers[index].stopDate.toString().substring(0, 19)))),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: (materialAuctions != null || materialOffers != null)
                            ? [
                                Row(
                                  children: [
                                    Text(
                                      "Fibers type: ",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text(
                                      materialAuctions != null
                                          ? materialAuctions[index].materialReferenceParameters.fibersType
                                          : materialOffers[index].materialReferenceParameters.fibersType,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Resin type: ",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text(materialAuctions != null
                                        ? materialAuctions[index].materialReferenceParameters.resinType
                                        : materialOffers[index].materialReferenceParameters.resinType),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Minimum fiber length: ",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text((materialAuctions != null
                                            ? materialAuctions[index].materialReferenceParameters.minFiberLength
                                            : materialOffers[index].materialReferenceParameters.minFiberLength)
                                        .toString()),
                                    Text("mm"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Maximum fiber length: ",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text((materialAuctions != null
                                            ? materialAuctions[index].materialReferenceParameters.maxFiberLength
                                            : materialOffers[index].materialReferenceParameters.maxFiberLength)
                                        .toString()),
                                    Text("mm"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Recycling technology: ",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text(materialAuctions != null
                                        ? materialAuctions[index].materialReferenceParameters.recyclingTechnology
                                        : materialOffers[index].materialReferenceParameters.recyclingTechnology),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Sizing: ",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text(materialAuctions != null
                                        ? materialAuctions[index].materialReferenceParameters.sizing
                                        : materialOffers[index].materialReferenceParameters.sizing),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Additives: ",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text(materialAuctions != null
                                        ? materialAuctions[index].materialReferenceParameters.additives
                                        : materialOffers[index].materialReferenceParameters.additives),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Minimum volume: ",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text((materialAuctions != null
                                            ? materialAuctions[index].materialReferenceParameters.minVolume
                                            : materialOffers[index].materialReferenceParameters.minVolume)
                                        .toString()),
                                    Text("kg"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Maximum volume: ",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text((materialAuctions != null
                                            ? materialAuctions[index].materialReferenceParameters.maxVolume
                                            : materialOffers[index].materialReferenceParameters.maxVolume)
                                        .toString()),
                                    Text("kg"),
                                  ],
                                ),
                              ]
                            : [
                                Row(
                                  children: [
                                    Text(
                                      "Parameter 1: ",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text(referencetype2Auctions != null
                                        ? referencetype2Auctions[index].referencetype2ReferenceParameters.parameter1
                                        : referencetype2Offers[index].referencetype2ReferenceParameters.parameter1),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Parameter 2: ",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text(referencetype2Auctions != null
                                        ? referencetype2Auctions[index].referencetype2ReferenceParameters.parameter2
                                        : referencetype2Offers[index].referencetype2ReferenceParameters.parameter2),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Minimum volume: ",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text((referencetype2Auctions != null
                                            ? referencetype2Auctions[index].referencetype2ReferenceParameters.minVolume
                                            : referencetype2Offers[index].referencetype2ReferenceParameters.minVolume)
                                        .toString()),
                                    Text("kg"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Maximum volume: ",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Text((referencetype2Auctions != null
                                            ? referencetype2Auctions[index].referencetype2ReferenceParameters.maxVolume
                                            : referencetype2Offers[index].referencetype2ReferenceParameters.maxVolume)
                                        .toString()),
                                    Text("kg"),
                                  ],
                                ),
                              ],
                      ),
                      Spacer(),
                      Container(
                        child: (materialAuctions != null
                            ? ElevatedButton(
                                child: Text("Visit room"),
                                onPressed: () {
                                  auctionHandler.setCurrentAuction(materialAuctions[index].id);
                                  navigate(WidgetMarker.room);
                                },
                              )
                            : (referencetype2Auctions != null
                                ? ElevatedButton(
                                    child: Text("Visit room"),
                                    onPressed: () {
                                      auctionHandler.setCurrentAuction(referencetype2Auctions[index].id);
                                      navigate(WidgetMarker.room);
                                    },
                                  )
                                : (materialOffers != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          offerHandler.viewOffer(materialOffers[index].templateId, materialOffers[index].keyValuePairs, context);
                                        },
                                        child: Text("View Offer"),
                                      )
                                    : (referencetype2Offers != null
                                        ? ElevatedButton(
                                            onPressed: () {
                                              offerHandler.viewOffer(
                                                  referencetype2Offers[index].templateId, referencetype2Offers[index].keyValuePairs, context);
                                            },
                                            child: Text("View Offer"),
                                          )
                                        : null)))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        childCount: materialAuctions != null
            ? materialAuctions.length
            : (materialOffers != null ? materialOffers.length : (referencetype2Auctions != null ? referencetype2Auctions.length : referencetype2Offers.length)),
      ),
    );
  }

  void showTemplateGUI() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final ThemeData themeData = Theme.of(context);

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            color: themeData.primaryColor,
            width: MediaQuery.of(context).size.width * 0.5,
            margin: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 18.0,
                  ),
                  margin: EdgeInsets.only(top: 13.0, right: 8.0),
                  decoration: BoxDecoration(
                    //color: Colors.red,
                    color: Colors.grey[900], //Couldn't import from theme as "Dialog" is transparent
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 0.0,
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              return Column(
                                children: [
                                  Text(
                                    typeDropdownValue == "Auction" ? "Create new auction" : "Create new offer",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 2,
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Listing type: "),
                                      DropdownButton(
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        value: typeDropdownValue,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.white),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            typeDropdownValue = newValue;
                                            if (typeDropdownValue == "Auction") {
                                              if (userHandler.user.currentType == "Consumer") {
                                                templateIDDropdownValue = auctionHandler.consumerContractTemplates.templates[0].id.toString();
                                                templateIDs = [];
                                                for (int i = 0; i < auctionHandler.consumerContractTemplates.templates.length; i++) {
                                                  templateIDs.add(auctionHandler.consumerContractTemplates.templates[i].id.toString());
                                                }
                                                template = auctionHandler.consumerContractTemplates.templates[0];
                                              }
                                              if (userHandler.user.currentType == "Supplier") {
                                                templateIDDropdownValue = auctionHandler.supplierContractTemplates.templates[0].id.toString();
                                                templateIDs = [];
                                                for (int i = 0; i < auctionHandler.supplierContractTemplates.templates.length; i++) {
                                                  templateIDs.add(auctionHandler.supplierContractTemplates.templates[i].id.toString());
                                                }
                                                template = auctionHandler.supplierContractTemplates.templates[0];
                                              }
                                            }
                                            if (typeDropdownValue == "Offer") {
                                              if (userHandler.user.currentType == "Consumer") {
                                                templateIDDropdownValue = offerHandler.consumerOfferTemplates.templates[0].id.toString();
                                                templateIDs = [];
                                                for (int i = 0; i < offerHandler.consumerOfferTemplates.templates.length; i++) {
                                                  templateIDs.add(offerHandler.consumerOfferTemplates.templates[i].id.toString());
                                                }
                                                template = offerHandler.consumerOfferTemplates.templates[0];
                                              }
                                              if (userHandler.user.currentType == "Supplier") {
                                                templateIDDropdownValue = offerHandler.supplierOfferTemplates.templates[0].id.toString();
                                                templateIDs = [];
                                                for (int i = 0; i < offerHandler.supplierOfferTemplates.templates.length; i++) {
                                                  templateIDs.add(offerHandler.supplierOfferTemplates.templates[i].id.toString());
                                                }
                                                template = offerHandler.supplierOfferTemplates.templates[0];
                                              }
                                              offerControllers = [];
                                              for (int i = 0; i < template.templateVariables.length; i++) {
                                                offerControllers.add(new TextEditingController());
                                              }
                                            }
                                          });
                                        },
                                        items: types.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(width: 30.0),
                                      Text("Reference sector: "),
                                      DropdownButton(
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        value: referenceSectorDropdownValue,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.white),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            referenceSectorDropdownValue = newValue;
                                          });
                                        },
                                        items: getReferenceSectors().map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(width: 30.0),
                                      Text("Reference type: "),
                                      DropdownButton(
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        value: referenceTypeDropdownValue,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.white),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            referenceTypeDropdownValue = newValue;
                                            referenceParameterDropdownValues = [];
                                            currentReferenceParameters = [];
                                            for (int i = 0; i < referenceParameters.length; i++) {
                                              if (referenceParameters[i][0] == referenceTypeDropdownValue) {
                                                referenceParameterDropdownValues.add(referenceParameters[i][2]);
                                                List<String> l = [];
                                                for (int y = 1; y < referenceParameters[i].length; y++) {
                                                  l.add(referenceParameters[i][y]);
                                                }
                                                currentReferenceParameters.add(l);
                                              }
                                            }
                                            rangeReferenceParameterControllers = [];
                                            for (int i = 0; i < rangeReferenceParameters.length; i++) {
                                              if (rangeReferenceParameters[i][0] == referenceTypeDropdownValue) {
                                                rangeReferenceParameterControllers.add(new TextEditingController());
                                                currentReferenceParameters.add([rangeReferenceParameters[i][1]]);
                                              }
                                            }
                                          });
                                        },
                                        items: getReferenceTypes().map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.0),
                                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Text(typeDropdownValue == "Auction" ? "Auction Title: " : "Offer Title: "),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.15,
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      child: TextField(
                                        controller: title,
                                      ),
                                    ),
                                    SizedBox(width: 30.0),
                                    Text("Duration: "),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.03,
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                        controller: duration,
                                      ),
                                    ),
                                    SizedBox(width: 30.0),
                                    Text(typeDropdownValue == "Auction" ? "Max participants: " : ""),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.03,
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      child: typeDropdownValue == "Auction"
                                          ? TextField(
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                              controller: maxParticipants,
                                            )
                                          : null,
                                    ),
                                  ]),
                                  SizedBox(height: 20.0),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: ((referenceParameterDropdownValues.length + rangeReferenceParameterControllers.length) / 3).ceil(),
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: ((index + 1) ==
                                                      ((referenceParameterDropdownValues.length + rangeReferenceParameterControllers.length) / 3).ceil()) &&
                                                  ((referenceParameterDropdownValues.length + rangeReferenceParameterControllers.length) - (index * 3) != 3)
                                              ? (((referenceParameterDropdownValues.length + rangeReferenceParameterControllers.length) - (index * 3)) == 1
                                                  ? [
                                                      Row(
                                                        children: ((index * 3) < referenceParameterDropdownValues.length)
                                                            ? [
                                                                Text(currentReferenceParameters[(index * 3)][0] + ": "),
                                                                DropdownButton(
                                                                  icon: Icon(Icons.arrow_downward),
                                                                  iconSize: 24,
                                                                  value: referenceParameterDropdownValues[(index * 3)],
                                                                  elevation: 16,
                                                                  style: TextStyle(color: Colors.white),
                                                                  onChanged: (String newValue) {
                                                                    setState(() {
                                                                      referenceParameterDropdownValues[(index * 3)] = newValue;
                                                                    });
                                                                  },
                                                                  items: getReferenceParameters((index * 3)).map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ]
                                                            : [
                                                                Text(currentReferenceParameters[(index * 3)][0] + ": "),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.05,
                                                                  height: MediaQuery.of(context).size.height * 0.05,
                                                                  child: TextField(
                                                                    keyboardType: TextInputType.number,
                                                                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                                    controller: rangeReferenceParameterControllers[
                                                                        (index * 3) - referenceParameterDropdownValues.length],
                                                                  ),
                                                                ),
                                                              ],
                                                      ),
                                                    ]
                                                  : [
                                                      Row(
                                                        children: ((index * 3) < referenceParameterDropdownValues.length)
                                                            ? [
                                                                Text(currentReferenceParameters[(index * 3)][0] + ": "),
                                                                DropdownButton(
                                                                  icon: Icon(Icons.arrow_downward),
                                                                  iconSize: 24,
                                                                  value: referenceParameterDropdownValues[(index * 3)],
                                                                  elevation: 16,
                                                                  style: TextStyle(color: Colors.white),
                                                                  onChanged: (String newValue) {
                                                                    setState(() {
                                                                      referenceParameterDropdownValues[(index * 3)] = newValue;
                                                                    });
                                                                  },
                                                                  items: getReferenceParameters((index * 3)).map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ]
                                                            : [
                                                                Text(currentReferenceParameters[(index * 3)][0] + ": "),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.05,
                                                                  height: MediaQuery.of(context).size.height * 0.05,
                                                                  child: TextField(
                                                                    keyboardType: TextInputType.number,
                                                                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                                    controller: rangeReferenceParameterControllers[
                                                                        (index * 3) - referenceParameterDropdownValues.length],
                                                                  ),
                                                                ),
                                                              ],
                                                      ),
                                                      SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Row(
                                                        children: ((index * 3) + 1 < referenceParameterDropdownValues.length)
                                                            ? [
                                                                Text(currentReferenceParameters[(index * 3) + 1][0] + ": "),
                                                                DropdownButton(
                                                                  icon: Icon(Icons.arrow_downward),
                                                                  iconSize: 24,
                                                                  value: referenceParameterDropdownValues[(index * 3) + 1],
                                                                  elevation: 16,
                                                                  style: TextStyle(color: Colors.white),
                                                                  onChanged: (String newValue) {
                                                                    setState(() {
                                                                      referenceParameterDropdownValues[(index * 3) + 1] = newValue;
                                                                    });
                                                                  },
                                                                  items: getReferenceParameters((index * 3) + 1).map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ]
                                                            : [
                                                                Text(currentReferenceParameters[(index * 3) + 1][0] + ": "),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.05,
                                                                  height: MediaQuery.of(context).size.height * 0.05,
                                                                  child: TextField(
                                                                    keyboardType: TextInputType.number,
                                                                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                                    controller: rangeReferenceParameterControllers[
                                                                        (index * 3) + 1 - referenceParameterDropdownValues.length],
                                                                  ),
                                                                ),
                                                              ],
                                                      ),
                                                    ])
                                              : [
                                                  Row(
                                                    children: ((index * 3) < referenceParameterDropdownValues.length)
                                                        ? [
                                                            Text(currentReferenceParameters[(index * 3)][0] + ": "),
                                                            DropdownButton(
                                                              icon: Icon(Icons.arrow_downward),
                                                              iconSize: 24,
                                                              value: referenceParameterDropdownValues[(index * 3)],
                                                              elevation: 16,
                                                              style: TextStyle(color: Colors.white),
                                                              onChanged: (String newValue) {
                                                                setState(() {
                                                                  referenceParameterDropdownValues[(index * 3)] = newValue;
                                                                });
                                                              },
                                                              items: getReferenceParameters((index * 3)).map<DropdownMenuItem<String>>((String value) {
                                                                return DropdownMenuItem<String>(
                                                                  value: value,
                                                                  child: Text(value),
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ]
                                                        : [
                                                            Text(currentReferenceParameters[(index * 3)][0] + ": "),
                                                            Container(
                                                              width: MediaQuery.of(context).size.width * 0.05,
                                                              height: MediaQuery.of(context).size.height * 0.05,
                                                              child: TextField(
                                                                keyboardType: TextInputType.number,
                                                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                                controller:
                                                                    rangeReferenceParameterControllers[(index * 3) - referenceParameterDropdownValues.length],
                                                              ),
                                                            ),
                                                          ],
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Row(
                                                    children: ((index * 3) + 1 < referenceParameterDropdownValues.length)
                                                        ? [
                                                            Text(currentReferenceParameters[(index * 3) + 1][0] + ": "),
                                                            DropdownButton(
                                                              icon: Icon(Icons.arrow_downward),
                                                              iconSize: 24,
                                                              value: referenceParameterDropdownValues[(index * 3) + 1],
                                                              elevation: 16,
                                                              style: TextStyle(color: Colors.white),
                                                              onChanged: (String newValue) {
                                                                setState(() {
                                                                  referenceParameterDropdownValues[(index * 3) + 1] = newValue;
                                                                });
                                                              },
                                                              items: getReferenceParameters((index * 3) + 1).map<DropdownMenuItem<String>>((String value) {
                                                                return DropdownMenuItem<String>(
                                                                  value: value,
                                                                  child: Text(value),
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ]
                                                        : [
                                                            Text(currentReferenceParameters[(index * 3) + 1][0] + ": "),
                                                            Container(
                                                              width: MediaQuery.of(context).size.width * 0.05,
                                                              height: MediaQuery.of(context).size.height * 0.05,
                                                              child: TextField(
                                                                keyboardType: TextInputType.number,
                                                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                                controller: rangeReferenceParameterControllers[
                                                                    (index * 3) + 1 - referenceParameterDropdownValues.length],
                                                              ),
                                                            ),
                                                          ],
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Row(
                                                    children: ((index * 3) + 2 < referenceParameterDropdownValues.length)
                                                        ? [
                                                            Text(currentReferenceParameters[(index * 3) + 2][0] + ": "),
                                                            DropdownButton(
                                                              icon: Icon(Icons.arrow_downward),
                                                              iconSize: 24,
                                                              value: referenceParameterDropdownValues[(index * 3) + 2],
                                                              elevation: 16,
                                                              style: TextStyle(color: Colors.white),
                                                              onChanged: (String newValue) {
                                                                setState(() {
                                                                  referenceParameterDropdownValues[(index * 3) + 2] = newValue;
                                                                });
                                                              },
                                                              items: getReferenceParameters((index * 3) + 2).map<DropdownMenuItem<String>>((String value) {
                                                                return DropdownMenuItem<String>(
                                                                  value: value,
                                                                  child: Text(value),
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ]
                                                        : [
                                                            Text(currentReferenceParameters[(index * 3) + 2][0] + ": "),
                                                            Container(
                                                              width: MediaQuery.of(context).size.width * 0.05,
                                                              height: MediaQuery.of(context).size.height * 0.05,
                                                              child: TextField(
                                                                keyboardType: TextInputType.number,
                                                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                                controller: rangeReferenceParameterControllers[
                                                                    (index * 3) + 2 - referenceParameterDropdownValues.length],
                                                              ),
                                                            ),
                                                          ],
                                                  ),
                                                ],
                                        );
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Template ID: "),
                                      DropdownButton(
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        value: templateIDDropdownValue,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.white),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            templateIDDropdownValue = newValue;
                                            if (typeDropdownValue == "Auction") {
                                              if (userHandler.user.currentType == "Consumer") {
                                                for (int i = 0; i < auctionHandler.consumerContractTemplates.templates.length; i++) {
                                                  if (auctionHandler.consumerContractTemplates.templates[i].id.toString() == templateIDDropdownValue) {
                                                    template = auctionHandler.consumerContractTemplates.templates[i];
                                                  }
                                                }
                                              }
                                              if (userHandler.user.currentType == "Supplier") {
                                                for (int i = 0; i < auctionHandler.supplierContractTemplates.templates.length; i++) {
                                                  if (auctionHandler.supplierContractTemplates.templates[i].id.toString() == templateIDDropdownValue) {
                                                    template = auctionHandler.supplierContractTemplates.templates[i];
                                                  }
                                                }
                                              }
                                            }
                                            if (typeDropdownValue == "Offer") {
                                              if (userHandler.user.currentType == "Consumer") {
                                                for (int i = 0; i < offerHandler.consumerOfferTemplates.templates.length; i++) {
                                                  if (offerHandler.consumerOfferTemplates.templates[i].id.toString() == templateIDDropdownValue) {
                                                    template = offerHandler.consumerOfferTemplates.templates[i];
                                                  }
                                                }
                                              }
                                              if (userHandler.user.currentType == "Supplier") {
                                                for (int i = 0; i < offerHandler.supplierOfferTemplates.templates.length; i++) {
                                                  if (offerHandler.supplierOfferTemplates.templates[i].id.toString() == templateIDDropdownValue) {
                                                    template = offerHandler.supplierOfferTemplates.templates[i];
                                                  }
                                                }
                                              }
                                            }
                                          });
                                        },
                                        items: templateIDs.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    typeDropdownValue == "Auction" ? "Contract Template" : "Your Offer",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5,
                                  ),
                                  SizedBox(height: 20.0),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: template.templateVariables.length,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return Column(
                                            children: [
                                              Text(
                                                template.templateStrings[0].text,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 20.0),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: typeDropdownValue == "Auction"
                                                    ? [
                                                        Text(
                                                          "Key: ",
                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                        ),
                                                        Text(
                                                          template.templateVariables[0].key,
                                                          style: TextStyle(fontStyle: FontStyle.italic),
                                                        ),
                                                        Text(
                                                          " Value Type: ",
                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                        ),
                                                        Text(
                                                          template.templateVariables[0].valueType,
                                                          style: TextStyle(fontStyle: FontStyle.italic),
                                                        ),
                                                      ]
                                                    : [
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.2,
                                                          height: MediaQuery.of(context).size.height * 0.05,
                                                          child: template.templateVariables[0].valueType == "Text"
                                                              ? TextField(
                                                                  controller: offerControllers[0],
                                                                  decoration: InputDecoration(
                                                                    hintText: template.templateVariables[0].key,
                                                                  ),
                                                                )
                                                              : (template.templateVariables[0].valueType == "Integer"
                                                                  ? TextField(
                                                                      controller: offerControllers[0],
                                                                      keyboardType: TextInputType.number,
                                                                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                                      decoration: InputDecoration(
                                                                        hintText: template.templateVariables[0].key,
                                                                      ),
                                                                    )
                                                                  : null),
                                                        ),
                                                      ],
                                              ),
                                              SizedBox(height: 20.0),
                                              Text(
                                                template.templateStrings[1].text,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          );
                                        }
                                        return Column(
                                          children: [
                                            SizedBox(height: 20.0),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: typeDropdownValue == "Auction"
                                                  ? [
                                                      Text(
                                                        "Key: ",
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        template.templateVariables[index].key,
                                                        style: TextStyle(fontStyle: FontStyle.italic),
                                                      ),
                                                      Text(
                                                        " Value Type: ",
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        template.templateVariables[index].valueType,
                                                        style: TextStyle(fontStyle: FontStyle.italic),
                                                      ),
                                                    ]
                                                  : [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 0.2,
                                                        height: MediaQuery.of(context).size.height * 0.05,
                                                        child: template.templateVariables[index].valueType == "Text"
                                                            ? TextField(
                                                                controller: offerControllers[index],
                                                                decoration: InputDecoration(
                                                                  hintText: template.templateVariables[index].key,
                                                                ),
                                                              )
                                                            : (template.templateVariables[index].valueType == "Integer"
                                                                ? TextField(
                                                                    controller: offerControllers[index],
                                                                    keyboardType: TextInputType.number,
                                                                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                                    decoration: InputDecoration(
                                                                      hintText: template.templateVariables[index].key,
                                                                    ),
                                                                  )
                                                                : null),
                                                      ),
                                                    ],
                                            ),
                                            SizedBox(height: 20.0),
                                            Text(
                                              template.templateStrings[index + 1].text,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          child: Text(typeDropdownValue == "Auction" ? "Create auction" : "Create offer"),
                          onPressed: () {
                            if (typeDropdownValue == "Auction") {
                              if (referenceTypeDropdownValue == "material") {
                                auctionHandler.createMaterialAuction(
                                    int.parse(templateIDDropdownValue),
                                    title.text,
                                    int.parse(maxParticipants.text),
                                    int.parse(duration.text),
                                    referenceParameterDropdownValues[0],
                                    referenceParameterDropdownValues[1],
                                    referenceParameterDropdownValues[2],
                                    referenceParameterDropdownValues[3],
                                    referenceParameterDropdownValues[4],
                                    int.parse(rangeReferenceParameterControllers[0].text),
                                    int.parse(rangeReferenceParameterControllers[1].text),
                                    int.parse(rangeReferenceParameterControllers[2].text),
                                    int.parse(rangeReferenceParameterControllers[3].text));
                              }
                              if (referenceTypeDropdownValue == "referencetype2") {
                                auctionHandler.createReferencetype2Auction(
                                    int.parse(templateIDDropdownValue),
                                    title.text,
                                    int.parse(maxParticipants.text),
                                    int.parse(duration.text),
                                    referenceParameterDropdownValues[0],
                                    referenceParameterDropdownValues[1],
                                    int.parse(rangeReferenceParameterControllers[0].text),
                                    int.parse(rangeReferenceParameterControllers[1].text));
                              }
                            }
                            if (typeDropdownValue == "Offer") {
                              List<KeyValuePair> keyValuePairs = [];
                              for (int i = 0; i < template.templateVariables.length; i++) {
                                if (template.templateVariables[i].valueType == "Text") {
                                  keyValuePairs.add(KeyValuePair(key: template.templateVariables[i].key, value: offerControllers[i].text));
                                }
                                if (template.templateVariables[i].valueType == "Integer") {
                                  keyValuePairs.add(KeyValuePair(key: template.templateVariables[i].key, value: int.parse(offerControllers[i].text)));
                                }
                              }
                              if (referenceTypeDropdownValue == "material") {
                                offerHandler.createMaterialOffer(
                                    int.parse(templateIDDropdownValue),
                                    title.text,
                                    keyValuePairs,
                                    int.parse(duration.text),
                                    referenceParameterDropdownValues[0],
                                    referenceParameterDropdownValues[1],
                                    referenceParameterDropdownValues[2],
                                    referenceParameterDropdownValues[3],
                                    referenceParameterDropdownValues[4],
                                    int.parse(rangeReferenceParameterControllers[0].text),
                                    int.parse(rangeReferenceParameterControllers[1].text),
                                    int.parse(rangeReferenceParameterControllers[2].text),
                                    int.parse(rangeReferenceParameterControllers[3].text));
                              }
                              if (referenceTypeDropdownValue == "referencetype2") {
                                offerHandler.createReferencetype2Offer(
                                    int.parse(templateIDDropdownValue),
                                    title.text,
                                    keyValuePairs,
                                    int.parse(duration.text),
                                    referenceParameterDropdownValues[0],
                                    referenceParameterDropdownValues[1],
                                    int.parse(rangeReferenceParameterControllers[0].text),
                                    int.parse(rangeReferenceParameterControllers[1].text));
                              }
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        title.clear();
                        maxParticipants.clear();
                        duration.clear();
                        referenceSectorDropdownValue = referenceTypes[0][0];
                        referenceTypeDropdownValue = referenceTypes[0][1];
                        referenceParameterDropdownValues = [];
                        currentReferenceParameters = [];
                        for (int i = 0; i < referenceParameters.length; i++) {
                          if (referenceParameters[i][0] == referenceTypeDropdownValue) {
                            referenceParameterDropdownValues.add(referenceParameters[i][2]);
                            List<String> l = [];
                            for (int y = 1; y < referenceParameters[i].length; y++) {
                              l.add(referenceParameters[i][y]);
                            }
                            currentReferenceParameters.add(l);
                          }
                        }
                        rangeReferenceParameterControllers = [];
                        for (int i = 0; i < rangeReferenceParameters.length; i++) {
                          if (rangeReferenceParameters[i][0] == referenceTypeDropdownValue) {
                            rangeReferenceParameterControllers.add(new TextEditingController());
                            currentReferenceParameters.add([rangeReferenceParameters[i][1]]);
                          }
                        }
                        typeDropdownValue = "Auction";
                        if (userHandler.user.currentType == "Consumer") {
                          templateIDDropdownValue = auctionHandler.consumerContractTemplates.templates[0].id.toString();
                          templateIDs = [];
                          for (int i = 0; i < auctionHandler.consumerContractTemplates.templates.length; i++) {
                            templateIDs.add(auctionHandler.consumerContractTemplates.templates[i].id.toString());
                          }
                          template = auctionHandler.consumerContractTemplates.templates[0];
                        }
                        if (userHandler.user.currentType == "Supplier") {
                          templateIDDropdownValue = auctionHandler.supplierContractTemplates.templates[0].id.toString();
                          templateIDs = [];
                          for (int i = 0; i < auctionHandler.supplierContractTemplates.templates.length; i++) {
                            templateIDs.add(auctionHandler.supplierContractTemplates.templates[i].id.toString());
                          }
                          template = auctionHandler.supplierContractTemplates.templates[0];
                        }
                      });
                      Navigator.of(context).pop();
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 14.0,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.close, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<String> getReferenceSectors() {
    List<String> l = [];
    for (int i = 0; i < referenceTypes.length; i++) {
      if (l.contains(referenceTypes[i][0])) {
        continue;
      }
      l.add(referenceTypes[i][0]);
    }
    return l;
  }

  List<String> getReferenceTypes() {
    List<String> l = [];
    for (int i = 0; i < referenceTypes.length; i++) {
      if (referenceTypes[i][0] == referenceSectorDropdownValue) {
        if (l.contains(referenceTypes[i][1])) {
          continue;
        }
        l.add(referenceTypes[i][1]);
      }
    }
    return l;
  }

  List<String> getReferenceParameters(int index) {
    List<String> l = [];
    for (int i = 1; i < currentReferenceParameters[index].length; i++) {
      l.add(currentReferenceParameters[index][i]);
    }
    return l;
  }
}
