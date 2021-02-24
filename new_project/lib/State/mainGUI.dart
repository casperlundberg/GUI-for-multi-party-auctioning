import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
//import 'package:http/http.dart' as http;
//import 'package:flutter/foundation.dart';

//import 'dart:html';
import 'dart:async' show Future;

import '../Navigation/navbar.dart';
import '../Auctions/room.dart';
import '../Entities/filtersJSON.dart';
import '../Entities/auctionListJSON.dart';
import '../Entities/auctionDetailsJSON.dart';
import '../Entities/localJSONUserPage.dart';
import '../Pages/auctionsGUI.dart';
import '../Pages/forgotPass.dart';
import '../Pages/login.dart';
import '../Pages/profile.dart';
import '../Pages/register.dart';
import '../jsonUtilities.dart';

//Inspired by Widget Switch Demo, by GitHub user TechieBlossom
//https://github.com/TechieBlossom/flutter-samples/blob/master/widgetswitchdemo.dart

enum WidgetMarker { auctions, login, register, profile, forgotPass, room }

Future<Filters> getFilters() async {
  String jsonString = await rootBundle.loadString("../../JSON/filters.json");
  return filtersFromJson(jsonString);
}

Future<AuctionList> getOngoingAuctions() async {
  String jsonString = await rootBundle.loadString("../../JSON/ongoingAuctions.json");
  return auctionListFromJson(jsonString);
}

Future<AuctionDetails> getAuctionDetails() async {
  String jsonString = await rootBundle.loadString("../../JSON/auctionDetails.json");
  return auctionDetailsFromJson(jsonString);
}

class MainGUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainGUIState();
}

class MainGUIState extends State<MainGUI> with SingleTickerProviderStateMixin<MainGUI> {
  WidgetMarker _selectedWidgetMarker;
  AnimationController _controller;
  Animation _animation;

  // FILTER JSON
  List<Filter> _availableFilters;
  List<Filter> _activeFilters;
  List<Filter> _inactiveFilters;
  int _localFilteridCounter;
  Future _filterFuture;

  // USER
  LocalJsonUserPage _user;

  // AUCTION JSON
  List<AuctionDetails> _auctionDetailsList;
  AuctionList _ongoingAuctionList;
  AuctionList _finishedAuctionList;
  int _currentAuction;
  Future _auctionDetailsFuture;
  Future _auctionFuture;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    // AUCTION VARIABLES
    _auctionFuture = getOngoingAuctions();
    _auctionFuture.then((ongoingauctions) {
      _ongoingAuctionList = ongoingauctions;
    });
    _auctionDetailsList = [];
    _auctionDetailsFuture = getAuctionDetails();
    _auctionDetailsFuture.then((auctionDetails) {
      _auctionDetailsList.add(auctionDetails);
    });

    // FILTER VARIABLES
    _activeFilters = [];
    _inactiveFilters = [];
    _localFilteridCounter = 0;
    _selectedWidgetMarker = WidgetMarker.login;
    _filterFuture = getFilters();
    _filterFuture.then((filters) {
      _availableFilters = filters.filters;
    });

