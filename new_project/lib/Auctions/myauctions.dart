import 'dart:html';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:new_project/Entities/auctionListJSON.dart';
import '../Handlers/auctionHandler.dart';
import '../mainGUI.dart';
import '../Entities/contractTemplatesJSON.dart';
import '../Handlers/userInfoHandler.dart';

class MyAuctions extends StatefulWidget {
  final Function setMainState;
  final Function navigate;
  final AuctionHandler auctionHandler;

  MyAuctions(this.setMainState, this.navigate, this.auctionHandler);

  @override
  _MyAuctionsState createState() => _MyAuctionsState(setMainState, navigate, auctionHandler);
}

class _MyAuctionsState extends State<MyAuctions> with SingleTickerProviderStateMixin<MyAuctions> {
  final Function setMainState;
  final Function navigate;
  final AuctionHandler auctionHandler;
  ContractTemplates contractTemplates;
  ContractTemplate contractTemplate;
  TextEditingController auctionTitle = TextEditingController();
  TextEditingController maxParticipants = TextEditingController();
  TextEditingController roundTime = TextEditingController();
  TextEditingController rounds = TextEditingController();
  List<String> materialTypes = ["Wood", "Metals", "Soil", "Stone", "Gold", "Silver"];
  String materialDropdownValue = "Wood";
  List<String> contractIDs = [];
  String contractDropdownValue;

  _MyAuctionsState(this.setMainState, this.navigate, this.auctionHandler) {
    if (auctionHandler.userHandler.user.currentType == "Supplier") {
      contractTemplates = auctionHandler.supplierContractTemplates;
    }
    if (auctionHandler.userHandler.user.currentType == "Consumer") {
      contractTemplates = auctionHandler.consumerContractTemplates;
    }
    contractDropdownValue = contractTemplates.contractTemplates[0].id.toString();
    contractTemplate = contractTemplates.contractTemplates[0];
    for (int i = 0; i < contractTemplates.contractTemplates.length; i++) {
      contractIDs.add(contractTemplates.contractTemplates[i].id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    Map myAuctions = splitAuctions(auctionHandler.myAuctions.auctionList, now);

    return new Container(
      color: Colors.grey[900],
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.2,
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
                tooltip: 'New auction',
                onPressed: () {
                  showContractTemplateGUI();
                },
              ),
            ]),
          ),
          //TODO: Collapseable categories?
          SliverToBoxAdapter(
              child: Container(
                  height: Size.fromHeight(kToolbarHeight).height * 0.5, margin: EdgeInsets.only(left: 15, right: 15, top: 15), child: Text("Ongoing"))),
          buildAuctionList(myAuctions["ongoing"], now),
          SliverToBoxAdapter(
              child: Container(
                  height: Size.fromHeight(kToolbarHeight).height * 0.5, margin: EdgeInsets.only(left: 15, right: 15, top: 15), child: Text("Finished"))),
          buildAuctionList(myAuctions["finished"], now),
        ],
      ),
    );
  }

  //Maps the a list of auctions into "finished" and "ongoing"
  //Pretty straightforward stuff
  Map splitAuctions(List<Auction> auctionList, DateTime now) {
    List<Auction> finished = [];
    List<Auction> ongoing = [];

    for (int i = 0; i < auctionList.length; i++) {
      now.isAfter(auctionList[i].stopDate) ? finished.add(auctionList[i]) : ongoing.add(auctionList[i]);
    }

    return {"finished": finished, "ongoing": ongoing};
  }

  //Builder function for the auction list
  SliverFixedExtentList buildAuctionList(List<Auction> auctionList, DateTime now) {
    return SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.only(left: 10, right: 10),
                color: now.isAfter(auctionList[index].stopDate) ? Colors.redAccent : Colors.greenAccent[700],
                child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('Name: Room ${auctionList[index].id}'),
                    Text('Material: ${auctionList[index].material}'),
                    Text('Participants: ${auctionList[index].currentParticipants}'),
                  ]),
                  Spacer(),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                        child: Text('Visit room'),
                        onPressed: () {
                          auctionHandler.setCurrentAuction(auctionList[index].id);
                          navigate(WidgetMarker.room);
                        }),
                  ),
                ]));
          },
          childCount: auctionList.length,
        ));
  }

  void showContractTemplateGUI() {
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
                                    "Create new auction",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 2,
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Auction Title: "),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.25,
                                        height: MediaQuery.of(context).size.height * 0.05,
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
                                        width: MediaQuery.of(context).size.width * 0.03,
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        child: TextField(
                                          controller: maxParticipants,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                        ),
                                      ),
                                      SizedBox(width: 30.0),
                                      Text("Round Time (s): "),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.03,
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        child: TextField(
                                          controller: roundTime,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                        ),
                                      ),
                                      SizedBox(width: 30.0),
                                      Text("Number of rounds: "),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.03,
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        child: TextField(
                                          controller: rounds,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
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
                                        items: materialTypes.map<DropdownMenuItem<String>>((String value) {
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
                                            for (int i = 0; i < contractTemplates.contractTemplates.length; i++) {
                                              if (contractTemplates.contractTemplates[i].id.toString() == newValue) {
                                                contractTemplate = contractTemplates.contractTemplates[i];
                                              }
                                            }
                                          });
                                        },
                                        items: contractIDs.map<DropdownMenuItem<String>>((String value) {
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
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5,
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
                                              SizedBox(height: 20.0),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Key: ",
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    contractTemplate.templateVariables[0].key,
                                                    style: TextStyle(fontStyle: FontStyle.italic),
                                                  ),
                                                  Text(
                                                    " Value Type: ",
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    contractTemplate.templateVariables[0].valueType,
                                                    style: TextStyle(fontStyle: FontStyle.italic),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20.0),
                                              Text(
                                                contractTemplate.templateStrings[1].text,
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
                                              children: [
                                                Text(
                                                  "Key: ",
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  contractTemplate.templateVariables[index].key,
                                                  style: TextStyle(fontStyle: FontStyle.italic),
                                                ),
                                                Text(
                                                  " Value Type: ",
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  contractTemplate.templateVariables[index].valueType,
                                                  style: TextStyle(fontStyle: FontStyle.italic),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.0),
                                            Text(
                                              contractTemplate.templateStrings[index + 1].text,
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
                              auctionHandler.createAuction(int.parse(contractDropdownValue), auctionTitle.text, int.parse(maxParticipants.text),
                                  int.parse(roundTime.text), int.parse(rounds.text), materialDropdownValue);

                              auctionTitle.clear();
                              maxParticipants.clear();
                              roundTime.clear();
                              rounds.clear();
                              materialDropdownValue = "Wood";
                              contractDropdownValue = contractTemplates.contractTemplates[0].id.toString();
                              contractTemplate = contractTemplates.contractTemplates[0];
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
                        contractDropdownValue = contractTemplates.contractTemplates[0].id.toString();
                        contractTemplate = contractTemplates.contractTemplates[0];
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
