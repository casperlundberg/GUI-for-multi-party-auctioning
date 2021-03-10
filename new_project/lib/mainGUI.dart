import 'package:flutter/material.dart';
//import 'package:flutter/services.dart' show rootBundle;
import 'package:new_project/Handlers/auctionHandler.dart';
import 'package:new_project/Handlers/filterHandler.dart';
import 'package:new_project/Handlers/offerHandler.dart';
//import 'package:http/http.dart' as http;
//import 'package:flutter/foundation.dart';

//import 'dart:html';
//import 'dart:async' show Future;

import 'Navigation/navbar.dart';
import 'Pages/room.dart';
import 'Entities/filtersJSON.dart';
import 'Entities/auctionDetailsListJSON.dart';
import 'Entities/userListJSON.dart';
import 'Entities/materialAuctionListJSON.dart';
import 'Entities/materialOfferListJSON.dart';
import 'Entities/referencetype2AuctionListJSON.dart';
import 'Entities/referencetype2OfferListJSON.dart';
import 'Entities/templateListJSON.dart';
import 'Pages/auctionsGUI.dart';
import 'Pages/forgotPass.dart';
import 'Pages/login.dart';
import 'Pages/profile.dart';
import 'Pages/register.dart';
import 'jsonUtilities.dart';
import 'Handlers/userInfoHandler.dart';

//Inspired by Widget Switch Demo, by GitHub user TechieBlossom
//https://github.com/TechieBlossom/flutter-samples/blob/master/widgetswitchdemo.dart

enum WidgetMarker { auctions, login, register, profile, forgotPass, room }

class MainGUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainGUIState();
}

class MainGUIState extends State<MainGUI> with SingleTickerProviderStateMixin<MainGUI> {
  WidgetMarker selectedWidgetMarker;
  AnimationController controller;
  Animation animation;

  UserInfoHandler userHandler;
  FilterHandler filterHandler;
  AuctionHandler auctionHandler;
  OfferHandler offerHandler;

  int nextAuctionID;
  int nextBidID;
  int nextTemplateID;
  int nextOfferID;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    selectedWidgetMarker = WidgetMarker.login;

    userHandler = new UserInfoHandler(updateUser);
    filterHandler = new FilterHandler(setMainState);

    // INITIALIZE BID ID
    AuctionDetailsList consumerAuctionDetails = auctionDetailsListFromJson(getConsumerAuctionDetails());
    AuctionDetailsList supplierAuctionDetails = auctionDetailsListFromJson(getSupplierAuctionDetails());
    nextBidID = 1;
    for (int i = 0; i < consumerAuctionDetails.auctionDetailsList.length; i++) {
      for (int y = 0; y < consumerAuctionDetails.auctionDetailsList[i].bids.length; y++) {
        if (nextBidID <= consumerAuctionDetails.auctionDetailsList[i].bids[y].id) {
          nextBidID = consumerAuctionDetails.auctionDetailsList[i].bids[y].id + 1;
        }
      }
    }
    for (int i = 0; i < supplierAuctionDetails.auctionDetailsList.length; i++) {
      for (int y = 0; y < supplierAuctionDetails.auctionDetailsList[i].bids.length; y++) {
        if (nextBidID <= supplierAuctionDetails.auctionDetailsList[i].bids[y].id) {
          nextBidID = supplierAuctionDetails.auctionDetailsList[i].bids[y].id + 1;
        }
      }
    }

    // INITIALIZE TEMPLATE ID
    TemplateList consumerContractTemplates = templateListFromJson(getConsumerContractTemplates());
    TemplateList supplierContractTemplates = templateListFromJson(getSupplierContractTemplates());
    TemplateList consumerOfferTemplates = templateListFromJson(getConsumerOfferTemplates());
    TemplateList supplierOfferTemplates = templateListFromJson(getSupplierOfferTemplates());
    nextTemplateID = 1;
    for (int i = 0; i < consumerContractTemplates.templates.length; i++) {
      if (nextTemplateID <= consumerContractTemplates.templates[i].id) {
        nextTemplateID = consumerContractTemplates.templates[i].id + 1;
      }
    }
    for (int i = 0; i < supplierContractTemplates.templates.length; i++) {
      if (nextTemplateID <= supplierContractTemplates.templates[i].id) {
        nextTemplateID = supplierContractTemplates.templates[i].id + 1;
      }
    }
    for (int i = 0; i < consumerOfferTemplates.templates.length; i++) {
      if (nextTemplateID <= consumerOfferTemplates.templates[i].id) {
        nextTemplateID = consumerOfferTemplates.templates[i].id + 1;
      }
    }
    for (int i = 0; i < supplierOfferTemplates.templates.length; i++) {
      if (nextTemplateID <= supplierOfferTemplates.templates[i].id) {
        nextTemplateID = supplierOfferTemplates.templates[i].id + 1;
      }
    }

