import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:new_project/Entities/auctionDetailsListJSON.dart';
import 'package:new_project/Handlers/auctionHandler.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:new_project/Handlers/userInfoHandler.dart';
import '../Entities/templateListJSON.dart';
import '../Entities/materialAuctionListJSON.dart';
import '../Entities/referencetype2AuctionListJSON.dart';
import '../Entities/userListJSON.dart';

import '../mainGUI.dart';

class Room extends StatefulWidget {
  final Function navigate;
  final AuctionHandler auctionHandler;
  final UserInfoHandler _userHandler;
  Room(this.navigate, this.auctionHandler, this._userHandler);

  @override
  _RoomState createState() => _RoomState(navigate, auctionHandler, _userHandler);
}

class _RoomState extends State<Room> {
  final Function navigate;
  final AuctionHandler auctionHandler;
  final UserInfoHandler userHandler;
  CountdownTimerController controller;
  List<Inbox> out;
  Template contractTemplate;
  List<TextEditingController> controllers;
  MaterialAuction materialAuction;
  Referencetype2Auction referencetype2Auction;
  bool isFinished;
  bool isHost;

  _RoomState(this.navigate, this.auctionHandler, this.userHandler) {
    this.contractTemplate = auctionHandler.getContractTemplate(auctionHandler.currentAuctionDetails.templateId);

    controllers = [];
    for (int i = 0; i < contractTemplate.templateVariables.length; i++) {
      controllers.add(new TextEditingController());
    }

    for (int i = 0; i < auctionHandler.myAuctions.materialAuctions.materialAuctions.length; i++) {
      if (auctionHandler.myAuctions.materialAuctions.materialAuctions[i].id == auctionHandler.currentAuctionDetails.id) {
        materialAuction = auctionHandler.myAuctions.materialAuctions.materialAuctions[i];
      }
    }
    for (int i = 0; i < auctionHandler.myAuctions.referencetype2Auctions.referencetype2Auctions.length; i++) {
      if (auctionHandler.myAuctions.referencetype2Auctions.referencetype2Auctions[i].id == auctionHandler.currentAuctionDetails.id) {
        referencetype2Auction = auctionHandler.myAuctions.referencetype2Auctions.referencetype2Auctions[i];
      }
    }

    if (materialAuction != null) {
      if (new DateTime.now().isBefore(materialAuction.stopDate)) {
        isFinished = false;
      } else {
        isFinished = true;
      }
      if (materialAuction.ownerId == userHandler.user.userId) {
        isHost = true;
      } else {
        isHost = false;
      }
    }
    if (referencetype2Auction != null) {
      if (new DateTime.now().isBefore(referencetype2Auction.stopDate)) {
        isFinished = false;
      } else {
        isFinished = true;
      }
      if (referencetype2Auction.ownerId == userHandler.user.userId) {
        isHost = true;
      } else {
        isHost = false;
      }
    }
  }

