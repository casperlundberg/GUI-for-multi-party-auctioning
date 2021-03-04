import 'package:flutter/material.dart';
//import 'package:flutter/services.dart' show rootBundle;
import 'package:new_project/Handlers/auctionHandler.dart';
import 'package:new_project/Handlers/filterHandler.dart';
//import 'package:http/http.dart' as http;
//import 'package:flutter/foundation.dart';

//import 'dart:html';
//import 'dart:async' show Future;

import 'Navigation/navbar.dart';
import 'Pages/room.dart';
import 'Entities/filtersJSON.dart';
import 'Entities/auctionListJSON.dart';
import 'Entities/auctionDetailsListJSON.dart';
import 'Entities/contractTemplatesJSON.dart';
import 'Pages/auctionsGUI.dart';
import 'Pages/forgotPass.dart';
import 'Pages/login.dart';
import 'Pages/profile.dart';
import 'Pages/register.dart';
import 'jsonUtilities.dart';
import 'Entities/userList.dart';
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

  FilterHandler filterHandler;
  AuctionHandler auctionHandler;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    selectedWidgetMarker = WidgetMarker.login;

    // USER VARIABLES
    UserList userListObject = userListFromJson(getUserListString());

    // FILTER VARIABLES
    Filters filters = filtersFromJson(getFilterListString());
    List<Filter> availableFilters = filters.filters;
    filterHandler = new FilterHandler(filters, availableFilters, [], [], 0);

    // AUCTION VARIABLES
    AuctionList allAuctions = auctionListFromJson(getAuctionsListString());
    AuctionDetailsList auctionDetailsList = auctionDetailsListFromJson(getAuctionDetailsListString());
    ContractTemplates supplierContractTemplates = contractTemplatesFromJson(getSupplierContractTemplatesString());
    ContractTemplates consumerContractTemplates = contractTemplatesFromJson(getConsumerContractTemplatesString());
    auctionHandler = new AuctionHandler(setMainState, allAuctions, auctionDetailsList, null, null, supplierContractTemplates, consumerContractTemplates,
        new UserInfoHandler(userToAuction, userListObject, new User()));
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
        appBar: NavigationBar(navigate, auctionHandler.showContractTemplateGUI),
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

  void setMainState() {
    setState(() {});
  }

  void userToAuction() {
    setState(() {
      if (auctionHandler.userHandler.user.participatingAuctions != null) {
        auctionHandler.myAuctions = new AuctionList(auctionList: []);
        for (int i = 0; i < auctionHandler.userHandler.user.participatingAuctions.length; i++) {
          for (int y = 0; y < auctionHandler.allAuctions.auctionList.length; y++) {
            if (auctionHandler.userHandler.user.participatingAuctions[i].auctionId == auctionHandler.allAuctions.auctionList[y].id) {
              auctionHandler.myAuctions.auctionList.add(auctionHandler.allAuctions.auctionList[y]);
            }
          }
        }
      }
    });
  }

  //NAVIGATION METHODS

  void navigate(WidgetMarker page) {
    switch (page) {
      case WidgetMarker.auctions:
        setState(() {
          filterHandler.retrieveFilters();
          selectedWidgetMarker = WidgetMarker.auctions;
        });
        return;
      case WidgetMarker.login:
        setState(() {
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
      child: AuctionsGUI(setMainState, navigate, filterHandler, auctionHandler),
    );
  }

  Widget getLoginContainer() {
    return FadeTransition(
      opacity: animation,
      child: LoginScreen(navigate, auctionHandler.userHandler),
    );
  }

  Widget getRegisterContainer() {
    return FadeTransition(
      opacity: animation,
      child: RegisterScreen(navigate, auctionHandler.userHandler),
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
      child: ProfileGUI(navigate, auctionHandler.userHandler),
    );
  }

  Widget getRoomContainer() {
    return FadeTransition(
      opacity: animation,
      child: Room(navigate, auctionHandler),
    );
  }
}
