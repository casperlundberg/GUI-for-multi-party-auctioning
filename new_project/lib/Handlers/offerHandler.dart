import '../Entities/templateListJSON.dart';
import '../Entities/userListJSON.dart';
import 'userInfoHandler.dart';
import '../jsonUtilities.dart';
import '../Entities/materialOfferListJSON.dart';
import '../Entities/referencetype2OfferListJSON.dart';
import '../Entities/materialAuctionListJSON.dart';
import '../Entities/referencetype2AuctionListJSON.dart';

class Offers {
  MaterialOfferList materialOffers;
  Referencetype2OfferList referencetype2Offers;

  Offers(this.materialOffers, this.referencetype2Offers);
}

class OfferHandler {
  Function setMainState;
  Offers allOffers; //NOT STORED LOCALLY
  Offers myOffers; //STORED LOCALLY
  TemplateList offerTemplates; //NOT STORED LOCALLY
  UserInfoHandler userHandler; //STORED LOCALLY
  int nextOfferID;

  OfferHandler(this.setMainState, this.userHandler, this.nextOfferID) {
    allOffers = new Offers(new MaterialOfferList(materialOffers: []), new Referencetype2OfferList(referencetype2Offers: []));
    myOffers = new Offers(new MaterialOfferList(materialOffers: []), new Referencetype2OfferList(referencetype2Offers: []));
    if (userHandler.user.currentType == "Consumer") {
      allOffers.materialOffers = materialOfferListFromJson(getConsumerMaterialOffers());
      allOffers.referencetype2Offers = referencetype2OfferListFromJson(getConsumerReferencetype2Offers());
      offerTemplates = templateListFromJson(getConsumerOfferTemplates());
    } else {
      allOffers.materialOffers = materialOfferListFromJson(getSupplierMaterialOffers());
      allOffers.referencetype2Offers = referencetype2OfferListFromJson(getSupplierReferencetype2Offers());
      offerTemplates = templateListFromJson(getSupplierOfferTemplates());
    }
    // GET MYOFFERS
    if (userHandler.user.offers.length != 0) {
      for (int i = 0; i < userHandler.user.offers.length; i++) {
        bool added = false;
        for (int y = 0; y < allOffers.materialOffers.materialOffers.length; y++) {
          if (userHandler.user.offers[i].offerId == allOffers.materialOffers.materialOffers[y].id) {
            myOffers.materialOffers.materialOffers.add(allOffers.materialOffers.materialOffers[y]);
            added = true;
            break;
          }
        }
        if (added) {
          continue;
        }
        for (int y = 0; y < allOffers.referencetype2Offers.referencetype2Offers.length; y++) {
          if (userHandler.user.offers[i].offerId == allOffers.referencetype2Offers.referencetype2Offers[y].id) {
            myOffers.referencetype2Offers.referencetype2Offers.add(allOffers.referencetype2Offers.referencetype2Offers[y]);
            break;
          }
        }
      }
    }
  }

  void createMaterialOffer(int templateID, String title, int duration, String fibersType, String resinType, String recyclingTechnology, String sizing,
      String additives, int minFiberLength, int maxFiberLength, int minVolume, int maxVolume) {
    DateTime startDate = new DateTime.now();
    DateTime stopDate = startDate.add(Duration(minutes: (duration)));

    MaterialOffer newMaterialOffer = new MaterialOffer(
        id: nextOfferID,
        title: title,
        userId: userHandler.user.userId,
        templateId: templateID,
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
    allOffers.materialOffers.materialOffers.add(newMaterialOffer);
    if (userHandler.user.currentType == "Consumer") {
      setConsumerMaterialOffers(materialOfferListToJson(allOffers.materialOffers));
    } else {
      setSupplierMaterialOffers(materialOfferListToJson(allOffers.materialOffers));
    }
    // Add to myOffers.
    myOffers.materialOffers.materialOffers.add(newMaterialOffer);
    // Add to user's offers.
    userHandler.user.offers.add(new Offer(offerId: nextOfferID));
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

  void createReferencetype2Offer(int templateID, String title, int duration, String parameter1, String parameter2, int minVolume, int maxVolume) {
    DateTime startDate = new DateTime.now();
    DateTime stopDate = startDate.add(Duration(minutes: (duration)));

    Referencetype2Offer newReferencetype2Offer = new Referencetype2Offer(
        id: nextOfferID,
        title: title,
        userId: userHandler.user.userId,
        templateId: templateID,
        startDate: startDate,
        stopDate: stopDate,
        referenceSector: "composites",
        referenceType: "referencetype2",
        referencetype2ReferenceParameters:
            new Referencetype2ReferenceParameters(parameter1: parameter1, parameter2: parameter2, minVolume: minVolume, maxVolume: maxVolume));

    // Add to "database".
    allOffers.referencetype2Offers.referencetype2Offers.add(newReferencetype2Offer);
    if (userHandler.user.currentType == "Consumer") {
      setConsumerReferencetype2Offers(referencetype2OfferListToJson(allOffers.referencetype2Offers));
    } else {
      setSupplierReferencetype2Offers(referencetype2OfferListToJson(allOffers.referencetype2Offers));
    }
    // Add to myOffers.
    myOffers.referencetype2Offers.referencetype2Offers.add(newReferencetype2Offer);
    // Add to user's offers.
    userHandler.user.offers.add(new Offer(offerId: nextOfferID));
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
    // Remove from user's offers.
    for (int i = 0; i < userHandler.user.offers.length; i++) {
      if (userHandler.user.offers[i].offerId == id) {
        userHandler.user.offers.removeAt(i);
      }
    }
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
}
