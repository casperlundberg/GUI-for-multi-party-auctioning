import 'dart:html';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:new_project/Handlers/filterHandler.dart';
import 'package:new_project/Handlers/offerHandler.dart';
import '../Handlers/auctionHandler.dart';
import '../mainGUI.dart';
import '../Entities/templateListJSON.dart';

class MyAuctions extends StatefulWidget {
  final Function navigate;
  final AuctionHandler auctionHandler;
  final OfferHandler offerHandler;
  final FilterHandler filterHandler;

  MyAuctions(this.navigate, this.auctionHandler, this.offerHandler, this.filterHandler);

  @override
  _MyAuctionsState createState() => _MyAuctionsState(navigate, auctionHandler, offerHandler, filterHandler);
}

class _MyAuctionsState extends State<MyAuctions> with SingleTickerProviderStateMixin<MyAuctions> {
  final Function navigate;
  final AuctionHandler auctionHandler;
  final OfferHandler offerHandler;
  final FilterHandler filterHandler;
  Template template;
  TextEditingController title = TextEditingController();
  TextEditingController maxParticipants = TextEditingController();
  TextEditingController duration = TextEditingController();
  List<TextEditingController> rangeReferenceParameterControllers;
  List<List<String>> referenceTypes;
  List<List<String>> referenceParameters;
  List<List<String>> rangeReferenceParameters;
  List<String> templateIDs;
  final List<String> types = ["Auction", "Offer"];
  String referenceSectorDropdownValue;
  String referenceTypeDropdownValue;
  List<String> referenceParameterDropdownValues;
  String typeDropdownValue;
  String templateIDDropdownValue;

