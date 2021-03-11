import 'package:flutter/material.dart';
import 'package:new_project/Entities/userListJSON.dart';
import 'package:new_project/Handlers/offerHandler.dart';
import 'package:new_project/Handlers/userInfoHandler.dart';

import '../Handlers/auctionHandler.dart';
import '../Handlers/filterHandler.dart';
import '../mainGUI.dart';
import '../Entities/materialAuctionListJSON.dart';
import '../Entities/referencetype2AuctionListJSON.dart';
import '../Entities/materialOfferListJSON.dart';
import '../Entities/referencetype2OfferListJSON.dart';

enum PageMarker { ongoing, finished, offers }

class AllAuctions extends StatefulWidget {
  final Function navigate;
  final FilterHandler filterHandler;
  final AuctionHandler auctionHandler;
  final OfferHandler offerHandler;
  final UserInfoHandler userHandler;

  AllAuctions(this.navigate, this.filterHandler, this.auctionHandler, this.offerHandler, this.userHandler);

  @override
  _AllAuctionsState createState() => _AllAuctionsState(navigate, filterHandler, auctionHandler, offerHandler, userHandler);
}

class _AllAuctionsState extends State<AllAuctions> with SingleTickerProviderStateMixin<AllAuctions> {
  final Function navigate;
  final FilterHandler filterHandler;
  final AuctionHandler auctionHandler;
  final OfferHandler offerHandler;
  final UserInfoHandler userHandler;
  PageMarker _currentPage;
  String referenceTypeDropdownValue;
  String referenceSectorDropdownValue;
  List<List<String>> referenceTypes;

