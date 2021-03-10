import 'package:flutter/material.dart';
import 'package:new_project/Auctions/myauctions.dart';
import 'package:new_project/Entities/materialAuctionListJSON.dart';
import '../Entities/referencetype2AuctionListJSON.dart';
import '../Entities/auctionDetailsListJSON.dart';
import '../Entities/templateListJSON.dart';
import '../Entities/userListJSON.dart';
import 'userInfoHandler.dart';
import '../jsonUtilities.dart';

class Auctions {
  MaterialAuctionList materialAuctions;
  Referencetype2AuctionList referencetype2Auctions;

  Auctions(this.materialAuctions, this.referencetype2Auctions);
}

class AuctionHandler {
  Function setMainState;
  AuctionDetailsList consumerAuctionDetails; //NOT STORED LOCALLY
  AuctionDetailsList supplierAuctionDetails;
  Auctions allAuctions; //NOT STORED LOCALLY
  TemplateList consumerContractTemplates; //NOT STORED LOCALLY
  TemplateList supplierContractTemplates; //NOT STORED LOCALLY
  Auctions myAuctions; //STORED LOCALLY
  AuctionDetails currentAuctionDetails; //STORED LOCALLY
  UserInfoHandler userHandler; //STORED LOCALLY
  int nextAuctionID;
  int nextBidID;
  int nextTemplateID;

  AuctionHandler(this.setMainState, this.userHandler, this.nextAuctionID, this.nextBidID, this.nextTemplateID) {
    supplierContractTemplates = templateListFromJson(getSupplierContractTemplates());
    consumerContractTemplates = templateListFromJson(getConsumerContractTemplates());
    supplierAuctionDetails = auctionDetailsListFromJson(getSupplierAuctionDetails());
    consumerAuctionDetails = auctionDetailsListFromJson(getConsumerAuctionDetails());
    allAuctions = new Auctions(new MaterialAuctionList(materialAuctions: []), new Referencetype2AuctionList(referencetype2Auctions: []));
    myAuctions = new Auctions(new MaterialAuctionList(materialAuctions: []), new Referencetype2AuctionList(referencetype2Auctions: []));
    MaterialAuctionList m;
    Referencetype2AuctionList r;
    if (userHandler.user.currentType == "Consumer") {
      allAuctions.materialAuctions = materialAuctionListFromJson(getSupplierMaterialAuctions());
      m = materialAuctionListFromJson(getConsumerMaterialAuctions());
      allAuctions.referencetype2Auctions = referencetype2AuctionListFromJson(getSupplierReferencetype2Auctions());
      r = referencetype2AuctionListFromJson(getConsumerReferencetype2Auctions());
    } else {
      allAuctions.materialAuctions = materialAuctionListFromJson(getConsumerMaterialAuctions());
      m = materialAuctionListFromJson(getSupplierMaterialAuctions());
      allAuctions.referencetype2Auctions = referencetype2AuctionListFromJson(getConsumerReferencetype2Auctions());
      r = referencetype2AuctionListFromJson(getSupplierReferencetype2Auctions());
    }
    if (userHandler.user.participatingAuctions.length != 0) {
      for (int i = 0; i < userHandler.user.participatingAuctions.length; i++) {
        bool added = false;
        for (int y = 0; y < m.materialAuctions.length; y++) {
          if (userHandler.user.participatingAuctions[i].auctionId == m.materialAuctions[y].id) {
            myAuctions.materialAuctions.materialAuctions.add(m.materialAuctions[y]);
            added = true;
            break;
          }
        }
        if (added) {
          continue;
        }
        for (int y = 0; y < allAuctions.materialAuctions.materialAuctions.length; y++) {
          if (userHandler.user.participatingAuctions[i].auctionId == allAuctions.materialAuctions.materialAuctions[y].id) {
            myAuctions.materialAuctions.materialAuctions.add(allAuctions.materialAuctions.materialAuctions[y]);
            added = true;
            break;
          }
        }
        if (added) {
          continue;
        }
        for (int y = 0; y < r.referencetype2Auctions.length; y++) {
          if (userHandler.user.participatingAuctions[i].auctionId == r.referencetype2Auctions[y].id) {
            myAuctions.referencetype2Auctions.referencetype2Auctions.add(r.referencetype2Auctions[y]);
            added = true;
            break;
          }
        }
        if (added) {
          continue;
        }
        for (int y = 0; y < allAuctions.referencetype2Auctions.referencetype2Auctions.length; y++) {
          if (userHandler.user.participatingAuctions[i].auctionId == allAuctions.referencetype2Auctions.referencetype2Auctions[y].id) {
            myAuctions.referencetype2Auctions.referencetype2Auctions.add(allAuctions.referencetype2Auctions.referencetype2Auctions[y]);
            break;
          }
        }
      }
    }
  }