  _MyAuctionsState(this.navigate, this.auctionHandler, this.offerHandler, this.filterHandler) {
    referenceTypes = [];
    referenceParameters = [];
    rangeReferenceParameters = [];
    for (int i = 0; i < filterHandler.filters.referenceSectors.length; i++) {
      List<String> referenceSector = [];
      referenceSector.add(filterHandler.filters.referenceSectors[i].name);
      for (int y = 0; y < filterHandler.filters.referenceSectors[i].referenceTypes.length; y++) {
        referenceSector.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].name);
        for (int u = 0; u < filterHandler.filters.referenceSectors[i].referenceTypes[y].referenceParameters.length; u++) {
          List<String> l = [];
          l.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].name);
          l.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].referenceParameters[u].name);
          for (int o = 0; o < filterHandler.filters.referenceSectors[i].referenceTypes[y].referenceParameters[u].values.length; o++) {
            l.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].referenceParameters[u].values[o].filterValue);
          }
          referenceParameters.add(l);
        }
        for (int u = 0; u < filterHandler.filters.referenceSectors[i].referenceTypes[y].rangeReferenceParameters.length; u++) {
          List<String> l = [];
          l.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].name);
          l.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].rangeReferenceParameters[u].name);
          rangeReferenceParameters.add(l);
        }
      }
      referenceTypes.add(referenceSector);
    }
    referenceSectorDropdownValue = referenceTypes[0][0];
    referenceTypeDropdownValue = referenceTypes[0][1];
    referenceParameterDropdownValues = [];
    for (int i = 0; i < referenceParameters.length; i++) {
      if (referenceParameters[i][0] == referenceTypeDropdownValue) {
        referenceParameterDropdownValues.add(referenceParameters[i][2]);
      }
    }
    rangeReferenceParameterControllers = [];
    for (int i = 0; i < rangeReferenceParameters.length; i++) {
      if (rangeReferenceParameters[i][0] == referenceTypeDropdownValue) {
        rangeReferenceParameterControllers.add(new TextEditingController());
      }
    }
    typeDropdownValue = "Auction";
    templateIDDropdownValue = auctionHandler.contractTemplates.templates[0].id.toString();
    templateIDs = [];
    for (int i = 0; i < auctionHandler.contractTemplates.templates.length; i++) {
      templateIDs.add(auctionHandler.contractTemplates.templates[i].id.toString());
    }
    template = auctionHandler.contractTemplates.templates[0];
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
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
                tooltip: 'New listing',
                onPressed: () {
                  showTemplateGUI();
                },
              ),
            ]),
          ), /*
          SliverFixedExtentList(
              itemExtent: 100.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      color: now.isAfter(auctionHandler.myAuctions.auctionList[index].stopDate) ? Colors.redAccent : Colors.greenAccent[700],
                      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text('Name: Room ${auctionHandler.myAuctions.auctionList[index].id}'),
                          Text('Material: ${auctionHandler.myAuctions.auctionList[index].material}'),
                          Text('Participants: ${auctionHandler.myAuctions.auctionList[index].currentParticipants}'),
                        ]),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                              child: Text('Visit room'),
                              onPressed: () {
                                auctionHandler.setCurrentAuction(auctionHandler.myAuctions.auctionList[index].id);
                                navigate(WidgetMarker.room);
                              }),
                        ),
                      ]));
                },
                childCount: auctionHandler.myAuctions.auctionList.length,
              ))*/
        ],
      ),
    );
  }

  void showTemplateGUI() {
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
                                    typeDropdownValue == "Auction" ? "Create new auction" : "Create new offer",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 2,
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Listing type: "),
                                      DropdownButton(
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        value: typeDropdownValue,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.white),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            typeDropdownValue = newValue;
                                            if (typeDropdownValue == "Auction") {
                                              templateIDDropdownValue = auctionHandler.contractTemplates.templates[0].id.toString();
                                              templateIDs = [];
                                              for (int i = 0; i < auctionHandler.contractTemplates.templates.length; i++) {
                                                templateIDs.add(auctionHandler.contractTemplates.templates[i].id.toString());
                                              }
                                              template = auctionHandler.contractTemplates.templates[0];
                                            }
                                            if (typeDropdownValue == "Offer") {
                                              templateIDDropdownValue = offerHandler.offerTemplates.templates[0].id.toString();
                                              templateIDs = [];
                                              for (int i = 0; i < offerHandler.offerTemplates.templates.length; i++) {
                                                templateIDs.add(offerHandler.offerTemplates.templates[i].id.toString());
                                              }
                                              template = offerHandler.offerTemplates.templates[0];
                                            }
                                          });
                                        },
                                        items: types.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(width: 30.0),
                                      Text("Reference sector: "),
                                      DropdownButton(
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        value: referenceSectorDropdownValue,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.white),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            referenceSectorDropdownValue = newValue;
                                          });
                                        },
                                        items: getReferenceSectors().map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(width: 30.0),
                                      Text("Reference type: "),
                                      DropdownButton(
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        value: referenceTypeDropdownValue,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.white),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            referenceTypeDropdownValue = newValue;
                                            referenceParameterDropdownValues = [];
                                            for (int i = 0; i < referenceParameters.length; i++) {
                                              if (referenceParameters[i][0] == referenceTypeDropdownValue) {
                                                referenceParameterDropdownValues.add(referenceParameters[i][2]);
                                              }
                                            }
                                            rangeReferenceParameterControllers = [];
                                            for (int i = 0; i < rangeReferenceParameters.length; i++) {
                                              if (rangeReferenceParameters[i][0] == referenceTypeDropdownValue) {
                                                rangeReferenceParameterControllers.add(new TextEditingController());
                                              }
                                            }
                                          });
                                        },
                                        items: getReferenceTypes().map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.0),
                                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Text(typeDropdownValue == "Auction" ? "Auction Title: " : "Offer Title"),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      child: TextField(
                                        controller: title,
                                      ),
                                    ),
                                    SizedBox(width: 30.0),
                                    Text("Duration: "),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      child: TextField(
                                        controller: duration,
                                      ),
                                    ),
                                    SizedBox(width: 30.0),
                                    Text(typeDropdownValue == "Auction" ? "Max participants: " : ""),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      child: typeDropdownValue == "Auction"
                                          ? TextField(
                                              controller: maxParticipants,
                                            )
                                          : null,
                                    ),
                                  ]),
                                  SizedBox(height: 20.0),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: ((referenceParameterDropdownValues.length + rangeReferenceParameterControllers.length) / 3).ceil(),
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: (index + 1), 
                                                itemBuilder: ,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Template ID: "),
                                      DropdownButton(
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        value: templateIDDropdownValue,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.white),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            templateIDDropdownValue = newValue;
                                            if (typeDropdownValue == "Auction") {
                                              for (int i = 0; i < auctionHandler.contractTemplates.templates.length; i++) {
                                                if (auctionHandler.contractTemplates.templates[i].id.toString() == templateIDDropdownValue) {
                                                  template = auctionHandler.contractTemplates.templates[i];
                                                }
                                              }
                                            }
                                            if (typeDropdownValue == "Offer") {
                                              for (int i = 0; i < offerHandler.offerTemplates.templates.length; i++) {
                                                if (offerHandler.offerTemplates.templates[i].id.toString() == templateIDDropdownValue) {
                                                  template = offerHandler.offerTemplates.templates[i];
                                                }
                                              }
                                            }
                                          });
                                        },
                                        items: templateIDs.map<DropdownMenuItem<String>>((String value) {
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
                                    typeDropdownValue == "Auction" ? "Contract Template" : "Offer Template",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5,
                                  ),
                                  SizedBox(height: 20.0),
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
                                                    template.templateVariables[0].key,
                                                    style: TextStyle(fontStyle: FontStyle.italic),
                                                  ),
                                                  Text(
                                                    " Value Type: ",
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    template.templateVariables[0].valueType,
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
                                                  template.templateVariables[index].key,
                                                  style: TextStyle(fontStyle: FontStyle.italic),
                                                ),
                                                Text(
                                                  " Value Type: ",
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  template.templateVariables[index].valueType,
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
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          child: Text(typeDropdownValue == "Auction" ? "Create auction" : "Create offer"),
                          onPressed: () {
                            if (referenceTypeDropdownValue == "material") {
                              auctionHandler.createMaterialAuction(
                                  int.parse(templateIDDropdownValue),
                                  title.text,
                                  int.parse(maxParticipants.text),
                                  int.parse(duration.text),
                                  referenceParameterDropdownValues[0],
                                  referenceParameterDropdownValues[1],
                                  referenceParameterDropdownValues[2],
                                  referenceParameterDropdownValues[3],
                                  referenceParameterDropdownValues[4],
                                  int.parse(rangeReferenceParameterControllers[0].text),
                                  int.parse(rangeReferenceParameterControllers[1].text),
                                  int.parse(rangeReferenceParameterControllers[2].text),
                                  int.parse(rangeReferenceParameterControllers[3].text));
                            }
                            if (referenceTypeDropdownValue == "referencetype2") {
                              auctionHandler.createReferencetype2Auction(
                                  int.parse(templateIDDropdownValue),
                                  title.text,
                                  int.parse(maxParticipants.text),
                                  int.parse(duration.text),
                                  referenceParameterDropdownValues[0],
                                  referenceParameterDropdownValues[1],
                                  int.parse(rangeReferenceParameterControllers[0].text),
                                  int.parse(rangeReferenceParameterControllers[1].text));
                            }
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
                        title.clear();
                        maxParticipants.clear();
                        duration.clear();
                        referenceSectorDropdownValue = referenceTypes[0][0];
                        referenceTypeDropdownValue = referenceTypes[0][1];
                        referenceParameterDropdownValues = [];
                        for (int i = 0; i < referenceParameters.length; i++) {
                          if (referenceParameters[i][0] == referenceTypeDropdownValue) {
                            referenceParameterDropdownValues.add(referenceParameters[i][2]);
                          }
                        }
                        rangeReferenceParameterControllers = [];
                        for (int i = 0; i < rangeReferenceParameters.length; i++) {
                          if (rangeReferenceParameters[i][0] == referenceTypeDropdownValue) {
                            rangeReferenceParameterControllers.add(new TextEditingController());
                          }
                        }
                        typeDropdownValue = "Auction";
                        templateIDDropdownValue = auctionHandler.contractTemplates.templates[0].id.toString();
                        templateIDs = [];
                        for (int i = 0; i < auctionHandler.contractTemplates.templates.length; i++) {
                          templateIDs.add(auctionHandler.contractTemplates.templates[i].id.toString());
                        }
                        template = auctionHandler.contractTemplates.templates[0];
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

  List<String> getReferenceSectors() {
    List<String> l = [];
    for (int i = 0; i < referenceTypes.length; i++) {
      if (l.contains(referenceTypes[i][0])) {
        continue;
      }
      l.add(referenceTypes[i][0]);
    }
    return l;
  }

  List<String> getReferenceTypes() {
    List<String> l = [];
    for (int i = 0; i < referenceTypes.length; i++) {
      if (referenceTypes[i][0] == referenceSectorDropdownValue) {
        if (l.contains(referenceTypes[i][1])) {
          continue;
        }
        l.add(referenceTypes[i][1]);
      }
    }
    return l;
  }
}
