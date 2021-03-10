import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_project/Entities/materialAuctionListJSON.dart';
import '../Entities/referencetype2AuctionListJSON.dart';

import '../Handlers/filterHandler.dart';
import '../Entities/filtersJSON.dart';

class FiltersGUI extends StatefulWidget {
  final FilterHandler filterHandler;

  FiltersGUI(this.filterHandler);

  @override
  _FiltersState createState() => _FiltersState(filterHandler);
}

class _FiltersState extends State<FiltersGUI> {
  final FilterHandler filterHandler;
  List<TextEditingController> controllers;
  List<List<String>> referenceTypes;
  List<List<String>> referenceParameters;
  List<List<String>> rangeReferenceParameters;
  List<List<String>> currentReferenceParameters;
  String referenceSectorDropdownValue;
  String referenceTypeDropdownValue;
  List<String> referenceParameterDropdownValues;
  List<TextEditingController> rangeReferenceParameterControllers;

  _FiltersState(this.filterHandler) {
    referenceTypes = [];
    referenceParameters = [];
    rangeReferenceParameters = [];
    for (int i = 0; i < filterHandler.filters.referenceSectors.length; i++) {
      for (int y = 0; y < filterHandler.filters.referenceSectors[i].referenceTypes.length; y++) {
        List<String> referenceType = [];
        referenceType.add(filterHandler.filters.referenceSectors[i].name);
        referenceType.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].name);
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
          l.add("min" + filterHandler.filters.referenceSectors[i].referenceTypes[y].rangeReferenceParameters[u].name);
          rangeReferenceParameters.add(l);
          l = [];
          l.add(filterHandler.filters.referenceSectors[i].referenceTypes[y].name);
          l.add("max" + filterHandler.filters.referenceSectors[i].referenceTypes[y].rangeReferenceParameters[u].name);
          rangeReferenceParameters.add(l);
        }
        referenceTypes.add(referenceType);
      }
    }
    referenceSectorDropdownValue = referenceTypes[0][0];
    referenceTypeDropdownValue = referenceTypes[0][1];
    referenceParameterDropdownValues = [];
    currentReferenceParameters = [];
    for (int i = 0; i < referenceParameters.length; i++) {
      if (referenceParameters[i][0] == referenceTypeDropdownValue) {
        referenceParameterDropdownValues.add(referenceParameters[i][2]);
        List<String> l = [];
        for (int y = 1; y < referenceParameters[i].length; y++) {
          l.add(referenceParameters[i][y]);
        }
        currentReferenceParameters.add(l);
      }
    }
    rangeReferenceParameterControllers = [];
    for (int i = 0; i < rangeReferenceParameters.length; i++) {
      if (rangeReferenceParameters[i][0] == referenceTypeDropdownValue) {
        rangeReferenceParameterControllers.add(new TextEditingController());
        currentReferenceParameters.add([rangeReferenceParameters[i][1]]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return new Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.2,
      margin: EdgeInsets.all(5.0),
      color: themeData.primaryColor,
      child: Column(
        children: [
          Container(
            // TitleBar
            //This may not be an appbar but because it uses the kToolbarHeight
            //variable it still has the same size
            height: Size.fromHeight(kToolbarHeight).height,
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Row(children: [
              Text("Filters",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              Spacer(),
              IconButton(
                icon: Icon(Icons.add),
                tooltip: 'New Filter',
                onPressed: () {
                  showFilterTemplateGUI();
                },
              ),
            ]),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ReturnContent(context),
          ),
        ],
      ),
    );
  }

  Widget ReturnContent(context) {
    if (filterHandler.materialFilter != null || filterHandler.referencetype2Filter != null) {
      return Scrollbar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
              height: filterHandler.materialFilter != null ? 200.0 : null,
              color: filterHandler.materialFilter != null ? Colors.blue : null,
              margin: filterHandler.materialFilter != null ? EdgeInsets.all(5.0) : null,
              child: filterHandler.materialFilter != null
                  ? Column(
                      children: [
                        Text(
                          "Referencetype: Material",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  referenceSectorDropdownValue = "composites";
                                  referenceTypeDropdownValue = "material";
                                  referenceParameterDropdownValues = [
                                    filterHandler.materialFilter.fibersType,
                                    filterHandler.materialFilter.resinType,
                                    filterHandler.materialFilter.recyclingTechnology,
                                    filterHandler.materialFilter.sizing,
                                    filterHandler.materialFilter.additives
                                  ];
                                  currentReferenceParameters = [];
                                  for (int i = 0; i < referenceParameters.length; i++) {
                                    if (referenceParameters[i][0] == referenceTypeDropdownValue) {
                                      List<String> l = [];
                                      for (int y = 1; y < referenceParameters[i].length; y++) {
                                        l.add(referenceParameters[i][y]);
                                      }
                                      currentReferenceParameters.add(l);
                                    }
                                  }
                                  rangeReferenceParameterControllers = [
                                    new TextEditingController(text: filterHandler.materialFilter.minFiberLength.toString()),
                                    new TextEditingController(text: filterHandler.materialFilter.maxFiberLength.toString()),
                                    new TextEditingController(text: filterHandler.materialFilter.minVolume.toString()),
                                    new TextEditingController(text: filterHandler.materialFilter.maxVolume.toString()),
                                  ];
                                  for (int i = 0; i < rangeReferenceParameters.length; i++) {
                                    if (rangeReferenceParameters[i][0] == referenceTypeDropdownValue) {
                                      currentReferenceParameters.add([rangeReferenceParameters[i][1]]);
                                    }
                                  }
                                });
                                showFilterTemplateGUI();
                              },
                              child: Text('Edit filter'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                filterHandler.deleteFilter("material");
                              },
                              child: Text('Delete filter'),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Fibers type: " + filterHandler.materialFilter.fibersType),
                            Text("Resin type: " + filterHandler.materialFilter.resinType),
                            Text("Minimum fiber length: " + filterHandler.materialFilter.minFiberLength.toString()),
                            Text("Maximum fiber length: " + filterHandler.materialFilter.maxFiberLength.toString()),
                            Text("Recycling technology: " + filterHandler.materialFilter.recyclingTechnology),
                            Text("Sizing: " + filterHandler.materialFilter.sizing),
                            Text("Additives: " + filterHandler.materialFilter.additives),
                            Text("Minimum volume: " + filterHandler.materialFilter.minVolume.toString()),
                            Text("Maximum volume: " + filterHandler.materialFilter.maxVolume.toString()),
                          ],
                        ),
                      ],
                    )
                  : null,
            ),
            new Container(
              height: filterHandler.referencetype2Filter != null ? 200.0 : null,
              color: filterHandler.referencetype2Filter != null ? Colors.blue : null,
              margin: filterHandler.referencetype2Filter != null ? EdgeInsets.all(5.0) : null,
              child: filterHandler.referencetype2Filter != null
                  ? Column(
                      children: [
                        Text(
                          "Referencetype: Referencetype2",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  referenceSectorDropdownValue = "composites";
                                  referenceTypeDropdownValue = "referencetype2";
                                  referenceParameterDropdownValues = [
                                    filterHandler.referencetype2Filter.parameter1,
                                    filterHandler.referencetype2Filter.parameter2
                                  ];
                                  currentReferenceParameters = [];
                                  for (int i = 0; i < referenceParameters.length; i++) {
                                    if (referenceParameters[i][0] == referenceTypeDropdownValue) {
                                      List<String> l = [];
                                      for (int y = 1; y < referenceParameters[i].length; y++) {
                                        l.add(referenceParameters[i][y]);
                                      }
                                      currentReferenceParameters.add(l);
                                    }
                                  }
                                  rangeReferenceParameterControllers = [
                                    new TextEditingController(text: filterHandler.referencetype2Filter.minVolume.toString()),
                                    new TextEditingController(text: filterHandler.referencetype2Filter.maxVolume.toString()),
                                  ];
                                  for (int i = 0; i < rangeReferenceParameters.length; i++) {
                                    if (rangeReferenceParameters[i][0] == referenceTypeDropdownValue) {
                                      currentReferenceParameters.add([rangeReferenceParameters[i][1]]);
                                    }
                                  }
                                });
                                showFilterTemplateGUI();
                              },
                              child: Text('Edit filter'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                filterHandler.deleteFilter("referencetype2");
                              },
                              child: Text('Delete filter'),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Parameter 1: " + filterHandler.referencetype2Filter.parameter1),
                            Text("Parameter 2: " + filterHandler.referencetype2Filter.parameter2),
                            Text("Minimum volume: " + filterHandler.referencetype2Filter.minVolume.toString()),
                            Text("Maximum volume: " + filterHandler.referencetype2Filter.maxVolume.toString()),
                          ],
                        ),
                      ],
                    )
                  : null,
            ),
          ],
        ),
      );
    } else {
      return Center(child: Text("No Filters added"));
    }
  }

  void showFilterTemplateGUI() {
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
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          /*
                          ====================
                          Filters are listed below
                          ====================
                          */
                          child: new Container(
                            width: 400,
                            height: 700,
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  children: [
                                    Text(
                                      "Filter",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                      textScaleFactor: 2,
                                    ),
                                    SizedBox(height: 10.0),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
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
                                        SizedBox(height: 10.0),
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
                                              currentReferenceParameters = [];
                                              for (int i = 0; i < referenceParameters.length; i++) {
                                                if (referenceParameters[i][0] == referenceTypeDropdownValue) {
                                                  referenceParameterDropdownValues.add(referenceParameters[i][2]);
                                                  List<String> l = [];
                                                  for (int y = 1; y < referenceParameters[i].length; y++) {
                                                    l.add(referenceParameters[i][y]);
                                                  }
                                                  currentReferenceParameters.add(l);
                                                }
                                              }
                                              rangeReferenceParameterControllers = [];
                                              for (int i = 0; i < rangeReferenceParameters.length; i++) {
                                                if (rangeReferenceParameters[i][0] == referenceTypeDropdownValue) {
                                                  rangeReferenceParameterControllers.add(new TextEditingController());
                                                  currentReferenceParameters.add([rangeReferenceParameters[i][1]]);
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
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: (referenceParameterDropdownValues.length + rangeReferenceParameterControllers.length),
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: (index < referenceParameterDropdownValues.length)
                                                ? [
                                                    Text(currentReferenceParameters[index][0] + ": "),
                                                    DropdownButton(
                                                      icon: Icon(Icons.arrow_downward),
                                                      iconSize: 24,
                                                      value: referenceParameterDropdownValues[index],
                                                      elevation: 16,
                                                      style: TextStyle(color: Colors.white),
                                                      onChanged: (String newValue) {
                                                        setState(() {
                                                          referenceParameterDropdownValues[index] = newValue;
                                                        });
                                                      },
                                                      items: getReferenceParameters(index).map<DropdownMenuItem<String>>((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ]
                                                : [
                                                    Text(currentReferenceParameters[index][0] + ": "),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.05,
                                                      height: MediaQuery.of(context).size.height * 0.05,
                                                      child: TextField(
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                        controller: rangeReferenceParameterControllers[index - referenceParameterDropdownValues.length],
                                                      ),
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
                      ),
                      /*
                      ====================
                      Bottombutton
                      ====================
                      */
                      SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          child: Text("Add filter"),
                          onPressed: () {
                            if (referenceTypeDropdownValue == "material") {
                              filterHandler.updateFilter(
                                  materialFilter: new MaterialReferenceParameters(
                                fibersType: referenceParameterDropdownValues[0],
                                resinType: referenceParameterDropdownValues[1],
                                minFiberLength: int.parse(rangeReferenceParameterControllers[0].text),
                                maxFiberLength: int.parse(rangeReferenceParameterControllers[1].text),
                                recyclingTechnology: referenceParameterDropdownValues[2],
                                sizing: referenceParameterDropdownValues[3],
                                additives: referenceParameterDropdownValues[4],
                                minVolume: int.parse(rangeReferenceParameterControllers[2].text),
                                maxVolume: int.parse(rangeReferenceParameterControllers[3].text),
                              ));
                            }
                            if (referenceTypeDropdownValue == "referencetype2") {
                              filterHandler.updateFilter(
                                  referencetype2Filter: new Referencetype2ReferenceParameters(
                                parameter1: referenceParameterDropdownValues[0],
                                parameter2: referenceParameterDropdownValues[1],
                                minVolume: int.parse(rangeReferenceParameterControllers[0].text),
                                maxVolume: int.parse(rangeReferenceParameterControllers[1].text),
                              ));
                            }
                            referenceSectorDropdownValue = referenceTypes[0][0];
                            referenceTypeDropdownValue = referenceTypes[0][1];
                            referenceParameterDropdownValues = [];
                            currentReferenceParameters = [];
                            for (int i = 0; i < referenceParameters.length; i++) {
                              if (referenceParameters[i][0] == referenceTypeDropdownValue) {
                                referenceParameterDropdownValues.add(referenceParameters[i][2]);
                                List<String> l = [];
                                for (int y = 1; y < referenceParameters[i].length; y++) {
                                  l.add(referenceParameters[i][y]);
                                }
                                currentReferenceParameters.add(l);
                              }
                            }
                            rangeReferenceParameterControllers = [];
                            for (int i = 0; i < rangeReferenceParameters.length; i++) {
                              if (rangeReferenceParameters[i][0] == referenceTypeDropdownValue) {
                                rangeReferenceParameterControllers.add(new TextEditingController());
                                currentReferenceParameters.add([rangeReferenceParameters[i][1]]);
                              }
                            }
                            Navigator.pop(context);
                          },
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
                      referenceSectorDropdownValue = referenceTypes[0][0];
                      referenceTypeDropdownValue = referenceTypes[0][1];
                      referenceParameterDropdownValues = [];
                      currentReferenceParameters = [];
                      for (int i = 0; i < referenceParameters.length; i++) {
                        if (referenceParameters[i][0] == referenceTypeDropdownValue) {
                          referenceParameterDropdownValues.add(referenceParameters[i][2]);
                          List<String> l = [];
                          for (int y = 1; y < referenceParameters[i].length; y++) {
                            l.add(referenceParameters[i][y]);
                          }
                          currentReferenceParameters.add(l);
                        }
                      }
                      rangeReferenceParameterControllers = [];
                      for (int i = 0; i < rangeReferenceParameters.length; i++) {
                        if (rangeReferenceParameters[i][0] == referenceTypeDropdownValue) {
                          rangeReferenceParameterControllers.add(new TextEditingController());
                          currentReferenceParameters.add([rangeReferenceParameters[i][1]]);
                        }
                      }
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

  List<String> getReferenceParameters(int index) {
    List<String> l = [];
    for (int i = 1; i < currentReferenceParameters[index].length; i++) {
      l.add(currentReferenceParameters[index][i]);
    }
    return l;
  }
}
