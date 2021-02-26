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
import '../Entities/user.dart';
import '../Entities/contractTemplatesJSON.dart';
import '../Pages/auctionsGUI.dart';
import '../Pages/forgotPass.dart';
import '../Pages/login.dart';
import '../Pages/profile.dart';
import '../Pages/register.dart';
import '../jsonUtilities.dart';
import '../Entities/userList.dart';
import '../Pages/userInfoHandler.dart';

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

Future<ContractTemplates> getSupplierContractTemplates() async {
  String jsonString = await rootBundle.loadString("../../JSON/supplierContractTemplates.json");
  return contractTemplatesFromJson(jsonString);
}

Future<ContractTemplates> getConsumerContractTemplates() async {
  String jsonString = await rootBundle.loadString("../../JSON/consumerContractTemplates.json");
  return contractTemplatesFromJson(jsonString);
}

class MainGUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainGUIState();
}

//TEST COMMENT

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
  User _user;
  UserList _userListObject;
  UserInfoHandler _userHandler;

  // AUCTION JSON
  AuctionDetails _auctionDetailsList;
  AuctionList _ongoingAuctionList;
  AuctionList _finishedAuctionList;
  int _currentAuction;
  ContractTemplates _supplierContractTemplates;
  ContractTemplates _consumerContractTemplates;
  Future _auctionDetailsFuture;
  Future _auctionFuture;
  Future _contractTemplatesFuture1;
  Future _contractTemplatesFuture2;

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
    _auctionDetailsFuture = getAuctionDetails();
    _auctionDetailsFuture.then((auctionDetails) {
      _auctionDetailsList = auctionDetails;
    });
    _contractTemplatesFuture1 = getSupplierContractTemplates();
    _contractTemplatesFuture1.then((contractTemplates) {
      _supplierContractTemplates = contractTemplates;
    });
    _contractTemplatesFuture2 = getConsumerContractTemplates();
    _contractTemplatesFuture2.then((contractTemplates) {
      _consumerContractTemplates = contractTemplates;
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
    _user = userFromJson(getNullUserString());
    _userListObject = userListFromJson(getUserListString());
    _userHandler = new UserInfoHandler(_userListObject, _user);
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
        appBar: NavigationBar(_navigate, _showContractTemplateGUI),
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

  ContractTemplates _getContractTemplates(String userType) {
    if (userType == "Supplier") {
      return _supplierContractTemplates;
    } else {
      return _consumerContractTemplates;
    }
  }

  void _createAuction(int contractID, String title, int maxParticipants, int roundTime, int rounds, String material) {
    int highestid = 0;
    for (int i = 0; i < _ongoingAuctionList.auctionList.length; i++) {
      if (_ongoingAuctionList.auctionList[i].id > highestid) {
        highestid = _ongoingAuctionList.auctionList[i].id;
      }
    }
    highestid++;

    DateTime startDate = new DateTime.now();
    DateTime stopDate = startDate.add(Duration(seconds: (roundTime * rounds)));

    AuctionDetails newAuctionDetails = new AuctionDetails(
        id: highestid,
        title: title,
        ownerId: 1,
        ownerType: "Supplier",
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
        ownerId: 1,
        ownerType: "Supplier",
        maxParticipants: maxParticipants,
        currentParticipants: 0,
        roundTime: roundTime,
        material: material,
        startDate: startDate,
        stopDate: stopDate,
        referenceSector: "composites",
        referenceType: "material");

    setState(() {
      //_auctionDetailsList.auctionsDetails.add(newAuctionDetails);
      _ongoingAuctionList.auctionList.add(newAuction);
    });
  }

  /*AuctionDetails _getAuctionDetails() {
    for (int i = 0; i < _auctionDetailsList.length; i++) {
      if (_auctionDetailsList[i].id == _currentAuction) {
        return _auctionDetailsList[i];
      }
    }
  }*/

  //NAVIGATION METHODS

  void _setCurrentAuction(int auctionid) {
    _currentAuction = auctionid;
  }

  void _navigate(WidgetMarker page) {
    switch (page) {
      case WidgetMarker.auctions:
        setState(() {
          _filterFuture = getFilters();
          _user = userFromJson(getUserString());
          _userListObject = userListFromJson(getUserListString());
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
          _ongoingAuctionList, _finishedAuctionList, _createAuction, _setCurrentAuction, _getContractTemplates, _auctionDetailsList, _user),
    );
  }

  Widget getLoginContainer() {
    return FadeTransition(
      opacity: _animation,
      child: LoginScreen(_navigate, _user, _userListObject, _userHandler),
    );
  }

  Widget getRegisterContainer() {
    return FadeTransition(
      opacity: _animation,
      child: RegisterScreen(_navigate, _user, _userListObject, _userHandler),
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
      child: ProfileGUI(_navigate, _user, _userListObject, _userHandler),
    );
  }

  Widget getRoomContainer() {
    return FadeTransition(
      opacity: _animation,
      child: Room(_navigate, _auctionDetailsList, _getContractTemplates),
    );
  }

  // NEW TEMPLATE (administrator)

  void _createContractTemplate(List<String> strings, List<String> keys, List<String> valueTypes, String userType) {
    ContractTemplates contractTemplates = _getContractTemplates(userType);

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

    ContractTemplate contractTemplate = new ContractTemplate(id: highestid, templateStrings: ts, templateVariables: tv);

    if (userType == "Supplier") {
      setState(() {
        _supplierContractTemplates.contractTemplates.add(contractTemplate);
      });
    }
    if (userType == "Consumer") {
      setState(() {
        _consumerContractTemplates.contractTemplates.add(contractTemplate);
      });
    }
  }

  int _templateItemCount = 1;
  List<TextEditingController> _controllers = [TextEditingController(), TextEditingController(), TextEditingController()];
  List<String> _valueTypes = ["Text", "Integer"];
  List<String> _dropdownValues = ["Text"];
  List<String> _userTypes = ["Supplier", "Consumer"];
  String _dropdownValue = "Supplier";

  void _showContractTemplateGUI() {
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
                                    "Contract template creator",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 2,
                                  ),
                                  SizedBox(height: 24.0),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: _templateItemCount,
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
                                                  controller: _controllers[0],
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
                                                        controller: _controllers[1],
                                                      ),
                                                    ),
                                                    Text(" Value Type: "),
                                                    DropdownButton(
                                                      icon: Icon(Icons.arrow_downward),
                                                      iconSize: 24,
                                                      value: _dropdownValues[index],
                                                      elevation: 16,
                                                      style: TextStyle(color: Colors.white),
                                                      onChanged: (String newValue) {
                                                        setState(() {
                                                          _dropdownValues[index] = newValue;
                                                        });
                                                      },
                                                      items: _valueTypes.map<DropdownMenuItem<String>>((String value) {
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
                                                  controller: _controllers[2],
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
                                                      controller: _controllers[index * 2 + 1],
                                                    ),
                                                  ),
                                                  Text(" Value Type: "),
                                                  DropdownButton(
                                                    icon: Icon(Icons.arrow_downward),
                                                    iconSize: 24,
                                                    value: _dropdownValues[index],
                                                    elevation: 16,
                                                    style: TextStyle(color: Colors.white),
                                                    onChanged: (String newValue) {
                                                      setState(() {
                                                        _dropdownValues[index] = newValue;
                                                      });
                                                    },
                                                    items: _valueTypes.map<DropdownMenuItem<String>>((String value) {
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
                                                controller: _controllers[index * 2 + 2],
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
                                        _templateItemCount++;
                                        _controllers.add(TextEditingController());
                                        _controllers.add(TextEditingController());
                                        _dropdownValues.add("Text");
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
                                          value: _dropdownValue,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.white),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _dropdownValue = newValue;
                                            });
                                          },
                                          items: _userTypes.map<DropdownMenuItem<String>>((String value) {
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
                            setState(() {
                              List<String> templateStrings = [];
                              templateStrings.add(_controllers[0].text);
                              for (int i = 0; i < _templateItemCount; i++) {
                                templateStrings.add(_controllers[i * 2 + 2].text);
                              }

                              List<String> keys = [];
                              for (int i = 0; i < _templateItemCount; i++) {
                                keys.add(_controllers[i * 2 + 1].text);
                              }

                              _createContractTemplate(templateStrings, keys, _dropdownValues, _dropdownValue);

                              _templateItemCount = 1;
                              _controllers = [TextEditingController(), TextEditingController(), TextEditingController()];
                              _dropdownValues = ["Text"];
                              _dropdownValue = "Supplier";
                            });
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
                        _templateItemCount = 1;
                        _controllers = [TextEditingController(), TextEditingController(), TextEditingController()];
                        _dropdownValues = ["Text"];
                        _dropdownValue = "Supplier";
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
