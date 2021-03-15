import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Entities/templateListJSON.dart';
import '../Entities/userListJSON.dart';
import 'userInfoHandler.dart';
import '../jsonUtilities.dart';
import '../Entities/materialOfferListJSON.dart';
import '../Entities/referencetype2OfferListJSON.dart';
import '../Entities/materialAuctionListJSON.dart';
import '../Entities/referencetype2AuctionListJSON.dart';
import '../Entities/auctionDetailsListJSON.dart';

class Offers {
  MaterialOfferList materialOffers;
  Referencetype2OfferList referencetype2Offers;

  Offers(this.materialOffers, this.referencetype2Offers);
}

class OfferHandler {
  Function setMainState;
  Offers allOffers; //NOT STORED LOCALLY
  Offers myOffers; //STORED LOCALLY
  TemplateList consumerOfferTemplates; //NOT STORED LOCALLY
  TemplateList supplierOfferTemplates; //NOT STORED LOCALLY
  UserInfoHandler userHandler; //STORED LOCALLY
  int nextOfferID;

  OfferHandler(this.setMainState, this.userHandler, this.nextOfferID) {
    consumerOfferTemplates = templateListFromJson(getConsumerOfferTemplates());
    supplierOfferTemplates = templateListFromJson(getSupplierOfferTemplates());
    allOffers = new Offers(new MaterialOfferList(materialOffers: []), new Referencetype2OfferList(referencetype2Offers: []));
    myOffers = new Offers(new MaterialOfferList(materialOffers: []), new Referencetype2OfferList(referencetype2Offers: []));
    MaterialOfferList m;
    Referencetype2OfferList r;
    if (userHandler.user.currentType == "Consumer") {
      allOffers.materialOffers = materialOfferListFromJson(getSupplierMaterialOffers());
      m = materialOfferListFromJson(getConsumerMaterialOffers());
      allOffers.referencetype2Offers = referencetype2OfferListFromJson(getSupplierReferencetype2Offers());
      r = referencetype2OfferListFromJson(getConsumerReferencetype2Offers());
    } else {
      allOffers.materialOffers = materialOfferListFromJson(getConsumerMaterialOffers());
      m = materialOfferListFromJson(getSupplierMaterialOffers());
      allOffers.referencetype2Offers = referencetype2OfferListFromJson(getConsumerReferencetype2Offers());
      r = referencetype2OfferListFromJson(getSupplierReferencetype2Offers());
    }
    // GET MYOFFERS
    if (userHandler.user.offers.length != 0) {
      for (int i = 0; i < userHandler.user.offers.length; i++) {
        bool added = false;
        for (int y = 0; y < m.materialOffers.length; y++) {
          if (userHandler.user.offers[i].offerId == m.materialOffers[y].id) {
            myOffers.materialOffers.materialOffers.add(m.materialOffers[y]);
            added = true;
            break;
          }
        }
        if (added) {
          continue;
        }
        for (int y = 0; y < r.referencetype2Offers.length; y++) {
          if (userHandler.user.offers[i].offerId == r.referencetype2Offers[y].id) {
            myOffers.referencetype2Offers.referencetype2Offers.add(r.referencetype2Offers[y]);
            break;
          }
        }
      }
    }
  }