  final TextStyle smallText = TextStyle(
    fontSize: 24.0,
  );
  final TextStyle bigText = TextStyle(
    fontSize: 30.0,
  );
  final TextStyle boldText = TextStyle(
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 1400.0,
          height: MediaQuery.of(context).size.height * 0.9,
          color: themeData.primaryColor,
          margin: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  tooltip: 'Back',
                  onPressed: () {
                    navigate(WidgetMarker.auctions);
                  },
                ),
                Container(
                  child: Text(
                    materialAuction != null ? materialAuction.title : (referencetype2Auction != null ? referencetype2Auction.title : null),
                    style: bigText,
                  ),
                  height: 40.0,
                  margin: EdgeInsets.all(5.0),
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                        height: 40.0,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.all(5.0),
                        child: Tooltip(
                          message: "Copy to clipboard",
                          child: TextButton(
                              child: Text(
                                'ROOM CODE: ${auctionHandler.currentAuctionDetails.id}',
                                textAlign: TextAlign.end,
                                style: bigText,
                              ),
                              onPressed: () {
                                Clipboard.setData(new ClipboardData(text: "${auctionHandler.currentAuctionDetails.id}")).then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      backgroundColor: Colors.grey[900],
                                      content: Text("Room code copied to clipboard", style: TextStyle(color: Colors.white))));
                                });
                              }),
                        )),
                    Container(
                      alignment: Alignment.centerRight,
                      child: isHost
                          ? TextButton(
                              child: Text(
                                "End auction",
                                textScaleFactor: 2,
                              ),
                              onPressed: () {
                                auctionHandler.endAuction();
                              },
                            )
                          : null,
                    ),
                  ],
                ),
              ]),
              Container(
                child: Row(
                  children: [
                    Text(
                      'Participants: ' +
                          (materialAuction != null
                              ? materialAuction.currentParticipants.toString() + "/" + materialAuction.maxParticipants.toString()
                              : (referencetype2Auction != null
                                  ? referencetype2Auction.currentParticipants.toString() + "/" + referencetype2Auction.maxParticipants.toString()
                                  : "")),
                      style: bigText,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    CountdownTimer(
                      endTime: materialAuction != null
                          ? materialAuction.stopDate.millisecondsSinceEpoch
                          : (referencetype2Auction != null ? referencetype2Auction.stopDate.millisecondsSinceEpoch : null),
                      widgetBuilder: (_, CurrentRemainingTime time) {
                        if (time == null) {
                          return Text('Auction finished', style: bigText);
                        }
                        return Text(
                          'Time left: ${time.days} days, ${time.hours} hours, ${time.min} minutes, ${time.sec} seconds.',
                          style: bigText,
                        );
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      child: auctionHandler.currentAuctionDetails.winningBid != 0
                          ? Row(
                              children: [
                                Text(
                                  () {
                                    for (int i = 0; i < auctionHandler.currentAuctionDetails.bids.length; i++) {
                                      if (auctionHandler.currentAuctionDetails.bids[i].id == auctionHandler.currentAuctionDetails.winningBid) {
                                        for (int y = 0; y < userHandler.userListObject.users.length; y++) {
                                          if (userHandler.userListObject.users[y].userId == auctionHandler.currentAuctionDetails.bids[i].userId) {
                                            return "Winning bid made by " + userHandler.userListObject.users[y].userName;
                                          }
                                        }
                                      }
                                    }
                                  }(),
                                  style: bigText,
                                ),
                                TextButton(
                                  child: Text("View"),
                                  onPressed: () {
                                    for (int i = 0; i < auctionHandler.currentAuctionDetails.bids.length; i++) {
                                      if (auctionHandler.currentAuctionDetails.bids[i].id == auctionHandler.currentAuctionDetails.winningBid) {
                                        auctionHandler.viewBid(contractTemplate, auctionHandler.currentAuctionDetails.bids[i].keyValuePairs, context);
                                      }
                                    }
                                  },
                                )
                              ],
                            )
                          : null,
                    ),
                  ],
                ),
                width: 1400.0,
                height: MediaQuery.of(context).size.height * 0.05,
                //color: Colors.black,
                padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  boxShadow: [BoxShadow(blurRadius: 3, offset: Offset(0, 4))],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                      //color: Colors.amber[700],
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: materialAuction != null
                            ? [
                                Text("Reference parameters", style: bigText),
                                Text("Fibers type: " + materialAuction.materialReferenceParameters.fibersType),
                                Text("Resin type: " + materialAuction.materialReferenceParameters.resinType),
                                Text("Minimum fiber length: " + materialAuction.materialReferenceParameters.minFiberLength.toString()),
                                Text("Maximum fiber length: " + materialAuction.materialReferenceParameters.maxFiberLength.toString()),
                                Text("Recycling technology: " + materialAuction.materialReferenceParameters.recyclingTechnology),
                                Text("Sizing: " + materialAuction.materialReferenceParameters.sizing),
                                Text("Additives: " + materialAuction.materialReferenceParameters.additives),
                                Text("Minimum volume: " + materialAuction.materialReferenceParameters.minVolume.toString()),
                                Text("Maximum volume: " + materialAuction.materialReferenceParameters.maxVolume.toString()),
                              ]
                            : (referencetype2Auction != null
                                ? [
                                    Text("Reference parameters", style: bigText),
                                    Text("Parameter 1: " + referencetype2Auction.referencetype2ReferenceParameters.parameter1),
                                    Text("Parameter 2: " + referencetype2Auction.referencetype2ReferenceParameters.parameter2),
                                    Text("Minimum volume: " + referencetype2Auction.referencetype2ReferenceParameters.minVolume.toString()),
                                    Text("Maximum volume: " + referencetype2Auction.referencetype2ReferenceParameters.maxVolume.toString()),
                                  ]
                                : [
                                    Text("Reference parameters", style: bigText),
                                  ]),
                      ),
                    )),
                    //Spacer(),

                    Expanded(
                      child: Column(
                        children: [
                          checkForNotifications()
                              ? Expanded(
                                  child: ElevatedButton(
                                    child: Text("Show notifications for this auction"),
                                    onPressed: () {
                                      auctionHandler.showNotifications(
                                          context,
                                          out,
                                          (materialAuction != null
                                              ? materialAuction.title
                                              : (referencetype2Auction != null ? referencetype2Auction.title : null)));
                                    },
                                  ),
                                )
                              : SizedBox(height: 0.01),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey[900],
                  margin: EdgeInsets.all(5.0),

                  //height: 300,
                  child: Scrollbar(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          floating: true,
                          pinned: true,
                          snap: true,
                          expandedHeight: 50.0,
                          title: Row(
                            children: [
                              Text(
                                'Bids',
                                textAlign: TextAlign.start,
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.add),
                                tooltip: isFinished ? "Auction has ended" : 'New bid',
                                onPressed: isFinished
                                    ? null
                                    : () {
                                        showContractGUI();
                                      },
                              ),
                            ],
                          ),
                        ),
                        SliverFixedExtentList(
                          itemExtent: 25.0,
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              List<KeyValuePair> currentBid = auctionHandler.currentAuctionDetails.bids[index].keyValuePairs;
                              User user;
                              for (int i = 0; i < userHandler.userListObject.users.length; i++) {
                                if (userHandler.userListObject.users[i].userId == auctionHandler.currentAuctionDetails.bids[index].userId) {
                                  user = userHandler.userListObject.users[i];
                                }
                              }
                              String timeString = auctionHandler.currentAuctionDetails.bids[index].time.toLocal().toString();
                              int amountOfMoney;
                              for (int i = 0; i < currentBid.length; i++) {
                                if (currentBid[i].key == "Amount of money") {
                                  amountOfMoney = currentBid[i].value;
                                }
                              }
                              return Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                alignment: Alignment.centerRight,
                                color: Colors.grey[850 + (50 * (index % 2))],
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          //Sample string, could be reworked
                                          '[$timeString] ${user.userName} placed bid for ${amountOfMoney.toString()} SEK',
                                          style: TextStyle(fontFamily: 'Consolas')),
                                    ),
                                    Spacer(),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        children: isHost && !isFinished
                                            ? [
                                                TextButton(
                                                  child: Text("Declare winner"),
                                                  onPressed: () {
                                                    setState(() {
                                                      auctionHandler.selectAuctionWinner(auctionHandler.currentAuctionDetails.bids[index].id);
                                                    });
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("View"),
                                                  onPressed: () {
                                                    auctionHandler.viewBid(contractTemplate, currentBid, context);
                                                  },
                                                ),
                                              ]
                                            : [
                                                TextButton(
                                                  child: Text("View"),
                                                  onPressed: () {
                                                    auctionHandler.viewBid(contractTemplate, currentBid, context);
                                                  },
                                                ),
                                              ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            childCount: auctionHandler.currentAuctionDetails.bids.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkForNotifications() {
    List<Inbox> req = new List.from(userHandler.user.requestInbox);
    out = [];
    for (int i = 0; i < auctionHandler.myAuctions.materialAuctions.materialAuctions.length; i++) {
      for (int y = 0; y < req.length; y++) {
        if (req[y].auctionId == auctionHandler.myAuctions.materialAuctions.materialAuctions[i].id) {
          out.add(req[y]);
        }
      }
    }
    for (int i = 0; i < auctionHandler.myAuctions.referencetype2Auctions.referencetype2Auctions.length; i++) {
      for (int y = 0; y < req.length; y++) {
        if (req[y].auctionId == auctionHandler.myAuctions.referencetype2Auctions.referencetype2Auctions[i].id) {
          out.add(req[y]);
        }
      }
    }
    if (out.isNotEmpty) {
      return true;
    }
    return false;
  }

  void showContractGUI() {
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
                    children: <Widget>[
                      Text(
                        "Contract",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 2,
                      ),
                      SizedBox(height: 20.0),
                      Expanded(
                        child: ListView.builder(
                          itemCount: contractTemplate.templateVariables.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Column(
                                children: [
                                  Text(
                                    contractTemplate.templateStrings[0].text,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        child: contractTemplate.templateVariables[0].valueType == "Text"
                                            ? TextField(
                                                controller: controllers[0],
                                                decoration: InputDecoration(
                                                  hintText: contractTemplate.templateVariables[0].key,
                                                ),
                                              )
                                            : (contractTemplate.templateVariables[0].valueType == "Integer"
                                                ? TextField(
                                                    controller: controllers[0],
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                    decoration: InputDecoration(
                                                      hintText: contractTemplate.templateVariables[0].key,
                                                    ),
                                                  )
                                                : null),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    contractTemplate.templateStrings[1].text,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        child: contractTemplate.templateVariables[index].valueType == "Text"
                                            ? TextField(
                                                controller: controllers[index],
                                                decoration: InputDecoration(
                                                  hintText: contractTemplate.templateVariables[index].key,
                                                ),
                                              )
                                            : (contractTemplate.templateVariables[index].valueType == "Integer"
                                                ? TextField(
                                                    controller: controllers[index],
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                    decoration: InputDecoration(
                                                      hintText: contractTemplate.templateVariables[index].key,
                                                    ),
                                                  )
                                                : null),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    contractTemplate.templateStrings[index + 1].text,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          child: Text("Make bid"),
                          onPressed: () {
                            setState(() {
                              List<KeyValuePair> keyValuePairs = [];
                              for (int i = 0; i < contractTemplate.templateVariables.length; i++) {
                                if (contractTemplate.templateVariables[i].valueType == "Text") {
                                  keyValuePairs.add(KeyValuePair(key: contractTemplate.templateVariables[i].key, value: controllers[i].text));
                                }
                                if (contractTemplate.templateVariables[i].valueType == "Integer") {
                                  keyValuePairs.add(KeyValuePair(key: contractTemplate.templateVariables[i].key, value: int.parse(controllers[i].text)));
                                }
                              }
                              auctionHandler.makeBid(keyValuePairs);
                              Navigator.pop(context);
                            });
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
}
