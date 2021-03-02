import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_project/Handlers/auctionHandler.dart';

import '../mainGUI.dart';

class Room extends StatefulWidget {
  final Function navigate;
  final AuctionHandler auctionHandler;

  Room(this.navigate, this.auctionHandler);

  @override
  _RoomState createState() => _RoomState(navigate, auctionHandler);
}

class _RoomState extends State<Room> {
  final Function navigate;
  final AuctionHandler auctionHandler;
  List<TextEditingController> controllers = [];

  _RoomState(this.navigate, this.auctionHandler) {
    for (int i = 0;
        i <
            auctionHandler
                .currentAuction.contractTemplate.templateVariables.length;
        i++) {
      this.controllers.add(TextEditingController());
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

  void showContractGUI() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final ThemeData themeData = Theme.of(context);

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
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
                    color: Colors.grey[
                        900], //Couldn't import from theme as "Dialog" is transparent
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
                          itemCount: auctionHandler.currentAuction
                              .contractTemplate.templateVariables.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              if (auctionHandler.currentAuction.contractTemplate
                                      .templateVariables[0].valueType ==
                                  "Text") {
                                return Column(
                                  children: [
                                    Text(
                                      auctionHandler
                                          .currentAuction
                                          .contractTemplate
                                          .templateStrings[0]
                                          .text,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          child: TextField(
                                            controller: controllers[0],
                                            decoration: InputDecoration(
                                              hintText: auctionHandler
                                                  .currentAuction
                                                  .contractTemplate
                                                  .templateVariables[0]
                                                  .key,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      auctionHandler
                                          .currentAuction
                                          .contractTemplate
                                          .templateStrings[1]
                                          .text,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              } else if (auctionHandler
                                      .currentAuction
                                      .contractTemplate
                                      .templateVariables[0]
                                      .valueType ==
                                  "Integer") {
                                return Column(
                                  children: [
                                    Text(
                                      auctionHandler
                                          .currentAuction
                                          .contractTemplate
                                          .templateStrings[0]
                                          .text,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          child: TextField(
                                            controller: controllers[0],
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                              hintText: auctionHandler
                                                  .currentAuction
                                                  .contractTemplate
                                                  .templateVariables[0]
                                                  .key,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      auctionHandler
                                          .currentAuction
                                          .contractTemplate
                                          .templateStrings[1]
                                          .text,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              }
                            } else {
                              if (auctionHandler.currentAuction.contractTemplate
                                      .templateVariables[index].valueType ==
                                  "Text") {
                                return Column(
                                  children: [
                                    SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          child: TextField(
                                            controller: controllers[index],
                                            decoration: InputDecoration(
                                              hintText: auctionHandler
                                                  .currentAuction
                                                  .contractTemplate
                                                  .templateVariables[index]
                                                  .key,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      auctionHandler
                                          .currentAuction
                                          .contractTemplate
                                          .templateStrings[index + 1]
                                          .text,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              } else if (auctionHandler
                                      .currentAuction
                                      .contractTemplate
                                      .templateVariables[index]
                                      .valueType ==
                                  "Integer") {
                                return Column(
                                  children: [
                                    SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          child: TextField(
                                            controller: controllers[index],
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                              hintText: auctionHandler
                                                  .currentAuction
                                                  .contractTemplate
                                                  .templateVariables[index]
                                                  .key,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      auctionHandler
                                          .currentAuction
                                          .contractTemplate
                                          .templateStrings[index + 1]
                                          .text,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              }
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
                  child: Text((() {
                    if (auctionHandler.userHandler.user.currentType.toLowerCase().contains("consumer")) {
                      return "Requested: ${auctionHandler.currentAuction.material}";
                    } else {
                      return "Provided: ${auctionHandler.currentAuction.material}";
                    }
                  })(), style: bigText),
                  height: 40.0,
                  margin: EdgeInsets.all(5.0),
                ),
                Spacer(),
                Container(
                    height: 40.0,
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.all(5.0),
                    child: Tooltip(
                      message: "Copy to clipboard",
                      child: TextButton(
                          child: Text(
                            'ROOM CODE: ${auctionHandler.currentAuction.id}',
                            textAlign: TextAlign.end,
                            style: bigText,
                          ),
                          onPressed: () {
                            Clipboard.setData(new ClipboardData(
                                    text:
                                        "${auctionHandler.currentAuction.id}"))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.grey[900],
                                      content: Text(
                                          "Room code copied to clipboard",
                                          style:
                                              TextStyle(color: Colors.white))));
                            });
                          }),
                    )),
              ]),
              Container(
                child: Text(
                  'Company: ${auctionHandler.userHandler.user.company}',
                  style: bigText,
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
                              children: [
                                Text(
                                  'Specific Auction info',
                                  textAlign: TextAlign.start,
                                  style: smallText,
                                ),
                                Text(
                                  'Company: {Name}',
                                  textAlign: TextAlign.start,
                                  style: smallText,
                                ),
                                Text(
                                  'Quantity: {Quantity}',
                                  textAlign: TextAlign.start,
                                  style: smallText,
                                ),
                                Text(
                                  'Material: {Material}',
                                  textAlign: TextAlign.start,
                                  style: smallText,
                                ),
                                Text(
                                  'Specific Auction info',
                                  textAlign: TextAlign.start,
                                  style: smallText,
                                ),
                              ]))),
                  //Spacer(),
                  Expanded(
                    child: Container(
                      color: Colors.white70,
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Text(
                        'Time remaining, current bid, graph of bid history?',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )),
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
                              title: Row(children: [
                                Text(
                                  'Bids',
                                  textAlign: TextAlign.start,
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  tooltip: 'New bid',
                                  onPressed: () {
                                    showContractGUI();
                                  },
                                ),
                              ]),
                            ),
                            SliverFixedExtentList(
                              itemExtent: 25.0,
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    alignment: Alignment.centerLeft,
                                    color:
                                        Colors.grey[850 + (50 * (index % 2))],
                                    child: Text(
                                        '[14:20] COMPANYNAME placed bid for $index SEK',
                                        style:
                                            TextStyle(fontFamily: 'Consolas')),
                                  );
                                },
                                childCount: 50,
                              ),
                            ),
                          ],
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
