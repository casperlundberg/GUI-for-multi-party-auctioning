import 'package:flutter/material.dart';

import '../Entities/auctionListJSON.dart';
import '../Entities/auctionDetailsListJSON.dart';
import '../Entities/contractTemplatesJSON.dart';
import '../Entities/userList.dart';
import 'userInfoHandler.dart';
import '../jsonUtilities.dart';

class AuctionHandler {
  Function setMainState;
  AuctionList allAuctions;
  AuctionDetailsList auctionDetailsList;
  AuctionList myAuctions;
  AuctionDetails currentAuction;
  ContractTemplates supplierContractTemplates;
  ContractTemplates consumerContractTemplates;
  UserInfoHandler userHandler;

  AuctionHandler(
      this.setMainState,
      this.allAuctions,
      this.auctionDetailsList,
      this.myAuctions,
      this.currentAuction,
      this.supplierContractTemplates,
      this.consumerContractTemplates,
      this.userHandler);

  void createAuction(int contractID, String title, int maxParticipants,
      int roundTime, int rounds, String material) {
    int highestid = 0;
    for (int i = 0; i < allAuctions.auctionList.length; i++) {
      if (allAuctions.auctionList[i].id > highestid) {
        highestid = allAuctions.auctionList[i].id;
      }
    }
    highestid++;

    DateTime startDate = new DateTime.now();
    DateTime stopDate = startDate.add(Duration(seconds: (roundTime * rounds)));

    AuctionDetails newAuctionDetails = new AuctionDetails(
        id: highestid,
        title: title,
        ownerId: userHandler.user.userId,
        ownerType: userHandler.user.currentType,
        maxParticipants: maxParticipants,
        participants: [],
        roundTime: roundTime,
        material: material,
        contractTemplateId: contractID,
        bids: [],
        startDate: startDate,
        stopDate: stopDate,
        referenceSector: "composites",
        referenceType: "material");

    Auction newAuction = new Auction(
        id: highestid,
        title: title,
        ownerId: userHandler.user.userId,
        ownerType: userHandler.user.currentType,
        maxParticipants: maxParticipants,
        currentParticipants: 0,
        roundTime: roundTime,
        material: material,
        startDate: startDate,
        stopDate: stopDate,
        referenceSector: "composites",
        referenceType: "material");

    auctionDetailsList.auctionDetailsList.add(newAuctionDetails);
    setAuctionDetailsListString(auctionDetailsListToJson(auctionDetailsList));
    allAuctions.auctionList.add(newAuction);
    setAuctionsListString(auctionListToJson(allAuctions));
    myAuctions.auctionList.add(newAuction);
    ParticipatingAuction a = new ParticipatingAuction(auctionId: highestid);
    userHandler.user.participatingAuctions.add(a);
    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
      if (userHandler.userListObject.users[i].userId ==
          userHandler.user.userId) {
        userHandler.userListObject.users[i].participatingAuctions.add(a);
        break;
      }
    }
    setUserListString(userListToJson(userHandler.userListObject));
  }

  // Triggers when "visit room" button is pressed. Assumes that user already is a participant of the auction.
  void setCurrentAuction(int auctionid) {
    // Retrieve auction details
    for (int i = 0; i < auctionDetailsList.auctionDetailsList.length; i++) {
      if (auctionDetailsList.auctionDetailsList[i].id == auctionid) {
        currentAuction = auctionDetailsList.auctionDetailsList[i];
      }
    }
    // Retrieve contract template
    if (currentAuction.ownerType == "Supplier") {
      for (int i = 0;
          i < supplierContractTemplates.contractTemplates.length;
          i++) {
        if (supplierContractTemplates.contractTemplates[i].id ==
            currentAuction.contractTemplateId) {
          currentAuction.contractTemplate =
              supplierContractTemplates.contractTemplates[i];
        }
      }
    } else {
      for (int i = 0;
          i < consumerContractTemplates.contractTemplates.length;
          i++) {
        if (consumerContractTemplates.contractTemplates[i].id ==
            currentAuction.contractTemplateId) {
          currentAuction.contractTemplate =
              consumerContractTemplates.contractTemplates[i];
        }
      }
    }
  }

  void createBid(List<TextEditingController> controllers) {
    //
    List<KeyValuePair> pairs = [];

    for (int i = 0; i < controllers.length; i++) {
      pairs.add(KeyValuePair(
          key: currentAuction.contractTemplate.templateVariables[i].key,
          value: controllers[i].text));

      controllers[i].clear();
    }

    Bid bid = Bid(
        userId: userHandler.user.userId,
        time: DateTime.now(),
        keyValuePairs: pairs);

    //TODO: Add pricechecks, copy-checks, etc
    //TODO: Check if auction is ongoing, throw exception if not
    currentAuction.bids.add(bid);

    //TODO: Push to API
  }

  // NEW TEMPLATE (administrator)
  void createContractTemplate(List<String> strings, List<String> keys,
      List<String> valueTypes, String userType) {
    ContractTemplates contractTemplates;
    if (userType == "Supplier") {
      contractTemplates = supplierContractTemplates;
    }
    if (userType == "Consumer") {
      contractTemplates = consumerContractTemplates;
    }

    int highestid = 0;
    for (int i = 0; i < contractTemplates.contractTemplates.length; i++) {
      if (contractTemplates.contractTemplates[i].id > highestid) {
        highestid = contractTemplates.contractTemplates[i].id;
      }
    }
    highestid++;

    List<TemplateString> ts = [];
    for (int i = 0; i < strings.length; i++) {
      ts.add(new TemplateString(text: strings[i]));
    }

    List<TemplateVariable> tv = [];
    for (int i = 0; i < keys.length; i++) {
      tv.add(new TemplateVariable(key: keys[i], valueType: valueTypes[i]));
    }

    ContractTemplate contractTemplate = new ContractTemplate(
        id: highestid, templateStrings: ts, templateVariables: tv);

    if (userType == "Supplier") {
      supplierContractTemplates.contractTemplates.add(contractTemplate);
      setSupplierContractTemplatesString(
          contractTemplatesToJson(supplierContractTemplates));
    }
    if (userType == "Consumer") {
      consumerContractTemplates.contractTemplates.add(contractTemplate);
      setConsumerContractTemplatesString(
          contractTemplatesToJson(consumerContractTemplates));
    }
  }

  int templateItemCount = 1;
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
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
                                    "Contract template creator",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.05,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                child: TextField(
                                                  maxLines: null,
                                                  controller: controllers[0],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.05,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                child: Row(
                                                  children: [
                                                    Text("Key: "),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.05,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                      child: TextField(
                                                        controller:
                                                            controllers[1],
                                                      ),
                                                    ),
                                                    Text(" Value Type: "),
                                                    DropdownButton(
                                                      icon: Icon(
                                                          Icons.arrow_downward),
                                                      iconSize: 24,
                                                      value:
                                                          dropdownValues[index],
                                                      elevation: 16,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      onChanged:
                                                          (String newValue) {
                                                        setState(() {
                                                          dropdownValues[
                                                              index] = newValue;
                                                        });
                                                      },
                                                      items: valueTypes.map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
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
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.05,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
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
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              child: Row(
                                                children: [
                                                  Text("Key: "),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                    child: TextField(
                                                      controller: controllers[
                                                          index * 2 + 1],
                                                    ),
                                                  ),
                                                  Text(" Value Type: "),
                                                  DropdownButton(
                                                    icon: Icon(
                                                        Icons.arrow_downward),
                                                    iconSize: 24,
                                                    value:
                                                        dropdownValues[index],
                                                    elevation: 16,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        dropdownValues[index] =
                                                            newValue;
                                                      });
                                                    },
                                                    items: valueTypes.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
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
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              child: TextField(
                                                maxLines: null,
                                                controller:
                                                    controllers[index * 2 + 2],
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
                                        controllers
                                            .add(TextEditingController());
                                        controllers
                                            .add(TextEditingController());
                                        dropdownValues.add("Text");
                                      });
                                    },
                                    child: Text("New variable"),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
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
                                          items: userTypes
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

                            createContractTemplate(templateStrings, keys,
                                dropdownValues, dropdownValue);

                            templateItemCount = 1;
                            controllers = [
                              TextEditingController(),
                              TextEditingController(),
                              TextEditingController()
                            ];
                            dropdownValues = ["Text"];
                            dropdownValue = "Supplier";
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
                      templateItemCount = 1;
                      controllers = [
                        TextEditingController(),
                        TextEditingController(),
                        TextEditingController()
                      ];
                      dropdownValues = ["Text"];
                      dropdownValue = "Supplier";
                      setMainState();
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