    // INITIALIZE AUCTION ID
    MaterialAuctionList consumerMaterialAuctions = materialAuctionListFromJson(getConsumerMaterialAuctions());
    MaterialAuctionList supplierMaterialAuctions = materialAuctionListFromJson(getSupplierMaterialAuctions());
    Referencetype2AuctionList consumerReferencetype2Auctions = referencetype2AuctionListFromJson(getConsumerReferencetype2Auctions());
    Referencetype2AuctionList supplierReferencetype2Auctions = referencetype2AuctionListFromJson(getSupplierReferencetype2Auctions());
    nextAuctionID = 1;
    for (int i = 0; i < consumerMaterialAuctions.materialAuctions.length; i++) {
      if (nextAuctionID <= consumerMaterialAuctions.materialAuctions[i].id) {
        nextAuctionID = consumerMaterialAuctions.materialAuctions[i].id + 1;
      }
    }
    for (int i = 0; i < supplierMaterialAuctions.materialAuctions.length; i++) {
      if (nextAuctionID <= supplierMaterialAuctions.materialAuctions[i].id) {
        nextAuctionID = supplierMaterialAuctions.materialAuctions[i].id + 1;
      }
    }
    for (int i = 0; i < consumerReferencetype2Auctions.referencetype2Auctions.length; i++) {
      if (nextAuctionID <= consumerReferencetype2Auctions.referencetype2Auctions[i].id) {
        nextAuctionID = consumerReferencetype2Auctions.referencetype2Auctions[i].id + 1;
      }
    }
    for (int i = 0; i < supplierReferencetype2Auctions.referencetype2Auctions.length; i++) {
      if (nextAuctionID <= supplierReferencetype2Auctions.referencetype2Auctions[i].id) {
        nextAuctionID = supplierReferencetype2Auctions.referencetype2Auctions[i].id + 1;
      }
    }

