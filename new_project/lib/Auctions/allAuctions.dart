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
  String referencetype;

  _AllAuctionsState(this.navigate, this.filterHandler, this.auctionHandler, this.offerHandler, this.userHandler);

  @override
  void initState() {
    super.initState();
    _currentPage = PageMarker.ongoing;
    referencetype = "Material";
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
        return _getAuctions("Ongoing");
      case PageMarker.finished:
        return _getAuctions("Finished");
      case PageMarker.offers:
        return _getOffers();
    }
    return _getAuctions("Ongoing");
  }

  SliverFixedExtentList _getAuctions(String type) {
    var now = new DateTime.now();

    if (referencetype == "Material") {
      List<MaterialAuction> materialAuctions;
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
      _generateBoxes(materialAuctions: materialAuctions);
    }

    if (referencetype == "Referencetype2") {
      List<Referencetype2Auction> referencetype2Auctions;
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
      _generateBoxes(referencetype2Auctions: referencetype2Auctions);
    }
  }

  SliverFixedExtentList _getOffers() {
    if (referencetype == "Material") {
      List<MaterialOffer> materialOffers;
      if (filterHandler.materialFilter == null) {
        materialOffers = offerHandler.allOffers.materialOffers.materialOffers;
      } else {
        for (int i = 0; i < offerHandler.allOffers.materialOffers.materialOffers.length; i++) {
          if (filterHandler.checkFilter(materialFilter: offerHandler.allOffers.materialOffers.materialOffers[i].materialReferenceParameters)) {
            materialOffers.add(offerHandler.allOffers.materialOffers.materialOffers[i]);
          }
        }
      }
      _generateBoxes(materialOffers: materialOffers);
    }

    if (referencetype == "Referencetype2") {
      List<Referencetype2Offer> referencetype2Offers;
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
      _generateBoxes(referencetype2Offers: referencetype2Offers);
    }
  }

  //Generates the auctionboxes themselves
  SliverFixedExtentList _generateBoxes(
      {List<MaterialAuction> materialAuctions,
      List<Referencetype2Auction> referencetype2Auctions,
      List<MaterialOffer> materialOffers,
      List<Referencetype2Offer> referencetype2Offers}) {
    var now = new DateTime.now();
    if (materialAuctions != null) {
      return SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            bool participant = false;
            for (int i = 0; i < userHandler.user.participatingAuctions.length; i++) {
              if (userHandler.user.participatingAuctions[i].auctionId == materialAuctions[index].id) {
                participant = true;
                break;
              }
            }
            bool requestSent = false;
            for (int i = 0; i < userHandler.user.requestInbox.length; i++) {
              if (userHandler.user.requestInbox[i].auctionId == materialAuctions[index].id && userHandler.user.requestInbox[i].status == "Sent") {
                requestSent = true;
                break;
              }
            }
            return Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.only(left: 10, right: 10),
              color: now.isAfter(materialAuctions[index].stopDate) ? Colors.redAccent : Colors.greenAccent[700],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Title: ' + materialAuctions[index].title),
                      // Print out material auction info.
                      Text('Participants: ' + materialAuctions[index].currentParticipants.toString()),
                    ],
                  ),
                  Spacer(),
                  Container(
                    child: ElevatedButton(
                      child: participant ? Text("Visit room") : (requestSent ? Text("Request sent") : Text("Send request")),
                      onPressed: participant
                          ? () {
                              auctionHandler.setCurrentAuction(materialAuctions[index].id);
                              navigate(WidgetMarker.room);
                            }
                          : (requestSent
                              ? null
                              : () {
                                  userHandler.requestToJoin();
                                }),
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: materialAuctions.length,
        ),
      );
    }
    if (referencetype2Auctions != null) {
      return SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            bool participant = false;
            for (int i = 0; i < userHandler.user.participatingAuctions.length; i++) {
              if (userHandler.user.participatingAuctions[i].auctionId == referencetype2Auctions[index].id) {
                participant = true;
                break;
              }
            }
            bool requestSent = false;
            for (int i = 0; i < userHandler.user.requestInbox.length; i++) {
              if (userHandler.user.requestInbox[i].auctionId == referencetype2Auctions[index].id && userHandler.user.requestInbox[i].status == "Sent") {
                requestSent = true;
                break;
              }
            }
            return Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.only(left: 10, right: 10),
              color: now.isAfter(referencetype2Auctions[index].stopDate) ? Colors.redAccent : Colors.greenAccent[700],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Title: ' + referencetype2Auctions[index].title),
                      // Print out referencetype2 auction info.
                      Text('Participants: ' + referencetype2Auctions[index].currentParticipants.toString()),
                    ],
                  ),
                  Spacer(),
                  Container(
                    child: ElevatedButton(
                      child: participant ? Text("Visit room") : (requestSent ? Text("Request sent") : Text("Send request")),
                      onPressed: participant
                          ? () {
                              auctionHandler.setCurrentAuction(referencetype2Auctions[index].id);
                              navigate(WidgetMarker.room);
                            }
                          : (requestSent
                              ? null
                              : () {
                                  userHandler.requestToJoin();
                                }),
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: referencetype2Auctions.length,
        ),
      );
    }
    if (materialOffers != null) {
      return SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            bool yourOffer = false;
            for (int i = 0; i < userHandler.user.offers.length; i++) {
              if (userHandler.user.offers[i].offerId == materialOffers[index].id) {
                yourOffer = true;
                break;
              }
            }
            bool inviteSent = false;
            if (yourOffer == false) {
              for (int i = 0; i < userHandler.user.inviteInbox.length; i++) {
                if (userHandler.user.inviteInbox[i].offerId == materialOffers[index].id && userHandler.user.requestInbox[i].status == "Sent") {
                  inviteSent = true;
                  break;
                }
              }
            }
            return Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.only(left: 10, right: 10),
              color: Colors.greenAccent[700],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Title: ' + materialOffers[index].title),
                    ],
                  ),
                  Spacer(),
                  Container(
                    child: yourOffer
                        ? Text("")
                        : ElevatedButton(
                            child: inviteSent ? Text('Invite sent') : Text("Send invite"),
                            onPressed: inviteSent
                                ? null
                                : () {
                                    userHandler.inviteToAuction();
                                  },
                          ),
                  ),
                ],
              ),
            );
          },
          childCount: materialOffers.length,
        ),
      );
    }
    if (referencetype2Offers != null) {
      return SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            if (materialAuctions != null || referencetype2Auctions != null) {
              bool participant = false;
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
              bool requestSent = false;
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
              bool yourOffer = false;
              for (int i = 0; i < userHandler.user.offers.length; i++) {
                if (materialOffers != null) {
                  if (userHandler.user.offers[i].offerId == materialOffers[index].id) {
                    yourOffer = true;
                    break;
                  }
                }
                if (referencetype2Offers != null) {
                  if (userHandler.user.offers[i].offerId == referencetype2Offers[index].id) {
                    yourOffer = true;
                    break;
                  }
                }
              }
              bool inviteSent = false;
              if (yourOffer == false) {
                for (int i = 0; i < userHandler.user.inviteInbox.length; i++) {
                  if (materialOffers != null) {
                    if (userHandler.user.inviteInbox[i].offerId == materialOffers[index].id && userHandler.user.requestInbox[i].status == "Sent") {
                      inviteSent = true;
                      break;
                    }
                  }
                  if (referencetype2Offers != null) {
                    if (userHandler.user.inviteInbox[i].offerId == referencetype2Offers[index].id && userHandler.user.requestInbox[i].status == "Sent") {
                      inviteSent = true;
                      break;
                    }
                  }
                }
              }
            }
            return Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.only(left: 10, right: 10),
              color: Colors.greenAccent[700],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                          ? " Participants: " + materialAuctions[index].currentParticipants.toString()
                          : (referencetype2Auctions != null ? " Participants: " + referencetype2Auctions[index].currentParticipants.toString() : "")),
                    ],
                  ),
                  Spacer(),
                  Container(
                    child: yourOffer
                        ? Text("")
                        : ElevatedButton(
                            child: inviteSent ? Text('Invite sent') : Text("Send invite"),
                            onPressed: inviteSent
                                ? null
                                : () {
                                    userHandler.inviteToAuction();
                                  },
                          ),
                  ),
                ],
              ),
            );
          },
          childCount: materialAuctions != null
              ? materialAuctions.length
              : (materialOffers != null
                  ? materialOffers.length
                  : (referencetype2Auctions != null ? referencetype2Auctions.length : referencetype2Offers.length)),
        ),
      );
    }
  }
}