    // USER VARIABLES
    _user = localJsonUserPageFromJson(getUserString());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedWidgetMarker == WidgetMarker.login || _selectedWidgetMarker == WidgetMarker.register || _selectedWidgetMarker == WidgetMarker.forgotPass) {
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
            future: _playAnimation(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return _getCustomContainer();
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
        appBar: NavigationBar(_navigate),
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: _playAnimation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return _getCustomContainer();
          },
        ),
      ),
    );
  }

  _playAnimation() {
    _controller.reset();
    _controller.forward();
  }

  //FILTER METHODS

  void _updateFilters(Filter filter) {
    setState(() {
      if (filter.localid == null) {
        filter.localid = _localFilteridCounter++;
      }
      for (int i = 0; i < _inactiveFilters.length; i++) {
        if (_inactiveFilters[i].localid == filter.localid) {
          _inactiveFilters[i] = filter;
          return;
        }
      }
      for (int i = 0; i < _activeFilters.length; i++) {
        if (_activeFilters[i].localid == filter.localid) {
          _activeFilters[i] = filter;
          return;
        }
        if (_activeFilters[i].id == filter.id) {
          _inactiveFilters.add(_activeFilters[i]);
          _activeFilters.removeAt(i);
          break;
        }
      }
      _activeFilters.add(filter);
    });
  }

  void _deleteFilter(Filter filter) {
    setState(() {
      for (int i = 0; i < _activeFilters.length; i++) {
        if (_activeFilters[i].localid == filter.localid) {
          for (int y = 0; y < _inactiveFilters.length; y++) {
            if (_inactiveFilters[y].id == _activeFilters[i].id) {
              _activeFilters.add(_inactiveFilters[y]);
              _inactiveFilters.removeAt(y);
              break;
            }
          }
          _activeFilters.removeAt(i);
          return;
        }
      }
      for (int i = 0; i < _inactiveFilters.length; i++) {
        if (_inactiveFilters[i].localid == filter.localid) {
          _inactiveFilters.removeAt(i);
          return;
        }
      }
    });
  }

  void _activateFilter(Filter filter) {
    setState(() {
      for (int i = 0; i < _activeFilters.length; i++) {
        if (_activeFilters[i].id == filter.id) {
          _inactiveFilters.add(_activeFilters[i]);
          _activeFilters.removeAt(i);
          break;
        }
      }
      _activeFilters.add(filter);
      for (int i = 0; i < _inactiveFilters.length; i++) {
        if (_inactiveFilters[i].localid == filter.localid) {
          _inactiveFilters.removeAt(i);
          return;
        }
      }
    });
  }

  void _deactivateFilter(Filter filter) {
    setState(() {
      for (int i = 0; i < _activeFilters.length; i++) {
        if (_activeFilters[i].localid == filter.localid) {
          _inactiveFilters.add(_activeFilters[i]);
          _activeFilters.removeAt(i);
          return;
        }
      }
    });
  }

  //AUCTION METHODS

  void _createAuction(List<String> strings, List<String> keys, List<String> valueTypes) {
    int highestid = 0;
    for (int i = 0; i < _ongoingAuctionList.auctionList.length; i++) {
      if (_ongoingAuctionList.auctionList[i].id > highestid) {
        highestid = _ongoingAuctionList.auctionList[i].id;
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

    DateTime startDate = new DateTime.now();
    DateTime stopDate = startDate.add(Duration(hours: 1));

    AuctionDetails newAuctionDetails = new AuctionDetails(
        id: highestid,
        title: "Testauction " + highestid.toString(),
        ownerId: 1,
        ownerType: "Supplier",
        maxParticipants: 10,
        currentParticipants: 0,
        roundTime: 300,
        material: "Wood",
        templateStrings: ts,
        templateVariables: tv,
        bids: [],
        startDate: startDate,
        stopDate: stopDate,
        referenceSector: "composites",
        referenceType: "material");

    Auction newAuction = new Auction(
        id: highestid,
        title: "Testauction " + highestid.toString(),
        ownerId: 1,
        ownerType: "Supplier",
        maxParticipants: 10,
        currentParticipants: 0,
        roundTime: 300,
        material: "Wood",
        startDate: startDate,
        stopDate: stopDate,
        referenceSector: "composites",
        referenceType: "material");

    setState(() {
      _auctionDetailsList.add(newAuctionDetails);
      _ongoingAuctionList.auctionList.add(newAuction);
    });
  }

  AuctionDetails _getAuctionDetails() {
    for (int i = 0; i < _auctionDetailsList.length; i++) {
      if (_auctionDetailsList[i].id == _currentAuction) {
        return _auctionDetailsList[i];
      }
    }
  }

  //NAVIGATION METHODS

  void _setCurrentAuction(int auctionid) {
    _currentAuction = auctionid;
  }

  void _navigate(WidgetMarker page) {
    switch (page) {
      case WidgetMarker.auctions:
        setState(() {
          _filterFuture = getFilters();
          _filterFuture.then((filters) {
            _availableFilters = filters.filters;
          });
          _selectedWidgetMarker = WidgetMarker.auctions;
        });
        return;
      case WidgetMarker.login:
        setState(() {
          _selectedWidgetMarker = WidgetMarker.login;
        });
        return;
      case WidgetMarker.profile:
        setState(() {
          _selectedWidgetMarker = WidgetMarker.profile;
        });
        return;
      case WidgetMarker.register:
        setState(() {
          _selectedWidgetMarker = WidgetMarker.register;
        });
        return;
      case WidgetMarker.forgotPass:
        setState(() {
          _selectedWidgetMarker = WidgetMarker.forgotPass;
        });
        return;
      case WidgetMarker.room:
        setState(() {
          _selectedWidgetMarker = WidgetMarker.room;
        });
    }
  }

  Widget _getCustomContainer() {
    switch (_selectedWidgetMarker) {
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
      opacity: _animation,
      child: AuctionsGUI(_navigate, _availableFilters, _activeFilters, _inactiveFilters, _updateFilters, _deleteFilter, _activateFilter, _deactivateFilter,
          _ongoingAuctionList, _finishedAuctionList, _createAuction, _setCurrentAuction),
    );
  }

  Widget getLoginContainer() {
    return FadeTransition(
      opacity: _animation,
      child: LoginScreen(_navigate),
    );
  }

  Widget getRegisterContainer() {
    return FadeTransition(
      opacity: _animation,
      child: RegisterScreen(_navigate),
    );
  }

  Widget getForgotPassContainer() {
    return FadeTransition(
      opacity: _animation,
      child: ForgotPasswordScreen(_navigate),
    );
  }

  Widget getProfileContainer() {
    return FadeTransition(
      opacity: _animation,
      child: ProfileGUI(_navigate, _user),
    );
  }

  Widget getRoomContainer() {
    return FadeTransition(
      opacity: _animation,
      child: Room(_navigate, _getAuctionDetails),
    );
  }
}