    // INITIALIZE OFFER ID
    MaterialOfferList consumerMaterialOffers = materialOfferListFromJson(getConsumerMaterialOffers());
    MaterialOfferList supplierMaterialOffers = materialOfferListFromJson(getSupplierMaterialOffers());
    Referencetype2OfferList consumerReferencetype2Offers = referencetype2OfferListFromJson(getConsumerReferencetype2Offers());
    Referencetype2OfferList supplierReferencetype2Offers = referencetype2OfferListFromJson(getSupplierReferencetype2Offers());
    nextOfferID = 1;
    for (int i = 0; i < consumerMaterialOffers.materialOffers.length; i++) {
      if (nextOfferID <= consumerMaterialOffers.materialOffers[i].id) {
        nextOfferID = consumerMaterialOffers.materialOffers[i].id + 1;
      }
    }
    for (int i = 0; i < supplierMaterialOffers.materialOffers.length; i++) {
      if (nextOfferID <= supplierMaterialOffers.materialOffers[i].id) {
        nextOfferID = supplierMaterialOffers.materialOffers[i].id + 1;
      }
    }
    for (int i = 0; i < consumerReferencetype2Offers.referencetype2Offers.length; i++) {
      if (nextOfferID <= consumerReferencetype2Offers.referencetype2Offers[i].id) {
        nextOfferID = consumerReferencetype2Offers.referencetype2Offers[i].id + 1;
      }
    }
    for (int i = 0; i < supplierReferencetype2Offers.referencetype2Offers.length; i++) {
      if (nextOfferID <= supplierReferencetype2Offers.referencetype2Offers[i].id) {
        nextOfferID = supplierReferencetype2Offers.referencetype2Offers[i].id + 1;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedWidgetMarker == WidgetMarker.login || selectedWidgetMarker == WidgetMarker.register || selectedWidgetMarker == WidgetMarker.forgotPass) {
      return new Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            //Source: https://www.pexels.com/photo/iphone-notebook-pen-working-34088/
            image: AssetImage("../../images/dark/main-BG-dark.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder(
            future: playAnimation(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return getCustomContainer();
            },
          ),
        ),
      );
    }
    return new Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          //Source: https://www.pexels.com/photo/iphone-notebook-pen-working-34088/
          image: AssetImage("../../images/dark/main-BG-dark.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: NavigationBar(navigate, auctionHandler.showContractTemplateGUI, userHandler),
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: playAnimation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return getCustomContainer();
          },
        ),
      ),
    );
  }

  playAnimation() {
    controller.reset();
    controller.forward();
  }

  // Used to update page and userhandler with correct information.
  void setMainState(String handler) {
    setState(() {
      if (handler == "Auction") {
        userHandler = auctionHandler.userHandler;
      }
      if (handler == "Offer") {
        userHandler = offerHandler.userHandler;
      }
    });
  }

  // Used whenever the user or the user's current usertype potentially changes.
  void updateUser() {
    setState(() {
      if (auctionHandler == null && offerHandler == null) {
        auctionHandler = new AuctionHandler(setMainState, userHandler, nextAuctionID, nextBidID, nextTemplateID);
        offerHandler = new OfferHandler(setMainState, userHandler, nextOfferID);
      } else {
        auctionHandler = new AuctionHandler(setMainState, userHandler, auctionHandler.nextAuctionID, auctionHandler.nextBidID, auctionHandler.nextTemplateID);
        offerHandler = new OfferHandler(setMainState, userHandler, offerHandler.nextOfferID);
      }
    });
  }

  //NAVIGATION METHODS

  void navigate(WidgetMarker page) {
    switch (page) {
      case WidgetMarker.auctions:
        setState(() {
          //Load new filters, auctions and offers.
          filterHandler.retrieveFilters();
          auctionHandler = new AuctionHandler(setMainState, userHandler, auctionHandler.nextAuctionID, auctionHandler.nextBidID, auctionHandler.nextTemplateID);
          offerHandler = new OfferHandler(setMainState, userHandler, offerHandler.nextOfferID);
          selectedWidgetMarker = WidgetMarker.auctions;
        });
        return;
      case WidgetMarker.login:
        setState(() {
          //Load new users.
          userHandler = new UserInfoHandler(updateUser);
          selectedWidgetMarker = WidgetMarker.login;
        });
        return;
      case WidgetMarker.profile:
        setState(() {
          selectedWidgetMarker = WidgetMarker.profile;
        });
        return;
      case WidgetMarker.register:
        setState(() {
          selectedWidgetMarker = WidgetMarker.register;
        });
        return;
      case WidgetMarker.forgotPass:
        setState(() {
          selectedWidgetMarker = WidgetMarker.forgotPass;
        });
        return;
      case WidgetMarker.room:
        setState(() {
          selectedWidgetMarker = WidgetMarker.room;
        });
    }
  }

  Widget getCustomContainer() {
    switch (selectedWidgetMarker) {
      case WidgetMarker.auctions:
        return getAuctionsGUIContainer();
      case WidgetMarker.login:
        return getLoginContainer();
      case WidgetMarker.profile:
        return getProfileContainer();
      case WidgetMarker.register:
        return getRegisterContainer();
      case WidgetMarker.forgotPass:
        return getForgotPassContainer();
      case WidgetMarker.room:
        return getRoomContainer();
    }
    return getLoginContainer();
  }

  Widget getAuctionsGUIContainer() {
    return FadeTransition(
      opacity: animation,
      child: AuctionsGUI(navigate, filterHandler, auctionHandler, offerHandler, userHandler),
    );
  }

  Widget getLoginContainer() {
    return FadeTransition(
      opacity: animation,
      child: LoginScreen(navigate, userHandler),
    );
  }

  Widget getRegisterContainer() {
    return FadeTransition(
      opacity: animation,
      child: RegisterScreen(navigate, userHandler),
    );
  }

  Widget getForgotPassContainer() {
    return FadeTransition(
      opacity: animation,
      child: ForgotPasswordScreen(navigate),
    );
  }

  Widget getProfileContainer() {
    return FadeTransition(
      opacity: animation,
      child: ProfileGUI(navigate, userHandler),
    );
  }

  Widget getRoomContainer() {
    return FadeTransition(
      opacity: animation,
      child: Room(navigate, auctionHandler),
    );
  }
}