  _AllAuctionsState(this.navigate, this.filterHandler, this.auctionHandler, this.offerHandler, this.userHandler) {
    referenceTypes = [];
    for (int i = 0; i < filterHandler.filters.referenceSectors.length; i++) {
      for (int y = 0; y < filterHandler.filters.referenceSectors[i].referenceTypes.length; y++) {
        List<String> referenceType = [];
        referenceType.add(filterHandler.filters.referenceSectors[i].name);
        referenceType.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].name);
        referenceTypes.add(referenceType);
      }
    }
    referenceSectorDropdownValue = referenceTypes[0][0];
    referenceTypeDropdownValue = referenceTypes[0][1];
  }

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
      width: MediaQuery.of(context).size.width * 0.35,
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
              child: Row(
                children: [
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

  SliverList _getPageContainer() {
    switch (_currentPage) {
      case PageMarker.ongoing:
        return _getAuctions("Ongoing");
      case PageMarker.finished:
        return _getAuctions("Finished");
      case PageMarker.offers:
        return _getOffers();
    }
    return _getAuctions("Ongoing");
  }

  SliverList _getAuctions(String type) {
    var now = new DateTime.now();
    if (referenceTypeDropdownValue == "material") {
      List<MaterialAuction> materialAuctions = [];
      if (filterHandler.materialFilter == null) {
        for (int i = 0; i < auctionHandler.allAuctions.materialAuctions.materialAuctions.length; i++) {
          if (type == "Ongoing") {
            if (now.isBefore(auctionHandler.allAuctions.materialAuctions.materialAuctions[i].stopDate)) {
              materialAuctions.add(auctionHandler.allAuctions.materialAuctions.materialAuctions[i]);
            }
          }
          if (type == "Finished") {
            if (now.isAfter(auctionHandler.allAuctions.materialAuctions.materialAuctions[i].stopDate)) {
              materialAuctions.add(auctionHandler.allAuctions.materialAuctions.materialAuctions[i]);
            }
          }
        }
      } else {
        for (int i = 0; i < auctionHandler.allAuctions.materialAuctions.materialAuctions.length; i++) {
          if (type == "Ongoing") {
            if (now.isBefore(auctionHandler.allAuctions.materialAuctions.materialAuctions[i].stopDate)) {
              if (filterHandler.checkFilter(materialFilter: auctionHandler.allAuctions.materialAuctions.materialAuctions[i].materialReferenceParameters)) {
                materialAuctions.add(auctionHandler.allAuctions.materialAuctions.materialAuctions[i]);
              }
            }
          }
          if (type == "Finished") {
            if (now.isAfter(auctionHandler.allAuctions.materialAuctions.materialAuctions[i].stopDate)) {
              if (filterHandler.checkFilter(materialFilter: auctionHandler.allAuctions.materialAuctions.materialAuctions[i].materialReferenceParameters)) {
                materialAuctions.add(auctionHandler.allAuctions.materialAuctions.materialAuctions[i]);
              }
            }
          }
        }
      }
      return _generateBoxes(materialAuctions: materialAuctions);
    }

    if (referenceTypeDropdownValue == "referencetype2") {
      List<Referencetype2Auction> referencetype2Auctions = [];
      if (filterHandler.referencetype2Filter == null) {
        for (int i = 0; i < auctionHandler.allAuctions.referencetype2Auctions.referencetype2Auctions.length; i++) {
          if (type == "Ongoing") {
            if (now.isBefore(auctionHandler.allAuctions.referencetype2Auctions.referencetype2Auctions[i].stopDate)) {
              referencetype2Auctions.add(auctionHandler.allAuctions.referencetype2Auctions.referencetype2Auctions[i]);
            }
          }
          if (type == "Finished") {
            if (now.isAfter(auctionHandler.allAuctions.referencetype2Auctions.referencetype2Auctions[i].stopDate)) {
              referencetype2Auctions.add(auctionHandler.allAuctions.referencetype2Auctions.referencetype2Auctions[i]);
            }
          }
        }
      } else {
        for (int i = 0; i < auctionHandler.allAuctions.referencetype2Auctions.referencetype2Auctions.length; i++) {
          if (type == "Ongoing") {
            if (now.isBefore(auctionHandler.allAuctions.referencetype2Auctions.referencetype2Auctions[i].stopDate)) {
              if (filterHandler.checkFilter(
                  referencetype2Filter: auctionHandler.allAuctions.referencetype2Auctions.referencetype2Auctions[i].referencetype2ReferenceParameters)) {
                referencetype2Auctions.add(auctionHandler.allAuctions.referencetype2Auctions.referencetype2Auctions[i]);
              }
            }
          }
          if (type == "Finished") {
            if (now.isAfter(auctionHandler.allAuctions.referencetype2Auctions.referencetype2Auctions[i].stopDate)) {
              if (filterHandler.checkFilter(
                  referencetype2Filter: auctionHandler.allAuctions.referencetype2Auctions.referencetype2Auctions[i].referencetype2ReferenceParameters)) {
                referencetype2Auctions.add(auctionHandler.allAuctions.referencetype2Auctions.referencetype2Auctions[i]);
              }
            }
          }
        }
      }
      return _generateBoxes(referencetype2Auctions: referencetype2Auctions);
    }
  }

  SliverList _getOffers() {
    if (referenceTypeDropdownValue == "material") {
      List<MaterialOffer> materialOffers = [];
      if (filterHandler.materialFilter == null) {
        materialOffers = offerHandler.allOffers.materialOffers.materialOffers;
      } else {
        for (int i = 0; i < offerHandler.allOffers.materialOffers.materialOffers.length; i++) {
          if (filterHandler.checkFilter(materialFilter: offerHandler.allOffers.materialOffers.materialOffers[i].materialReferenceParameters)) {
            materialOffers.add(offerHandler.allOffers.materialOffers.materialOffers[i]);
          }
        }
      }
      return _generateBoxes(materialOffers: materialOffers);
    }

    if (referenceTypeDropdownValue == "referencetype2") {
      List<Referencetype2Offer> referencetype2Offers = [];
      if (filterHandler.referencetype2Filter == null) {
        referencetype2Offers = offerHandler.allOffers.referencetype2Offers.referencetype2Offers;
      } else {
        for (int i = 0; i < offerHandler.allOffers.referencetype2Offers.referencetype2Offers.length; i++) {
          if (filterHandler.checkFilter(
              referencetype2Filter: offerHandler.allOffers.referencetype2Offers.referencetype2Offers[i].referencetype2ReferenceParameters)) {
            referencetype2Offers.add(offerHandler.allOffers.referencetype2Offers.referencetype2Offers[i]);
          }
        }
      }
      return _generateBoxes(referencetype2Offers: referencetype2Offers);
    }
  }

  //Generates the auctionboxes themselves
  SliverList _generateBoxes(
      {List<MaterialAuction> materialAuctions,
      List<Referencetype2Auction> referencetype2Auctions,
      List<MaterialOffer> materialOffers,
      List<Referencetype2Offer> referencetype2Offers}) {
    DateTime now = DateTime.now();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          bool participant = false;
          bool requestSent = false;
          bool inviteSent = false;
          if (materialAuctions != null || referencetype2Auctions != null) {
            for (int i = 0; i < userHandler.user.participatingAuctions.length; i++) {
              if (materialAuctions != null) {
                if (userHandler.user.participatingAuctions[i].auctionId == materialAuctions[index].id) {
                  participant = true;
                  break;
                }
              }
              if (referencetype2Auctions != null) {
                if (userHandler.user.participatingAuctions[i].auctionId == referencetype2Auctions[index].id) {
                  participant = true;
                  break;
                }
              }
            }

            for (int i = 0; i < userHandler.user.requestInbox.length; i++) {
              if (materialAuctions != null) {
                if (userHandler.user.requestInbox[i].auctionId == materialAuctions[index].id && userHandler.user.requestInbox[i].status == "Sent") {
                  requestSent = true;
                  break;
                }
              }
              if (referencetype2Auctions != null) {
                if (userHandler.user.requestInbox[i].auctionId == referencetype2Auctions[index].id && userHandler.user.requestInbox[i].status == "Sent") {
                  requestSent = true;
                  break;
                }
              }
            }
          }
          if (materialOffers != null || referencetype2Auctions != null) {
            for (int i = 0; i < userHandler.user.inviteInbox.length; i++) {
              if (materialOffers != null) {
                if (userHandler.user.inviteInbox[i].offerId == materialOffers[index].id && userHandler.user.inviteInbox[i].status == "Sent") {
                  inviteSent = true;
                  break;
                }
              }
              if (referencetype2Offers != null) {
                if (userHandler.user.inviteInbox[i].offerId == referencetype2Offers[index].id && userHandler.user.inviteInbox[i].status == "Sent") {
                  inviteSent = true;
                  break;
                }
              }
            }
          }
          return Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.only(left: 10, right: 10),
            color: materialAuctions != null
                ? (materialAuctions[index].stopDate.isAfter(now) ? Colors.greenAccent[700] : Colors.redAccent[200])
                : referencetype2Auctions != null
                    ? (referencetype2Auctions[index].stopDate.isAfter(now) ? Colors.greenAccent[700] : Colors.redAccent[200])
                    : materialOffers != null
                        ? (materialOffers[index].stopDate.isAfter(now) ? Colors.greenAccent[700] : Colors.redAccent[200])
                        : (referencetype2Offers != null
                            ? (referencetype2Offers[index].stopDate.isAfter(now) ? Colors.greenAccent[700] : Colors.redAccent[200])
                            : null),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Title: ' +
                              (materialAuctions != null
                                  ? materialAuctions[index].title
                                  : (materialOffers != null
                                      ? materialOffers[index].title
                                      : (referencetype2Auctions != null ? referencetype2Auctions[index].title : referencetype2Offers[index].title)))),
                          Text(materialAuctions != null
                              ? " Participants: " +
                                  materialAuctions[index].currentParticipants.toString() +
                                  "/" +
                                  materialAuctions[index].maxParticipants.toString()
                              : (referencetype2Auctions != null
                                  ? " Participants: " +
                                      referencetype2Auctions[index].currentParticipants.toString() +
                                      "/" +
                                      referencetype2Auctions[index].maxParticipants.toString()
                                  : "")),
                          Text("Start date: " +
                              (materialAuctions != null
                                  ? materialAuctions[index].startDate.toString().substring(0, 19)
                                  : (materialOffers != null
                                      ? materialOffers[index].startDate.toString().substring(0, 19)
                                      : (referencetype2Auctions != null
                                          ? referencetype2Auctions[index].startDate.toString().substring(0, 19)
                                          : referencetype2Offers[index].startDate.toString().substring(0, 19))))),
                          Text("Stop date: " +
                              (materialAuctions != null
                                  ? materialAuctions[index].stopDate.toString().substring(0, 19)
                                  : (materialOffers != null
                                      ? materialOffers[index].stopDate.toString().substring(0, 19)
                                      : (referencetype2Auctions != null
                                          ? referencetype2Auctions[index].stopDate.toString().substring(0, 19)
                                          : referencetype2Offers[index].stopDate.toString().substring(0, 19))))),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: (materialAuctions != null || materialOffers != null)
                            ? [
                                Text("Fibers type: " +
                                    (materialAuctions != null
                                        ? materialAuctions[index].materialReferenceParameters.fibersType
                                        : materialOffers[index].materialReferenceParameters.fibersType)),
                                Text("Resin type: " +
                                    (materialAuctions != null
                                        ? materialAuctions[index].materialReferenceParameters.resinType
                                        : materialOffers[index].materialReferenceParameters.resinType)),
                                Text("Minimum fiber length: " +
                                    (materialAuctions != null
                                            ? materialAuctions[index].materialReferenceParameters.minFiberLength
                                            : materialOffers[index].materialReferenceParameters.minFiberLength)
                                        .toString() +
                                    "mm"),
                                Text("Maximum fiber length: " +
                                    (materialAuctions != null
                                            ? materialAuctions[index].materialReferenceParameters.maxFiberLength
                                            : materialOffers[index].materialReferenceParameters.maxFiberLength)
                                        .toString() +
                                    "mm"),
                                Text("Recycling technology: " +
                                    (materialAuctions != null
                                        ? materialAuctions[index].materialReferenceParameters.recyclingTechnology
                                        : materialOffers[index].materialReferenceParameters.recyclingTechnology)),
                                Text("Sizing: " +
                                    (materialAuctions != null
                                        ? materialAuctions[index].materialReferenceParameters.sizing
                                        : materialOffers[index].materialReferenceParameters.sizing)),
                                Text("Additives: " +
                                    (materialAuctions != null
                                        ? materialAuctions[index].materialReferenceParameters.additives
                                        : materialOffers[index].materialReferenceParameters.additives)),
                                Text("Minimum volume: " +
                                    (materialAuctions != null
                                            ? materialAuctions[index].materialReferenceParameters.minVolume
                                            : materialOffers[index].materialReferenceParameters.minVolume)
                                        .toString() +
                                    "kg"),
                                Text("Maximum volume: " +
                                    (materialAuctions != null
                                            ? materialAuctions[index].materialReferenceParameters.maxVolume
                                            : materialOffers[index].materialReferenceParameters.maxVolume)
                                        .toString() +
                                    "kg"),
                              ]
                            : [
                                Text("Parameter 1: " +
                                    (referencetype2Auctions != null
                                        ? referencetype2Auctions[index].referencetype2ReferenceParameters.parameter1
                                        : referencetype2Offers[index].referencetype2ReferenceParameters.parameter1)),
                                Text("Parameter 2: " +
                                    (referencetype2Auctions != null
                                        ? referencetype2Auctions[index].referencetype2ReferenceParameters.parameter2
                                        : referencetype2Offers[index].referencetype2ReferenceParameters.parameter2)),
                                Text("Minimum volume: " +
                                    (referencetype2Auctions != null
                                            ? referencetype2Auctions[index].referencetype2ReferenceParameters.minVolume
                                            : referencetype2Offers[index].referencetype2ReferenceParameters.minVolume)
                                        .toString() +
                                    "kg"),
                                Text("Maximum volume: " +
                                    (referencetype2Auctions != null
                                            ? referencetype2Auctions[index].referencetype2ReferenceParameters.maxVolume
                                            : referencetype2Offers[index].referencetype2ReferenceParameters.maxVolume)
                                        .toString() +
                                    "kg"),
                              ],
                      ),
                      Spacer(),
                      Container(
                        child: (materialAuctions != null
                            ? (materialAuctions[index].ownerId == userHandler.user.userId
                                ? null
                                : ElevatedButton(
                                    child: participant || materialAuctions[index].stopDate.isBefore(new DateTime.now())
                                        ? Text("Visit room")
                                        : (requestSent ? Text("Request sent") : Text("Send request")),
                                    onPressed: participant || materialAuctions[index].stopDate.isBefore(new DateTime.now())
                                        ? () {
                                            auctionHandler.setCurrentAuction(materialAuctions[index].id);
                                            navigate(WidgetMarker.room);
                                          }
                                        : (requestSent
                                            ? null
                                            : () {
                                                userHandler.requestToJoin(materialAuctions[index].id, materialAuctions[index].ownerId);
                                              }),
                                  ))
                            : (referencetype2Auctions != null
                                ? (referencetype2Auctions[index].ownerId == userHandler.user.userId
                                    ? null
                                    : ElevatedButton(
                                        child: participant || referencetype2Auctions[index].stopDate.isBefore(new DateTime.now())
                                            ? Text("Visit room")
                                            : (requestSent ? Text("Request sent") : Text("Send request")),
                                        onPressed: participant || referencetype2Auctions[index].stopDate.isBefore(new DateTime.now())
                                            ? () {
                                                auctionHandler.setCurrentAuction(referencetype2Auctions[index].id);
                                                navigate(WidgetMarker.room);
                                              }
                                            : (requestSent
                                                ? null
                                                : () {
                                                    userHandler.requestToJoin(referencetype2Auctions[index].id, referencetype2Auctions[index].ownerId);
                                                  }),
                                      ))
                                : (materialOffers != null
                                    ? (materialOffers[index].userId == userHandler.user.userId
                                        ? ElevatedButton(
                                            onPressed: () {
                                              offerHandler.viewOffer(materialOffers[index].templateId, materialOffers[index].keyValuePairs, context);
                                            },
                                            child: Text("View Offer"),
                                          )
                                        : Column(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  offerHandler.viewOffer(materialOffers[index].templateId, materialOffers[index].keyValuePairs, context);
                                                },
                                                child: Text("View Offer"),
                                              ),
                                              Row(
                                                children: inviteSent
                                                    ? [
                                                        Text("Invite sent"),
                                                      ]
                                                    : [
                                                        Row(
                                                          children: [
                                                            Text("Invite to auction: "),
                                                            DropdownButton(
                                                              icon: Icon(Icons.arrow_downward),
                                                              iconSize: 24,
                                                              value: "Auction title",
                                                              elevation: 16,
                                                              style: TextStyle(color: Colors.white),
                                                              onChanged: (String auctionTitle) {
                                                                if (auctionTitle != "Auction title") {
                                                                  for (int i = 0; i < auctionHandler.myAuctions.materialAuctions.materialAuctions.length; i++) {
                                                                    if (auctionTitle == auctionHandler.myAuctions.materialAuctions.materialAuctions[i].title) {
                                                                      userHandler.inviteToAuction(
                                                                          auctionHandler.myAuctions.materialAuctions.materialAuctions[i].id,
                                                                          materialOffers[index].id,
                                                                          materialOffers[index].userId);
                                                                      return;
                                                                    }
                                                                  }
                                                                }
                                                              },
                                                              items: auctionHandler
                                                                  .getAuctionTitles("material", materialOffers[index].userId)
                                                                  .map<DropdownMenuItem<String>>((String value) {
                                                                return DropdownMenuItem<String>(
                                                                  value: value,
                                                                  child: Text(value),
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                              ),
                                            ],
                                          ))
                                    : (referencetype2Offers != null
                                        ? (referencetype2Offers[index].userId == userHandler.user.userId
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  offerHandler.viewOffer(
                                                      referencetype2Offers[index].templateId, referencetype2Offers[index].keyValuePairs, context);
                                                },
                                                child: Text("View Offer"),
                                              )
                                            : Column(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      offerHandler.viewOffer(
                                                          referencetype2Offers[index].templateId, referencetype2Offers[index].keyValuePairs, context);
                                                    },
                                                    child: Text("View Offer"),
                                                  ),
                                                  Row(
                                                    children: inviteSent
                                                        ? [
                                                            Text("Invite sent"),
                                                          ]
                                                        : [
                                                            Row(
                                                              children: [
                                                                Text("Invite to auction: "),
                                                                DropdownButton(
                                                                  icon: Icon(Icons.arrow_downward),
                                                                  iconSize: 24,
                                                                  value: "Auction title",
                                                                  elevation: 16,
                                                                  style: TextStyle(color: Colors.white),
                                                                  onChanged: (String auctionTitle) {
                                                                    if (auctionTitle != "Auction title") {
                                                                      for (int i = 0;
                                                                          i < auctionHandler.myAuctions.referencetype2Auctions.referencetype2Auctions.length;
                                                                          i++) {
                                                                        if (auctionTitle ==
                                                                            auctionHandler.myAuctions.referencetype2Auctions.referencetype2Auctions[i].title) {
                                                                          userHandler.inviteToAuction(
                                                                              auctionHandler.myAuctions.referencetype2Auctions.referencetype2Auctions[i].id,
                                                                              referencetype2Offers[index].id,
                                                                              referencetype2Offers[index].userId);
                                                                          return;
                                                                        }
                                                                      }
                                                                    }
                                                                  },
                                                                  items: auctionHandler
                                                                      .getAuctionTitles("referencetype2", referencetype2Offers[index].userId)
                                                                      .map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                  ),
                                                ],
                                              ))
                                        : null)))),
                      )
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
}