  void createMaterialOffer(int templateID, String title, List<KeyValuePair> keyValuePairs, int duration, String fibersType, String resinType,
      String recyclingTechnology, String sizing, String additives, int minFiberLength, int maxFiberLength, int minVolume, int maxVolume) {
    DateTime startDate = new DateTime.now();
    DateTime stopDate = startDate.add(Duration(minutes: (duration)));

    MaterialOffer newMaterialOffer = new MaterialOffer(
        id: nextOfferID,
        title: title,
        userId: userHandler.user.userId,
        templateId: templateID,
        keyValuePairs: keyValuePairs,
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
      MaterialOfferList m = materialOfferListFromJson(getConsumerMaterialOffers());
      m.materialOffers.add(newMaterialOffer);
      setConsumerMaterialOffers(materialOfferListToJson(m));
    } else {
      MaterialOfferList m = materialOfferListFromJson(getSupplierMaterialOffers());
      m.materialOffers.add(newMaterialOffer);
      setSupplierMaterialOffers(materialOfferListToJson(m));
    }
    // Add to myOffers.
    myOffers.materialOffers.materialOffers.add(newMaterialOffer);
    // Add to user's offers.
    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
      if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
        userHandler.userListObject.users[i].offers.add(new Offer(offerId: nextOfferID));
        break;
      }
    }
    setUsers(userListToJson(userHandler.userListObject));
    nextOfferID++;
    setMainState("Offer");
  }

  void createReferencetype2Offer(
      int templateID, String title, List<KeyValuePair> keyValuePairs, int duration, String parameter1, String parameter2, int minVolume, int maxVolume) {
    DateTime startDate = new DateTime.now();
    DateTime stopDate = startDate.add(Duration(minutes: (duration)));

    Referencetype2Offer newReferencetype2Offer = new Referencetype2Offer(
        id: nextOfferID,
        title: title,
        userId: userHandler.user.userId,
        templateId: templateID,
        keyValuePairs: keyValuePairs,
        startDate: startDate,
        stopDate: stopDate,
        referenceSector: "composites",
        referenceType: "referencetype2",
        referencetype2ReferenceParameters:
            new Referencetype2ReferenceParameters(parameter1: parameter1, parameter2: parameter2, minVolume: minVolume, maxVolume: maxVolume));

    // Add to "database".
    if (userHandler.user.currentType == "Consumer") {
      Referencetype2OfferList r = referencetype2OfferListFromJson(getConsumerReferencetype2Offers());
      r.referencetype2Offers.add(newReferencetype2Offer);
      setConsumerReferencetype2Offers(referencetype2OfferListToJson(r));
    } else {
      Referencetype2OfferList r = referencetype2OfferListFromJson(getSupplierReferencetype2Offers());
      r.referencetype2Offers.add(newReferencetype2Offer);
      setSupplierReferencetype2Offers(referencetype2OfferListToJson(r));
    }
    // Add to myOffers.
    myOffers.referencetype2Offers.referencetype2Offers.add(newReferencetype2Offer);
    // Add to user's offers.
    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
      if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
        userHandler.userListObject.users[i].offers.add(new Offer(offerId: nextOfferID));
        break;
      }
    }
    setUsers(userListToJson(userHandler.userListObject));
    nextOfferID++;
    setMainState("Offer");
  }

  void endOffer(int id) {
    // Remove from user's offers. ????????????????????????????????
    for (int i = 0; i < userHandler.user.offers.length; i++) {
      if (userHandler.user.offers[i].offerId == id) {
        userHandler.user.offers.removeAt(i);
      }
    }
    for (int i = 0; i < userHandler.userListObject.users.length; i++) {
      if (userHandler.userListObject.users[i].userId == userHandler.user.userId) {
        for (int y = 0; i < userHandler.userListObject.users[i].offers.length; i++) {
          if (userHandler.userListObject.users[i].offers[i].offerId == id) {
            userHandler.userListObject.users[i].offers.removeAt(y);
            break;
          }
        }
        break;
      }
    }
    setUsers(userListToJson(userHandler.userListObject));
    // Remove from myOffers.
    String type;
    for (int i = 0; i < myOffers.materialOffers.materialOffers.length; i++) {
      if (myOffers.materialOffers.materialOffers[i].id == id) {
        myOffers.materialOffers.materialOffers.removeAt(i);
        type = "material";
        break;
      }
    }
    for (int i = 0; i < myOffers.referencetype2Offers.referencetype2Offers.length; i++) {
      if (myOffers.referencetype2Offers.referencetype2Offers[i].id == id) {
        myOffers.referencetype2Offers.referencetype2Offers.removeAt(i);
        type = "referencetype2";
        break;
      }
    }
    // Remove from "database".
    if (type == "material") {
      for (int i = 0; i < allOffers.materialOffers.materialOffers.length; i++) {
        if (allOffers.materialOffers.materialOffers[i].id == id) {
          allOffers.materialOffers.materialOffers.removeAt(i);
          if (userHandler.user.currentType == "Consumer") {
            setConsumerMaterialOffers(materialOfferListToJson(allOffers.materialOffers));
          } else {
            setSupplierMaterialOffers(materialOfferListToJson(allOffers.materialOffers));
          }
          break;
        }
      }
    }
    if (type == "referencetype2") {
      for (int i = 0; i < allOffers.referencetype2Offers.referencetype2Offers.length; i++) {
        if (allOffers.referencetype2Offers.referencetype2Offers[i].id == id) {
          allOffers.referencetype2Offers.referencetype2Offers.removeAt(i);
          if (userHandler.user.currentType == "Consumer") {
            setConsumerReferencetype2Offers(referencetype2OfferListToJson(allOffers.referencetype2Offers));
          } else {
            setSupplierReferencetype2Offers(referencetype2OfferListToJson(allOffers.referencetype2Offers));
          }
          break;
        }
      }
    }
    setMainState("Offer");
  }

  void viewOffer(int templateID, List<KeyValuePair> keyValuePairs, BuildContext context) {
    Template template;
    for (int i = 0; i < consumerOfferTemplates.templates.length; i++) {
      if (consumerOfferTemplates.templates[i].id == templateID) {
        template = consumerOfferTemplates.templates[i];
      }
    }
    for (int i = 0; i < supplierOfferTemplates.templates.length; i++) {
      if (supplierOfferTemplates.templates[i].id == templateID) {
        template = supplierOfferTemplates.templates[i];
      }
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
                                    "Offer",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 2,
                                  ),
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
