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
  List<Inbox> inbox;
  List<String> inboxAuctionTitles;

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
    // Get myAuctions.
    if (userHandler.user.participatingAuctions.length != 0) {
      for (int i = 0; i < userHandler.user.participatingAuctions.length; i++) {
        bool added = false;
        for (int y = 0; y < m.materialAuctions.length; y++) {
          if (userHandler.user.participatingAuctions[i].auctionId == m.materialAuctions[y].id) {
            if (m.materialAuctions[y].ownerId == userHandler.user.userId) {
              myAuctions.materialAuctions.materialAuctions.add(m.materialAuctions[y]);
            }
            added = true;
            break;
          }
        }
        if (added) {
          continue;
        }
        for (int y = 0; y < allAuctions.materialAuctions.materialAuctions.length; y++) {
          if (userHandler.user.participatingAuctions[i].auctionId == allAuctions.materialAuctions.materialAuctions[y].id) {
            if (allAuctions.materialAuctions.materialAuctions[y].ownerId != userHandler.user.userId) {
              myAuctions.materialAuctions.materialAuctions.add(allAuctions.materialAuctions.materialAuctions[y]);
            }
            added = true;
            break;
          }
        }
        if (added) {
          continue;
        }
        for (int y = 0; y < r.referencetype2Auctions.length; y++) {
          if (userHandler.user.participatingAuctions[i].auctionId == r.referencetype2Auctions[y].id) {
            if (r.referencetype2Auctions[y].ownerId == userHandler.user.userId) {
              myAuctions.referencetype2Auctions.referencetype2Auctions.add(r.referencetype2Auctions[y]);
            }
            added = true;
            break;
          }
        }
        if (added) {
          continue;
        }
        for (int y = 0; y < allAuctions.referencetype2Auctions.referencetype2Auctions.length; y++) {
          if (userHandler.user.participatingAuctions[i].auctionId == allAuctions.referencetype2Auctions.referencetype2Auctions[y].id) {
            if (allAuctions.referencetype2Auctions.referencetype2Auctions[y].ownerId != userHandler.user.userId) {
              myAuctions.referencetype2Auctions.referencetype2Auctions.add(allAuctions.referencetype2Auctions.referencetype2Auctions[y]);
            }
            break;
          }
        }
      }
    }
    // Get inbox.
    inbox = [];
    inboxAuctionTitles = [];
    for (int i = 0; i < userHandler.user.requestInbox.length; i++) {
      bool added = false;
      for (int y = 0; y < myAuctions.materialAuctions.materialAuctions.length; y++) {
        if (myAuctions.materialAuctions.materialAuctions[y].id == userHandler.user.requestInbox[i].auctionId) {
          inbox.add(userHandler.user.requestInbox[i]);
          inboxAuctionTitles.add(myAuctions.materialAuctions.materialAuctions[y].title);
          added = true;
          break;
        }
      }
      if (added) {
        continue;
      }
      for (int y = 0; y < myAuctions.referencetype2Auctions.referencetype2Auctions.length; y++) {
        if (myAuctions.referencetype2Auctions.referencetype2Auctions[y].id == userHandler.user.requestInbox[i].auctionId) {
          inbox.add(userHandler.user.requestInbox[i]);
          inboxAuctionTitles.add(myAuctions.referencetype2Auctions.referencetype2Auctions[y].title);
          added = true;
          break;
        }
      }
      if (added) {
        continue;
      }
      for (int y = 0; y < allAuctions.materialAuctions.materialAuctions.length; y++) {
        if (allAuctions.materialAuctions.materialAuctions[y].id == userHandler.user.requestInbox[i].auctionId) {
          inbox.add(userHandler.user.requestInbox[i]);
          inboxAuctionTitles.add(allAuctions.materialAuctions.materialAuctions[y].title);
          added = true;
          break;
        }
      }
      if (added) {
        continue;
      }
      for (int y = 0; y < allAuctions.referencetype2Auctions.referencetype2Auctions.length; y++) {
        if (allAuctions.referencetype2Auctions.referencetype2Auctions[y].id == userHandler.user.requestInbox[i].auctionId) {
          inbox.add(userHandler.user.requestInbox[i]);
          inboxAuctionTitles.add(allAuctions.referencetype2Auctions.referencetype2Auctions[y].title);
          added = true;
          break;
        }
      }
    }
    for (int i = 0; i < userHandler.user.inviteInbox.length; i++) {
      bool added = false;
      for (int y = 0; y < myAuctions.materialAuctions.materialAuctions.length; y++) {
        if (myAuctions.materialAuctions.materialAuctions[y].id == userHandler.user.inviteInbox[i].auctionId) {
          inbox.add(userHandler.user.inviteInbox[i]);
          inboxAuctionTitles.add(myAuctions.materialAuctions.materialAuctions[y].title);
          added = true;
          break;
        }
      }
      if (added) {
        continue;
      }
      for (int y = 0; y < myAuctions.referencetype2Auctions.referencetype2Auctions.length; y++) {
        if (myAuctions.referencetype2Auctions.referencetype2Auctions[y].id == userHandler.user.inviteInbox[i].auctionId) {
          inbox.add(userHandler.user.inviteInbox[i]);
          inboxAuctionTitles.add(myAuctions.referencetype2Auctions.referencetype2Auctions[y].title);
          added = true;
          break;
        }
      }
      if (added) {
        continue;
      }
      for (int y = 0; y < allAuctions.materialAuctions.materialAuctions.length; y++) {
        if (allAuctions.materialAuctions.materialAuctions[y].id == userHandler.user.inviteInbox[i].auctionId) {
          inbox.add(userHandler.user.inviteInbox[i]);
          inboxAuctionTitles.add(allAuctions.materialAuctions.materialAuctions[y].title);
          added = true;
          break;
        }
      }
      if (added) {
        continue;
      }
      for (int y = 0; y < allAuctions.referencetype2Auctions.referencetype2Auctions.length; y++) {
        if (allAuctions.referencetype2Auctions.referencetype2Auctions[y].id == userHandler.user.inviteInbox[i].auctionId) {
          inbox.add(userHandler.user.inviteInbox[i]);
          inboxAuctionTitles.add(allAuctions.referencetype2Auctions.referencetype2Auctions[y].title);
          added = true;
          break;
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

  void endAuction() {
    DateTime now = new DateTime.now();
    // Update "database".
    bool updated = false;
    if (userHandler.user.currentType == "Consumer") {
      MaterialAuctionList materialAuctions = materialAuctionListFromJson(getConsumerMaterialAuctions());
      Referencetype2AuctionList referencetype2Auctions = referencetype2AuctionListFromJson(getConsumerReferencetype2Auctions());
      for (int i = 0; i < materialAuctions.materialAuctions.length; i++) {
        if (materialAuctions.materialAuctions[i].id == currentAuctionDetails.id) {
          materialAuctions.materialAuctions[i].stopDate = now;
          setConsumerMaterialAuctions(materialAuctionListToJson(materialAuctions));
          updated = true;
          break;
        }
      }
      if (!updated) {
        for (int i = 0; i < referencetype2Auctions.referencetype2Auctions.length; i++) {
          if (referencetype2Auctions.referencetype2Auctions[i].id == currentAuctionDetails.id) {
            referencetype2Auctions.referencetype2Auctions[i].stopDate = now;
            setConsumerReferencetype2Auctions(referencetype2AuctionListToJson(referencetype2Auctions));
            updated = true;
            break;
          }
        }
      }
    }
    if (userHandler.user.currentType == "Supplier") {
      MaterialAuctionList materialAuctions = materialAuctionListFromJson(getSupplierMaterialAuctions());
      Referencetype2AuctionList referencetype2Auctions = referencetype2AuctionListFromJson(getSupplierReferencetype2Auctions());
      for (int i = 0; i < materialAuctions.materialAuctions.length; i++) {
        if (materialAuctions.materialAuctions[i].id == currentAuctionDetails.id) {
          materialAuctions.materialAuctions[i].stopDate = now;
          setSupplierMaterialAuctions(materialAuctionListToJson(materialAuctions));
          updated = true;
          break;
        }
      }
      if (!updated) {
        for (int i = 0; i < referencetype2Auctions.referencetype2Auctions.length; i++) {
          if (referencetype2Auctions.referencetype2Auctions[i].id == currentAuctionDetails.id) {
            referencetype2Auctions.referencetype2Auctions[i].stopDate = now;
            setSupplierReferencetype2Auctions(referencetype2AuctionListToJson(referencetype2Auctions));
            updated = true;
            break;
          }
        }
      }
    }
    updated = false;
    //Update myAuctions.
    for (int i = 0; i < myAuctions.materialAuctions.materialAuctions.length; i++) {
      if (myAuctions.materialAuctions.materialAuctions[i].id == currentAuctionDetails.id) {
        myAuctions.materialAuctions.materialAuctions[i].stopDate = now;
        updated = true;
        break;
      }
    }
    if (!updated) {
      for (int i = 0; i < myAuctions.referencetype2Auctions.referencetype2Auctions.length; i++) {
        if (myAuctions.referencetype2Auctions.referencetype2Auctions[i].id == currentAuctionDetails.id) {
          myAuctions.referencetype2Auctions.referencetype2Auctions[i].stopDate = now;
          updated = true;
          break;
        }
      }
    }
  }

  void leaveAuction() {
    //Remove from auction details.
    if (userHandler.user.currentType == "Consumer") {
      for (int i = 0; i < supplierAuctionDetails.auctionDetailsList.length; i++) {
        if (supplierAuctionDetails.auctionDetailsList[i].id == currentAuctionDetails.id) {
          for (int y = 0; y < supplierAuctionDetails.auctionDetailsList[i].participants.length; y++) {
            if (supplierAuctionDetails.auctionDetailsList[i].participants[y].userId == userHandler.user.userId) {
              supplierAuctionDetails.auctionDetailsList[i].participants.removeAt(y);
              setSupplierAuctionDetails(auctionDetailsListToJson(supplierAuctionDetails));
              break;
            }
          }
          break;
        }
      }
    }
    if (userHandler.user.currentType == "Supplier") {
      for (int i = 0; i < consumerAuctionDetails.auctionDetailsList.length; i++) {
        if (consumerAuctionDetails.auctionDetailsList[i].id == currentAuctionDetails.id) {
          for (int y = 0; y < consumerAuctionDetails.auctionDetailsList[i].participants.length; y++) {
            if (consumerAuctionDetails.auctionDetailsList[i].participants[y].userId == userHandler.user.userId) {
              consumerAuctionDetails.auctionDetailsList[i].participants.removeAt(y);
              setConsumerAuctionDetails(auctionDetailsListToJson(consumerAuctionDetails));
              break;
            }
          }
          break;
        }
      }
    }
    //Remove from myAuctions.
    for (int i = 0; i < myAuctions.materialAuctions.materialAuctions.length; i++) {
      if (myAuctions.materialAuctions.materialAuctions[i].id == currentAuctionDetails.id) {
        myAuctions.materialAuctions.materialAuctions.removeAt(i);
        break;
      }
    }
    for (int i = 0; i < myAuctions.referencetype2Auctions.referencetype2Auctions.length; i++) {
      if (myAuctions.referencetype2Auctions.referencetype2Auctions[i].id == currentAuctionDetails.id) {
        myAuctions.referencetype2Auctions.referencetype2Auctions.removeAt(i);
        break;
      }
    }
    //Remove from participating auctions.
    for (int i = 0; i < userHandler.user.participatingAuctions.length; i++) {
      if (userHandler.user.participatingAuctions[i].auctionId == currentAuctionDetails.id) {
        userHandler.user.participatingAuctions.removeAt(i);
        break;
      }
    }
    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
      if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
        for (int y = 0; y < userHandler.userListObject.users[i].participatingAuctions.length; y++) {
          if (userHandler.userListObject.users[i].participatingAuctions[y].auctionId == currentAuctionDetails.id) {
            userHandler.userListObject.users[i].participatingAuctions.removeAt(y);
            break;
          }
        }
        break;
      }
    }
    setUsers(userListToJson(userHandler.userListObject));
    setMainState("Auction");
  }

  void selectAuctionWinner(int bidID) {
    currentAuctionDetails.winningBid = bidID;
    //Update "database".
    if (userHandler.user.currentType == "Consumer") {
      for (int i = 0; i < consumerAuctionDetails.auctionDetailsList.length; i++) {
        if (currentAuctionDetails.id == consumerAuctionDetails.auctionDetailsList[i].id) {
          consumerAuctionDetails.auctionDetailsList[i].winningBid = bidID;
          setConsumerAuctionDetails(auctionDetailsListToJson(consumerAuctionDetails));
          break;
        }
      }
    }
    if (userHandler.user.currentType == "Supplier") {
      for (int i = 0; i < supplierAuctionDetails.auctionDetailsList.length; i++) {
        if (currentAuctionDetails.id == supplierAuctionDetails.auctionDetailsList[i].id) {
          supplierAuctionDetails.auctionDetailsList[i].winningBid = bidID;
          setSupplierAuctionDetails(auctionDetailsListToJson(supplierAuctionDetails));
          break;
        }
      }
    }
    endAuction();
  }

  void viewBid(Template contractTemplate, List<KeyValuePair> keyValuePairs, BuildContext context) {
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
                                    "Bid",
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
                                              SizedBox(height: 20.0),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Key: ",
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    keyValuePairs[0].key,
                                                    style: TextStyle(fontStyle: FontStyle.italic),
                                                  ),
                                                  Text(
                                                    " Value: ",
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    keyValuePairs[0].value.toString(),
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
                                                  keyValuePairs[index].key,
                                                  style: TextStyle(fontStyle: FontStyle.italic),
                                                ),
                                                Text(
                                                  " Value Type: ",
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  keyValuePairs[index].value.toString(),
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

  // Triggers when "visit room" button is pressed.
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

  void makeBid(List<KeyValuePair> keyValuePairs) {
    DateTime now = new DateTime.now();
    currentAuctionDetails.bids.add(new Bid(id: nextBidID, time: now, userId: userHandler.user.userId, keyValuePairs: keyValuePairs));
    if (userHandler.user.currentType == "Consumer") {
      for (int i = 0; i < supplierAuctionDetails.auctionDetailsList.length; i++) {
        if (currentAuctionDetails.id == supplierAuctionDetails.auctionDetailsList[i].id) {
          supplierAuctionDetails.auctionDetailsList[i].bids
              .add(new Bid(id: nextBidID, time: now, userId: userHandler.user.userId, keyValuePairs: keyValuePairs));
          setSupplierAuctionDetails(auctionDetailsListToJson(supplierAuctionDetails));
          break;
        }
      }
    }
    if (userHandler.user.currentType == "Supplier") {
      for (int i = 0; i < consumerAuctionDetails.auctionDetailsList.length; i++) {
        if (currentAuctionDetails.id == consumerAuctionDetails.auctionDetailsList[i].id) {
          consumerAuctionDetails.auctionDetailsList[i].bids
              .add(new Bid(id: nextBidID, time: now, userId: userHandler.user.userId, keyValuePairs: keyValuePairs));
          setConsumerAuctionDetails(auctionDetailsListToJson(consumerAuctionDetails));
          break;
        }
      }
    }
    nextBidID++;
  }

  Template getContractTemplate(int templateID) {
    for (int i = 0; i < consumerContractTemplates.templates.length; i++) {
      if (consumerContractTemplates.templates[i].id == templateID) {
        return consumerContractTemplates.templates[i];
      }
    }
    for (int i = 0; i < supplierContractTemplates.templates.length; i++) {
      if (supplierContractTemplates.templates[i].id == templateID) {
        return supplierContractTemplates.templates[i];
      }
    }
    return null;
  }

  // NOTIFICATIONS

  Container getListTile(Inbox item, String auctionTitle, BuildContext context) {
    Duration diff = DateTime.now().difference(item.time);
    String userName;
    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
      if (userHandler.userListObject.users[i].userId == item.userId) {
        userName = userHandler.userListObject.users[i].userName;
      }
    }
    if (item.offerId == null && item.status == "Pending") {
      bool isFull = false;
      for (int i = 0; i < myAuctions.materialAuctions.materialAuctions.length; i++) {
        if (myAuctions.materialAuctions.materialAuctions[i].id == item.auctionId) {
          if (myAuctions.materialAuctions.materialAuctions[i].maxParticipants <= myAuctions.materialAuctions.materialAuctions[i].currentParticipants) {
            isFull = true;
          }
          break;
        }
      }
      for (int i = 0; i < myAuctions.referencetype2Auctions.referencetype2Auctions.length; i++) {
        if (myAuctions.referencetype2Auctions.referencetype2Auctions[i].id == item.auctionId) {
          if (myAuctions.referencetype2Auctions.referencetype2Auctions[i].maxParticipants <=
              myAuctions.referencetype2Auctions.referencetype2Auctions[i].currentParticipants) {
            isFull = true;
          }
          break;
        }
      }
      // Accept/Decline someone to join your auction
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                Text(diff.inMinutes < 60
                    ? diff.inMinutes.toString() + " minutes ago"
                    : (diff.inHours < 24 ? diff.inHours.toString() + " hours ago" : diff.inDays.toString() + " days ago")),
                Text(userName + " has requested to join your auction titled: "),
                Text(auctionTitle),
                ElevatedButton(
                  child: Text(isFull ? "Auction is full" : "Accept"),
                  onPressed: isFull
                      ? null
                      : () {
                          // Add to auction details locally.
                          if (currentAuctionDetails.id == item.auctionId) {
                            currentAuctionDetails.participants.add(Participant(userId: item.userId));
                          }
                          // Add to auction details in "database".
                          if (userHandler.user.currentType == "Consumer") {
                            for (int i = 0; i < consumerAuctionDetails.auctionDetailsList.length; i++) {
                              if (consumerAuctionDetails.auctionDetailsList[i].id == item.auctionId) {
                                consumerAuctionDetails.auctionDetailsList[i].participants.add(Participant(userId: item.userId));
                                setConsumerAuctionDetails(auctionDetailsListToJson(consumerAuctionDetails));
                              }
                            }
                          }
                          if (userHandler.user.currentType == "Supplier") {
                            for (int i = 0; i < supplierAuctionDetails.auctionDetailsList.length; i++) {
                              if (supplierAuctionDetails.auctionDetailsList[i].id == item.auctionId) {
                                supplierAuctionDetails.auctionDetailsList[i].participants.add(Participant(userId: item.userId));
                                setConsumerAuctionDetails(auctionDetailsListToJson(supplierAuctionDetails));
                              }
                            }
                          }
                          for (int i = 0; i < userHandler.userListObject.users.length; i++) {
                            if (userHandler.userListObject.users[i].userId == item.userId) {
                              // Remove "sent" notification from senders inbox.
                              for (int y = 0; y < userHandler.userListObject.users[i].requestInbox.length; y++) {
                                if (userHandler.userListObject.users[i].requestInbox[y].auctionId == item.auctionId &&
                                    userHandler.userListObject.users[i].requestInbox[y].userId == userHandler.user.userId) {
                                  userHandler.userListObject.users[i].requestInbox.removeAt(y);
                                }
                              }
                              // Add "accepted" notification to senders inbox.
                              userHandler.userListObject.users[i].requestInbox.add(
                                new Inbox(
                                  time: new DateTime.now(),
                                  status: "Accepted",
                                  auctionId: item.auctionId,
                                  userId: userHandler.user.userId,
                                  offerId: null,
                                ),
                              );
                              // Add the auction ID to the senders participatingAuctions.
                              userHandler.userListObject.users[i].participatingAuctions.add(
                                new ParticipatingAuction(
                                  auctionId: item.auctionId,
                                ),
                              );
                            }
                            // Remove the notification from the users inbox.
                            if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
                              userHandler.userListObject.users[i].requestInbox.remove(item);
                            }
                          }
                          // Remove the notification from the users inbox locally.
                          userHandler.user.requestInbox.remove(item);
                          // Update "database".
                          setUsers(userListToJson(userHandler.userListObject));
                          Navigator.of(context).pop();
                          setMainState("Auction");
                        },
                ),
                ElevatedButton(
                  child: Text("Decline"),
                  onPressed: () {
                    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
                      if (userHandler.userListObject.users[i].userId == item.userId) {
                        for (int y = 0; y < userHandler.userListObject.users[i].requestInbox.length; y++) {
                          if (userHandler.userListObject.users[i].requestInbox[y].auctionId == item.auctionId &&
                              userHandler.userListObject.users[i].requestInbox[y].userId == userHandler.user.userId) {
                            userHandler.userListObject.users[i].requestInbox.removeAt(y);
                          }
                        }
                        userHandler.userListObject.users[i].requestInbox.add(
                          new Inbox(
                            time: new DateTime.now(),
                            status: "Declined",
                            auctionId: item.auctionId,
                            userId: userHandler.user.userId,
                            offerId: null,
                          ),
                        );
                      }
                      if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
                        userHandler.userListObject.users[i].requestInbox.remove(item);
                      }
                    }
                    userHandler.user.requestInbox.remove(item);
                    setUsers(userListToJson(userHandler.userListObject));
                    Navigator.of(context).pop();
                    setMainState("Auction");
                  },
                ),
              ],
            ),
            Container(
              height: 8,
            ),
          ],
        ),
      );
    } else if (item.offerId == null && item.status == "Declined") {
      // Remove notification when "Declined" to join auction
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                Text(diff.inMinutes < 60
                    ? diff.inMinutes.toString() + " minutes ago"
                    : (diff.inHours < 24 ? diff.inHours.toString() + " hours ago" : diff.inDays.toString() + " days ago")),
                Text(userName + " has declined you to join the auction titled: "),
                Text(auctionTitle),
                ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
                      if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
                        userHandler.userListObject.users[i].requestInbox.remove(item);
                      }
                    }
                    userHandler.user.requestInbox.remove(item);
                    setUsers(userListToJson(userHandler.userListObject));
                    Navigator.of(context).pop();
                    setMainState("Auction");
                  },
                ),
              ],
            ),
            Container(
              height: 8,
            ),
          ],
        ),
      );
    } else if (item.offerId == null && item.status == "Accepted") {
      // Remove notification when "Accepted" to join auction
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                Text(diff.inMinutes < 60
                    ? diff.inMinutes.toString() + " minutes ago"
                    : (diff.inHours < 24 ? diff.inHours.toString() + " hours ago" : diff.inDays.toString() + " days ago")),
                Text(userName + " has accepted your request to join the auction titled: "),
                Text(auctionTitle),
                ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
                      if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
                        userHandler.userListObject.users[i].requestInbox.remove(item);
                      }
                    }
                    userHandler.user.requestInbox.remove(item);
                    setUsers(userListToJson(userHandler.userListObject));
                    Navigator.of(context).pop();
                    setMainState("Auction");
                  },
                ),
              ],
            ),
            Container(
              height: 8,
            ),
          ],
        ),
      );
    } else if (item.offerId == null && item.status == "Sent") {
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                Text(diff.inMinutes < 60
                    ? diff.inMinutes.toString() + " minutes ago"
                    : (diff.inHours < 24 ? diff.inHours.toString() + " hours ago" : diff.inDays.toString() + " days ago")),
                Text("Your request to join the auction titled: "),
                Text(auctionTitle),
                Text("is still pending."),
                ElevatedButton(
                  child: Text("Unsend request"),
                  onPressed: () {
                    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
                      if (userHandler.userListObject.users[i].userId == item.userId) {
                        for (int y = 0; y < userHandler.userListObject.users[i].requestInbox.length; y++) {
                          if (userHandler.userListObject.users[i].requestInbox[y].auctionId == item.auctionId &&
                              userHandler.userListObject.users[i].requestInbox[y].userId == userHandler.user.userId) {
                            userHandler.userListObject.users[i].requestInbox.removeAt(y);
                          }
                        }
                      }
                      if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
                        userHandler.userListObject.users[i].requestInbox.remove(item);
                      }
                    }
                    userHandler.user.requestInbox.remove(item);
                    setUsers(userListToJson(userHandler.userListObject));
                    Navigator.of(context).pop();
                    setMainState("Auction");
                  },
                ),
              ],
            ),
            Container(
              height: 8,
            ),
          ],
        ),
      );
    } else if (item.offerId != null && item.status == "Pending") {
      bool isFull = false;
      for (int i = 0; i < allAuctions.materialAuctions.materialAuctions.length; i++) {
        if (allAuctions.materialAuctions.materialAuctions[i].id == item.auctionId) {
          if (allAuctions.materialAuctions.materialAuctions[i].maxParticipants <= allAuctions.materialAuctions.materialAuctions[i].currentParticipants) {
            isFull = true;
          }
          break;
        }
      }
      for (int i = 0; i < allAuctions.referencetype2Auctions.referencetype2Auctions.length; i++) {
        if (allAuctions.referencetype2Auctions.referencetype2Auctions[i].id == item.auctionId) {
          if (allAuctions.referencetype2Auctions.referencetype2Auctions[i].maxParticipants <=
              allAuctions.referencetype2Auctions.referencetype2Auctions[i].currentParticipants) {
            isFull = true;
          }
          break;
        }
      }
      // Accept/Decline invite to join someones auction
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                Text(diff.inMinutes < 60
                    ? diff.inMinutes.toString() + " minutes ago"
                    : (diff.inHours < 24 ? diff.inHours.toString() + " hours ago" : diff.inDays.toString() + " days ago")),
                Text(userName + " has invited you to an auction titled: "),
                Text(auctionTitle),
                ElevatedButton(
                  child: Text(isFull ? "Auction is full" : "Accept invitation"),
                  onPressed: isFull
                      ? null
                      : () {
                          //Add to myAuctions.
                          bool added = false;
                          for (int i = 0; i < allAuctions.materialAuctions.materialAuctions.length; i++) {
                            if (allAuctions.materialAuctions.materialAuctions[i].id == item.auctionId) {
                              myAuctions.materialAuctions.materialAuctions.add(allAuctions.materialAuctions.materialAuctions[i]);
                              added = true;
                              break;
                            }
                          }
                          if (!added) {
                            for (int i = 0; i < allAuctions.referencetype2Auctions.referencetype2Auctions.length; i++) {
                              if (allAuctions.referencetype2Auctions.referencetype2Auctions[i].id == item.auctionId) {
                                myAuctions.referencetype2Auctions.referencetype2Auctions.add(allAuctions.referencetype2Auctions.referencetype2Auctions[i]);
                                added = true;
                                break;
                              }
                            }
                          }
                          // Add to auction details in "database".
                          if (userHandler.user.currentType == "Consumer") {
                            for (int i = 0; i < supplierAuctionDetails.auctionDetailsList.length; i++) {
                              if (supplierAuctionDetails.auctionDetailsList[i].id == item.auctionId) {
                                supplierAuctionDetails.auctionDetailsList[i].participants.add(Participant(userId: userHandler.user.userId));
                                setConsumerAuctionDetails(auctionDetailsListToJson(supplierAuctionDetails));
                              }
                            }
                          }
                          if (userHandler.user.currentType == "Supplier") {
                            for (int i = 0; i < consumerAuctionDetails.auctionDetailsList.length; i++) {
                              if (consumerAuctionDetails.auctionDetailsList[i].id == item.auctionId) {
                                consumerAuctionDetails.auctionDetailsList[i].participants.add(Participant(userId: userHandler.user.userId));
                                setConsumerAuctionDetails(auctionDetailsListToJson(consumerAuctionDetails));
                              }
                            }
                          }
                          for (int i = 0; i < userHandler.userListObject.users.length; i++) {
                            if (userHandler.userListObject.users[i].userId == item.userId) {
                              for (int y = 0; y < userHandler.userListObject.users[i].inviteInbox.length; y++) {
                                if (userHandler.userListObject.users[i].inviteInbox[y].auctionId == item.auctionId &&
                                    userHandler.userListObject.users[i].inviteInbox[y].userId == userHandler.user.userId) {
                                  userHandler.userListObject.users[i].inviteInbox.removeAt(y);
                                }
                              }
                              userHandler.userListObject.users[i].inviteInbox.add(
                                new Inbox(
                                  time: new DateTime.now(),
                                  status: "Accepted",
                                  auctionId: item.auctionId,
                                  userId: userHandler.user.userId,
                                  offerId: item.offerId,
                                ),
                              );
                            }
                            if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
                              userHandler.userListObject.users[i].inviteInbox.remove(item);
                              userHandler.userListObject.users[i].participatingAuctions.add(
                                new ParticipatingAuction(
                                  auctionId: item.auctionId,
                                ),
                              );
                            }
                          }
                          userHandler.user.participatingAuctions.add(
                            //Might be adding twice?
                            new ParticipatingAuction(
                              auctionId: item.auctionId,
                            ),
                          );
                          userHandler.user.inviteInbox.remove(item);
                          setUsers(userListToJson(userHandler.userListObject));
                          Navigator.of(context).pop();
                          setMainState("Auction");
                        },
                ),
                ElevatedButton(
                  child: Text("Decline invitation"),
                  onPressed: () {
                    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
                      if (userHandler.userListObject.users[i].userId == item.userId) {
                        for (int y = 0; y < userHandler.userListObject.users[i].inviteInbox.length; y++) {
                          if (userHandler.userListObject.users[i].inviteInbox[y].auctionId == item.auctionId &&
                              userHandler.userListObject.users[i].inviteInbox[y].userId == userHandler.user.userId) {
                            userHandler.userListObject.users[i].inviteInbox.removeAt(y);
                          }
                        }
                        userHandler.userListObject.users[i].inviteInbox.add(
                          new Inbox(
                            time: new DateTime.now(),
                            status: "Declined",
                            auctionId: item.auctionId,
                            userId: userHandler.user.userId,
                            offerId: item.offerId,
                          ),
                        );
                      }
                      if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
                        userHandler.userListObject.users[i].inviteInbox.remove(item);
                      }
                    }
                    userHandler.user.inviteInbox.remove(item);
                    setUsers(userListToJson(userHandler.userListObject));
                    Navigator.of(context).pop();
                    setMainState("Auction");
                  },
                ),
              ],
            ),
            Container(
              height: 8,
            ),
          ],
        ),
      );
    } else if (item.offerId != null && item.status == "Declined") {
      // Remove notis when invited user "Declined" to join your auction
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                Text(diff.inMinutes < 60
                    ? diff.inMinutes.toString() + " minutes ago"
                    : (diff.inHours < 24 ? diff.inHours.toString() + " hours ago" : diff.inDays.toString() + " days ago")),
                Text(userName + " has declined your invitation to your auction titled: "),
                Text(auctionTitle),
                ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
                      if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
                        userHandler.userListObject.users[i].inviteInbox.remove(item);
                      }
                    }
                    userHandler.user.inviteInbox.remove(item);
                    setUsers(userListToJson(userHandler.userListObject));
                    Navigator.of(context).pop();
                    setMainState("Auction");
                  },
                ),
              ],
            ),
            Container(
              height: 8,
            ),
          ],
        ),
      );
    } else if (item.offerId != null && item.status == "Accepted") {
      // Remove notis when invited user "Accepted" to join auction
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                Text(diff.inMinutes < 60
                    ? diff.inMinutes.toString() + " minutes ago"
                    : (diff.inHours < 24 ? diff.inHours.toString() + " hours ago" : diff.inDays.toString() + " days ago")),
                Text(userName + " has accepted your invitation to your auction titled: "),
                Text(auctionTitle),
                ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
                      if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
                        userHandler.userListObject.users[i].inviteInbox.remove(item);
                      }
                    }
                    userHandler.user.inviteInbox.remove(item);
                    setUsers(userListToJson(userHandler.userListObject));
                    Navigator.of(context).pop();
                    setMainState("Auction");
                  },
                ),
              ],
            ),
            Container(
              height: 8,
            ),
          ],
        ),
      );
    } else if (item.offerId != null && item.status == "Sent") {
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                Text(diff.inMinutes < 60
                    ? diff.inMinutes.toString() + " minutes ago"
                    : (diff.inHours < 24 ? diff.inHours.toString() + " hours ago" : diff.inDays.toString() + " days ago")),
                Text("Your invite for " + userName + " to join the auction titled: "),
                Text(auctionTitle),
                Text("is still pending."),
                ElevatedButton(
                  child: Text("Unsend invite"),
                  onPressed: () {
                    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
                      if (userHandler.userListObject.users[i].userId == item.userId) {
                        for (int y = 0; y < userHandler.userListObject.users[i].inviteInbox.length; y++) {
                          if (userHandler.userListObject.users[i].inviteInbox[y].auctionId == item.auctionId &&
                              userHandler.userListObject.users[i].inviteInbox[y].userId == userHandler.user.userId) {
                            userHandler.userListObject.users[i].inviteInbox.removeAt(y);
                          }
                        }
                      }
                      if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
                        userHandler.userListObject.users[i].inviteInbox.remove(item);
                      }
                    }
                    userHandler.user.inviteInbox.remove(item);
                    setUsers(userListToJson(userHandler.userListObject));
                    Navigator.of(context).pop();
                    setMainState("Auction");
                  },
                ),
              ],
            ),
            Container(
              height: 8,
            ),
          ],
        ),
      );
    }
    return Container(
      child: Text("Something went wrong when checking inbox. Maybe Pending, Declined or Accepted is spelled incorrectly?"),
    );
  }

  void showNotifications(BuildContext context, List<Inbox> list, String auctionTitle) {
    if (list == null && auctionTitle == null) {
      list = inbox;
    }
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
            width: MediaQuery.of(context).size.width * 0.2,
            margin: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 6.0,
                  ),
                  margin: EdgeInsets.only(top: 13.0, right: 8.0),
                  decoration: BoxDecoration(
                    color: themeData.primaryColor,
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
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          /*
                          ====================
                          Notifications are listed below
                          ====================
                          */
                          child: Column(
                            children: [
                              Text('Notifications', style: themeData.textTheme.headline4),
                              Container(height: 16),
                              Container(
                                width: 400,
                                height: 200,
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    return Scrollbar(
                                      child: ListView.builder(
                                        itemCount: list.length,
                                        itemBuilder: (context, index) {
                                          return getListTile(list[index], auctionTitle != null ? auctionTitle : inboxAuctionTitles[index], context);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /*
                ====================
                Exitbutton
                ====================
                */
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
