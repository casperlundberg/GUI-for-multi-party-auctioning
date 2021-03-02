import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Handlers/auctionHandler.dart';
import '../Handlers/filterHandler.dart';
import '../mainGUI.dart';
import '../Entities/auctionListJSON.dart';
import '../Entities/contractTemplatesJSON.dart';
import '../Handlers/userInfoHandler.dart';

enum PageMarker { ongoing, finished }

class Auctions extends StatefulWidget {
  final Function setMainState;
  final Function navigate;
  final FilterHandler filterHandler;
  final AuctionHandler auctionHandler;
  final UserInfoHandler userHandler;

  Auctions(this.setMainState, this.navigate, this.filterHandler,
      this.auctionHandler, this.userHandler);

  @override
  _AuctionsState createState() => _AuctionsState(
      setMainState, navigate, filterHandler, auctionHandler, userHandler);
}

class _AuctionsState extends State<Auctions>
    with SingleTickerProviderStateMixin<Auctions> {
  final Function setMainState;
  final Function navigate;
  final FilterHandler filterHandler;
  final AuctionHandler auctionHandler;
  final UserInfoHandler userHandler;
  PageMarker _currentPage;
  ContractTemplates contractTemplates;
  ContractTemplate contractTemplate;
  TextEditingController auctionTitle = TextEditingController();
  TextEditingController maxParticipants = TextEditingController();
  TextEditingController roundTime = TextEditingController();
  TextEditingController rounds = TextEditingController();
  List<String> materialTypes = [
    "Wood",
    "Metals",
    "Soil",
    "Stone",
    "Gold",
    "Silver"
  ];
  String materialDropdownValue = "Wood";
  List<String> contractIDs = [];
  String contractDropdownValue;

  _AuctionsState(this.setMainState, this.navigate, this.filterHandler,
      this.auctionHandler, this.userHandler) {
    if (userHandler.user.currentType == "Supplier") {
      contractTemplates = auctionHandler.supplierContractTemplates;
    }
    if (userHandler.user.currentType == "Consumer") {
      contractTemplates = auctionHandler.consumerContractTemplates;
    }
    contractDropdownValue =
        contractTemplates.contractTemplates[0].id.toString();
    contractTemplate = contractTemplates.contractTemplates[0];
    for (int i = 0; i < contractTemplates.contractTemplates.length; i++) {
      contractIDs.add(contractTemplates.contractTemplates[i].id.toString());
    }
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
      width: MediaQuery.of(context).size.width * 0.4,
      color: Colors.grey[900],
      margin: EdgeInsets.all(5.0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                tooltip: 'New auction',
                onPressed: () {
                  showContractTemplateGUI();
                },
              ),
              Expanded(
                  child: Container(
                height: double.infinity,
                color: (_currentPage == PageMarker.ongoing)
                    ? Colors.black
                    : themeData.primaryColor,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _currentPage = PageMarker.ongoing;
                    });
                  },
                  child: Text("Ongoing",
                      style: TextStyle(
                          fontSize: 20,
                          color: (_currentPage == PageMarker.ongoing)
                              ? Colors.white
                              : Colors.white60)),
                ),
              )),
              Expanded(
                  child: Container(
                height: double.infinity,
                color: (_currentPage == PageMarker.finished)
                    ? Colors.black
                    : themeData.primaryColor,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _currentPage = PageMarker.finished;
                    });
                  },
                  child: Text("Finished",
                      style: TextStyle(
                          fontSize: 20,
                          color: (_currentPage == PageMarker.finished)
                              ? Colors.white
                              : Colors.white60)),
                ),
              ))
            ],
          ),
          SliverToBoxAdapter(
              //--------------CASPER KOLLA HIT
              child: Container(
            width: double.infinity,
            height: 50,
            color: Colors.pink,
          )),
          FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot snaptshot) {
            return _getPageContainer();
          })
        ],
      ),
    );
  }

  SliverFixedExtentList _getPageContainer() {
    switch (_currentPage) {
      case PageMarker.ongoing:
        return _getOngoing();
      case PageMarker.finished:
        return _getFinished();
    }
    return _getOngoing();
  }

  SliverFixedExtentList _getOngoing() {
    List<Auction> output = [];
    var now = new DateTime.now();

    if (filterHandler.activeFilters.length == 0) {
      for (int i = 0; i < auctionHandler.allAuctions.auctionList.length; i++) {
        if (now.isBefore(auctionHandler.allAuctions.auctionList[i].stopDate)) {
          output.add(auctionHandler.allAuctions.auctionList[i]);
        }
      }
    } else {
      for (int i = 0; i < auctionHandler.allAuctions.auctionList.length; i++) {
        for (int y = 0; y < filterHandler.activeFilters.length; y++) {
          if (auctionHandler.allAuctions.auctionList[i].material ==
              filterHandler.activeFilters[y].name) {
            if (now
                .isBefore(auctionHandler.allAuctions.auctionList[i].stopDate)) {
              output.add(auctionHandler.allAuctions.auctionList[i]);
            }
          }
        }
      }
    }

    return _generateBoxes(output);
  }

  SliverFixedExtentList _getFinished() {
    List<Auction> output = [];
    var now = new DateTime.now();
    if (filterHandler.activeFilters.length == 0) {
      for (int i = 0; i < auctionHandler.allAuctions.auctionList.length; i++) {
        if (now.isAfter(auctionHandler.allAuctions.auctionList[i].stopDate)) {
          output.add(auctionHandler.allAuctions.auctionList[i]);
        }
      }
    } else {
      for (int i = 0; i < auctionHandler.allAuctions.auctionList.length; i++) {
        for (int y = 0; y < filterHandler.activeFilters.length; y++) {
          if (auctionHandler.allAuctions.auctionList[i].material ==
              filterHandler.activeFilters[y].name) {
            if (now
                .isAfter(auctionHandler.allAuctions.auctionList[i].stopDate)) {
              output.add(auctionHandler.allAuctions.auctionList[i]);
            }
          }
        }
      }
    }

    return _generateBoxes(output);
  }

  //Generates the auctionboxes themselves
  SliverFixedExtentList _generateBoxes(output) {
    return SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.only(left: 10, right: 10),
                color: Colors.lightGreen[600],
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Name: Room ' + output[index].id.toString()),
                        Text('Material: ' + output[index].material),
                        Text('Participants: ' +
                            output[index].currentParticipants.toString()),
                      ]),
                  Spacer(),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                        child: Text('Visit room'),
                        onPressed: () {
                          auctionHandler.setCurrentAuction(output[index].id);
                          navigate(WidgetMarker.room);
                        }),
                  ),
                ]));
          },
          childCount: output.length,
        ));
  }

  void showContractTemplateGUI() {
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
                                    "Create new auction",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 2,
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Auction Title: "),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: TextField(
                                          controller: auctionTitle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Max Participants: "),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: TextField(
                                          controller: maxParticipants,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 30.0),
                                      Text("Round Time (s): "),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: TextField(
                                          controller: roundTime,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 30.0),
                                      Text("Number of rounds: "),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: TextField(
                                          controller: rounds,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Material: "),
                                      DropdownButton(
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        value: materialDropdownValue,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.white),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            materialDropdownValue = newValue;
                                          });
                                        },
                                        items: materialTypes
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Contract Template ID: "),
                                      DropdownButton(
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        value: contractDropdownValue,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.white),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            contractDropdownValue = newValue;
                                            for (int i = 0;
                                                i <
                                                    contractTemplates
                                                        .contractTemplates
                                                        .length;
                                                i++) {
                                              if (contractTemplates
                                                      .contractTemplates[i].id
                                                      .toString() ==
                                                  newValue) {
                                                contractTemplate =
                                                    contractTemplates
                                                        .contractTemplates[i];
                                              }
                                            }
                                          });
                                        },
                                        items: contractIDs
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
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
                                    "Contract Template",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5,
                                  ),
                                  SizedBox(height: 20.0),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: contractTemplate
                                          .templateVariables.length,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return Column(
                                            children: [
                                              Text(
                                                contractTemplate
                                                    .templateStrings[0].text,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 20.0),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Key: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    contractTemplate
                                                        .templateVariables[0]
                                                        .key,
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                  Text(
                                                    " Value Type: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    contractTemplate
                                                        .templateVariables[0]
                                                        .valueType,
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20.0),
                                              Text(
                                                contractTemplate
                                                    .templateStrings[1].text,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          );
                                        }
                                        return Column(
                                          children: [
                                            SizedBox(height: 20.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Key: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  contractTemplate
                                                      .templateVariables[index]
                                                      .key,
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                                Text(
                                                  " Value Type: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  contractTemplate
                                                      .templateVariables[index]
                                                      .valueType,
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.0),
                                            Text(
                                              contractTemplate
                                                  .templateStrings[index + 1]
                                                  .text,
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
                          child: Text("Create auction"),
                          onPressed: () {
                            setState(() {
                              auctionHandler.createAuction(
                                  int.parse(contractDropdownValue),
                                  auctionTitle.text,
                                  int.parse(maxParticipants.text),
                                  int.parse(roundTime.text),
                                  int.parse(rounds.text),
                                  materialDropdownValue);

                              auctionTitle.clear();
                              maxParticipants.clear();
                              roundTime.clear();
                              rounds.clear();
                              materialDropdownValue = "Wood";
                              contractDropdownValue = contractTemplates
                                  .contractTemplates[0].id
                                  .toString();
                              contractTemplate =
                                  contractTemplates.contractTemplates[0];
                            });
                            setMainState();
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
                        auctionTitle.clear();
                        maxParticipants.clear();
                        roundTime.clear();
                        rounds.clear();
                        materialDropdownValue = "Wood";
                        contractDropdownValue = contractTemplates
                            .contractTemplates[0].id
                            .toString();
                        contractTemplate =
                            contractTemplates.contractTemplates[0];
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
}