  void createMaterialAuction(int templateID, String title, int maxParticipants, int duration, String fibersType, String resinType, String recyclingTechnology,
      String sizing, String additives, int minFiberLength, int maxFiberLength, int minVolume, int maxVolume) {
    DateTime startDate = new DateTime.now();
    DateTime stopDate = startDate.add(Duration(minutes: (duration)));

    AuctionDetails newAuctionDetails = new AuctionDetails(id: nextAuctionID, participants: [], templateId: templateID, bids: [], winningBid: 0);
    MaterialAuction newMaterialAuction = new MaterialAuction(
        id: nextAuctionID,
        title: title,
        ownerId: userHandler.user.userId,
        maxParticipants: maxParticipants,
        currentParticipants: 0,
        startDate: startDate,
        stopDate: stopDate,
        referenceSector: "composites",
        referenceType: "material",
        materialReferenceParameters: new MaterialReferenceParameters(
            fibersType: fibersType,
            resinType: resinType,
            minFiberLength: minFiberLength,
            maxFiberLength: maxFiberLength,
            recyclingTechnology: recyclingTechnology,
            sizing: sizing,
            additives: additives,
            minVolume: minVolume,
            maxVolume: maxVolume));

    // Add to "database".
    if (userHandler.user.currentType == "Consumer") {
      consumerAuctionDetails.auctionDetailsList.add(newAuctionDetails);
      setConsumerAuctionDetails(auctionDetailsListToJson(consumerAuctionDetails));
      MaterialAuctionList m = materialAuctionListFromJson(getConsumerMaterialAuctions());
      m.materialAuctions.add(newMaterialAuction);
      setConsumerMaterialAuctions(materialAuctionListToJson(m));
    } else {
      supplierAuctionDetails.auctionDetailsList.add(newAuctionDetails);
      setSupplierAuctionDetails(auctionDetailsListToJson(supplierAuctionDetails));
      MaterialAuctionList m = materialAuctionListFromJson(getSupplierMaterialAuctions());
      m.materialAuctions.add(newMaterialAuction);
      setSupplierMaterialAuctions(materialAuctionListToJson(m));
    }
    // Add to myAuctions.
    myAuctions.materialAuctions.materialAuctions.add(newMaterialAuction);
    // Add to user's auctions.
    ParticipatingAuction a = new ParticipatingAuction(auctionId: nextAuctionID);
    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
      if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
        userHandler.userListObject.users[i].participatingAuctions.add(a);
        break;
      }
    }
    setUsers(userListToJson(userHandler.userListObject));
    nextAuctionID++;
    setMainState("Auction");
  }

  void createReferencetype2Auction(
      int templateID, String title, int maxParticipants, int duration, String parameter1, String parameter2, int minVolume, int maxVolume) {
    DateTime startDate = new DateTime.now();
    DateTime stopDate = startDate.add(Duration(minutes: (duration)));

    AuctionDetails newAuctionDetails = new AuctionDetails(id: nextAuctionID, participants: [], templateId: templateID, bids: [], winningBid: 0);
    Referencetype2Auction newReferencetype2Auction = new Referencetype2Auction(
        id: nextAuctionID,
        title: title,
        ownerId: userHandler.user.userId,
        maxParticipants: maxParticipants,
        currentParticipants: 0,
        startDate: startDate,
        stopDate: stopDate,
        referenceSector: "composites",
        referenceType: "referencetype2",
        referencetype2ReferenceParameters:
            new Referencetype2ReferenceParameters(parameter1: parameter1, parameter2: parameter2, minVolume: minVolume, maxVolume: maxVolume));

    // Add to "database".
    if (userHandler.user.currentType == "Consumer") {
      consumerAuctionDetails.auctionDetailsList.add(newAuctionDetails);
      setConsumerAuctionDetails(auctionDetailsListToJson(consumerAuctionDetails));
      Referencetype2AuctionList r = referencetype2AuctionListFromJson(getConsumerReferencetype2Auctions());
      r.referencetype2Auctions.add(newReferencetype2Auction);
      setConsumerReferencetype2Auctions(referencetype2AuctionListToJson(r));
    } else {
      supplierAuctionDetails.auctionDetailsList.add(newAuctionDetails);
      setSupplierAuctionDetails(auctionDetailsListToJson(supplierAuctionDetails));
      Referencetype2AuctionList r = referencetype2AuctionListFromJson(getSupplierReferencetype2Auctions());
      r.referencetype2Auctions.add(newReferencetype2Auction);
      setSupplierReferencetype2Auctions(referencetype2AuctionListToJson(r));
    }
    // Add to myAuctions.
    myAuctions.referencetype2Auctions.referencetype2Auctions.add(newReferencetype2Auction);
    // Add to user's auctions.
    ParticipatingAuction a = new ParticipatingAuction(auctionId: nextAuctionID);
    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
      if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
        userHandler.userListObject.users[i].participatingAuctions.add(a);
        break;
      }
    }
    setUsers(userListToJson(userHandler.userListObject));
    nextAuctionID++;
    setMainState("Auction");
  }

  //unimplemented
  void endAuction() {}
  void joinAuction() {}
  void leaveAuction() {}
  void selectAuctionWinner() {}

  // Triggers when "visit room" button is pressed. Assumes that user already is a participant of the auction.
  void setCurrentAuction(int auctionid) {
    for (int i = 0; i < consumerAuctionDetails.auctionDetailsList.length; i++) {
      if (consumerAuctionDetails.auctionDetailsList[i].id == auctionid) {
        currentAuctionDetails = consumerAuctionDetails.auctionDetailsList[i];
        return;
      }
    }
    for (int i = 0; i < supplierAuctionDetails.auctionDetailsList.length; i++) {
      if (supplierAuctionDetails.auctionDetailsList[i].id == auctionid) {
        currentAuctionDetails = supplierAuctionDetails.auctionDetailsList[i];
        return;
      }
    }
  }

  // Used in allauctions, gets the auction titles of the ongoing auctions owned by user that do not contain userID.
  List<String> getAuctionTitles(String referencetype, int userID) {
    List<String> l = ["Auction title"];
    if (referencetype == "material") {
      if (userHandler.user.currentType == "Consumer") {
        for (int i = 0; i < myAuctions.materialAuctions.materialAuctions.length; i++) {
          if (myAuctions.materialAuctions.materialAuctions[i].ownerId == userHandler.user.userId &&
              myAuctions.materialAuctions.materialAuctions[i].stopDate.isAfter(new DateTime.now())) {
            for (int y = 0; y < consumerAuctionDetails.auctionDetailsList.length; y++) {
              if (myAuctions.materialAuctions.materialAuctions[i].id == consumerAuctionDetails.auctionDetailsList[y].id) {
                bool add = true;
                for (int u = 0; u < consumerAuctionDetails.auctionDetailsList[y].participants.length; u++) {
                  if (consumerAuctionDetails.auctionDetailsList[y].participants[u].userId == userID) {
                    add = false;
                    break;
                  }
                }
                if (add) {
                  l.add(myAuctions.materialAuctions.materialAuctions[i].title);
                }
                break;
              }
            }
          }
        }
      }
      if (userHandler.user.currentType == "Supplier") {
        for (int i = 0; i < myAuctions.materialAuctions.materialAuctions.length; i++) {
          if (myAuctions.materialAuctions.materialAuctions[i].ownerId == userHandler.user.userId &&
              myAuctions.materialAuctions.materialAuctions[i].stopDate.isAfter(new DateTime.now())) {
            for (int y = 0; y < supplierAuctionDetails.auctionDetailsList.length; y++) {
              if (myAuctions.materialAuctions.materialAuctions[i].id == supplierAuctionDetails.auctionDetailsList[y].id) {
                bool add = true;
                for (int u = 0; u < supplierAuctionDetails.auctionDetailsList[y].participants.length; u++) {
                  if (supplierAuctionDetails.auctionDetailsList[y].participants[u].userId == userID) {
                    add = false;
                    break;
                  }
                }
                if (add) {
                  l.add(myAuctions.materialAuctions.materialAuctions[i].title);
                }
                break;
              }
            }
          }
        }
      }
    }
    if (referencetype == "referencetype2") {
      if (userHandler.user.currentType == "Consumer") {
        for (int i = 0; i < myAuctions.referencetype2Auctions.referencetype2Auctions.length; i++) {
          if (myAuctions.referencetype2Auctions.referencetype2Auctions[i].ownerId == userHandler.user.userId &&
              myAuctions.referencetype2Auctions.referencetype2Auctions[i].stopDate.isAfter(new DateTime.now())) {
            for (int y = 0; y < consumerAuctionDetails.auctionDetailsList.length; y++) {
              if (myAuctions.referencetype2Auctions.referencetype2Auctions[i].id == consumerAuctionDetails.auctionDetailsList[y].id) {
                bool add = true;
                for (int u = 0; u < consumerAuctionDetails.auctionDetailsList[y].participants.length; u++) {
                  if (consumerAuctionDetails.auctionDetailsList[y].participants[u].userId == userID) {
                    add = false;
                    break;
                  }
                }
                if (add) {
                  l.add(myAuctions.referencetype2Auctions.referencetype2Auctions[i].title);
                }
                break;
              }
            }
          }
        }
      }
      if (userHandler.user.currentType == "Supplier") {
        for (int i = 0; i < myAuctions.referencetype2Auctions.referencetype2Auctions.length; i++) {
          if (myAuctions.referencetype2Auctions.referencetype2Auctions[i].ownerId == userHandler.user.userId &&
              myAuctions.referencetype2Auctions.referencetype2Auctions[i].stopDate.isAfter(new DateTime.now())) {
            for (int y = 0; y < supplierAuctionDetails.auctionDetailsList.length; y++) {
              if (myAuctions.referencetype2Auctions.referencetype2Auctions[i].id == supplierAuctionDetails.auctionDetailsList[y].id) {
                bool add = true;
                for (int u = 0; u < supplierAuctionDetails.auctionDetailsList[y].participants.length; u++) {
                  if (supplierAuctionDetails.auctionDetailsList[y].participants[u].userId == userID) {
                    add = false;
                    break;
                  }
                }
                if (add) {
                  l.add(myAuctions.referencetype2Auctions.referencetype2Auctions[i].title);
                }
                break;
              }
            }
          }
        }
      }
    }
    return l;
  }

  void createBid(List<TextEditingController> controllers) {}

  // NEW CONTRACT TEMPLATE (administrator, remove?)
  void createContractTemplate(List<String> strings, List<String> keys, List<String> valueTypes, String userType) {
    List<TemplateString> ts = [];
    for (int i = 0; i < strings.length; i++) {
      ts.add(new TemplateString(text: strings[i]));
    }

    List<TemplateVariable> tv = [];
    for (int i = 0; i < keys.length; i++) {
      tv.add(new TemplateVariable(key: keys[i], valueType: valueTypes[i]));
    }

    Template contractTemplate = new Template(id: nextTemplateID, templateStrings: ts, templateVariables: tv);

    if (userType == "Supplier") {
      supplierContractTemplates.templates.add(contractTemplate);
      setSupplierContractTemplates(templateListToJson(supplierContractTemplates));
    }
    if (userType == "Consumer") {
      consumerContractTemplates.templates.add(contractTemplate);
      setConsumerContractTemplates(templateListToJson(consumerContractTemplates));
    }
    nextTemplateID++;
  }

  int templateItemCount = 1;
  List<TextEditingController> controllers = [TextEditingController(), TextEditingController(), TextEditingController()];
  List<String> valueTypes = ["Text", "Integer"];
  List<String> dropdownValues = ["Text"];
  List<String> userTypes = ["Supplier", "Consumer"];
  String dropdownValue = "Supplier";

  void showContractTemplateGUI(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
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
                                    "Contract template creator",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 2,
                                  ),
                                  SizedBox(height: 24.0),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: templateItemCount,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                height: MediaQuery.of(context).size.height * 0.1,
                                                child: TextField(
                                                  maxLines: null,
                                                  controller: controllers[0],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                height: MediaQuery.of(context).size.height * 0.1,
                                                child: Row(
                                                  children: [
                                                    Text("Key: "),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.05,
                                                      height: MediaQuery.of(context).size.height * 0.05,
                                                      child: TextField(
                                                        controller: controllers[1],
                                                      ),
                                                    ),
                                                    Text(" Value Type: "),
                                                    DropdownButton(
                                                      icon: Icon(Icons.arrow_downward),
                                                      iconSize: 24,
                                                      value: dropdownValues[index],
                                                      elevation: 16,
                                                      style: TextStyle(color: Colors.white),
                                                      onChanged: (String newValue) {
                                                        setState(() {
                                                          dropdownValues[index] = newValue;
                                                        });
                                                      },
                                                      items: valueTypes.map<DropdownMenuItem<String>>((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                height: MediaQuery.of(context).size.height * 0.1,
                                                child: TextField(
                                                  maxLines: null,
                                                  controller: controllers[2],
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        return Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              height: MediaQuery.of(context).size.height * 0.1,
                                              child: Row(
                                                children: [
                                                  Text("Key: "),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.05,
                                                    height: MediaQuery.of(context).size.height * 0.05,
                                                    child: TextField(
                                                      controller: controllers[index * 2 + 1],
                                                    ),
                                                  ),
                                                  Text(" Value Type: "),
                                                  DropdownButton(
                                                    icon: Icon(Icons.arrow_downward),
                                                    iconSize: 24,
                                                    value: dropdownValues[index],
                                                    elevation: 16,
                                                    style: TextStyle(color: Colors.white),
                                                    onChanged: (String newValue) {
                                                      setState(() {
                                                        dropdownValues[index] = newValue;
                                                      });
                                                    },
                                                    items: valueTypes.map<DropdownMenuItem<String>>((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              height: MediaQuery.of(context).size.height * 0.1,
                                              child: TextField(
                                                maxLines: null,
                                                controller: controllers[index * 2 + 2],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        templateItemCount++;
                                        controllers.add(TextEditingController());
                                        controllers.add(TextEditingController());
                                        dropdownValues.add("Text");
                                      });
                                    },
                                    child: Text("New variable"),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height * 0.05,
                                    child: Row(
                                      children: [
                                        Text("User Type: "),
                                        DropdownButton(
                                          icon: Icon(Icons.arrow_downward),
                                          iconSize: 24,
                                          value: dropdownValue,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.white),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              dropdownValue = newValue;
                                            });
                                          },
                                          items: userTypes.map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          child: Text("Add contract template"),
                          onPressed: () {
                            List<String> templateStrings = [];
                            templateStrings.add(controllers[0].text);
                            for (int i = 0; i < templateItemCount; i++) {
                              templateStrings.add(controllers[i * 2 + 2].text);
                            }

                            List<String> keys = [];
                            for (int i = 0; i < templateItemCount; i++) {
                              keys.add(controllers[i * 2 + 1].text);
                            }

                            createContractTemplate(templateStrings, keys, dropdownValues, dropdownValue);

                            templateItemCount = 1;
                            controllers = [TextEditingController(), TextEditingController(), TextEditingController()];
                            dropdownValues = ["Text"];
                            dropdownValue = "Supplier";
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
                      templateItemCount = 1;
                      controllers = [TextEditingController(), TextEditingController(), TextEditingController()];
                      dropdownValues = ["Text"];
                      dropdownValue = "Supplier";
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
