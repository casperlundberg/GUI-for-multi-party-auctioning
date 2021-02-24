import 'package:flutter/material.dart';

import '../State/mainGUI.dart';
import 'contractGUI.dart';
import '../Entities/auctionListJSON.dart';
import '../Entities/filtersJSON.dart';

enum PageMarker { ongoing, finished }

class Auctions extends StatefulWidget {
  final AuctionList ongoingAuctionList;
  final AuctionList finishedAuctionList;
  final Function navigate;
  final Function createAuction;
  final Function setCurrentAuction;
  final List<Filter> activeFilters;

  Auctions(this.navigate, this.ongoingAuctionList, this.finishedAuctionList, this.createAuction, this.setCurrentAuction, this.activeFilters);

  @override
  _AuctionsState createState() => _AuctionsState(navigate, ongoingAuctionList, finishedAuctionList, createAuction, setCurrentAuction, activeFilters);
}

class _AuctionsState extends State<Auctions> with SingleTickerProviderStateMixin<Auctions> {
  PageMarker _currentPage;
  final AuctionList ongoingAuctionList;
  final AuctionList finishedAuctionList;
  Auction auction;

  final Function navigate;
  final Function createAuction;
  final Function setCurrentAuction;
  final List<Filter> activeFilters;

  _AuctionsState(this.navigate, this.ongoingAuctionList, this.finishedAuctionList, this.createAuction, this.setCurrentAuction, this.activeFilters);

  @override
  void initState() {
    super.initState();
    _currentPage = PageMarker.ongoing;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.4,
      color: Colors.grey[900],
      margin: EdgeInsets.all(5.0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              IconButton(
                icon: Icon(Icons.add),
                tooltip: 'New auction',
                onPressed: () {
                  showContractTemplateGUI();
                },
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.05,
                  color: (_currentPage == PageMarker.ongoing) ? Colors.black : themeData.primaryColor,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _currentPage = PageMarker.ongoing;
                      });
                    },
                    child: Container(
                      child: Text("Ongoing", style: TextStyle(color: (_currentPage == PageMarker.ongoing) ? Colors.white : Colors.white60)),
                    ),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.05,
                  color: (_currentPage == PageMarker.finished) ? Colors.black : themeData.primaryColor,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _currentPage = PageMarker.finished;
                      });
                    },
                    child: Container(
                      child: Text("Finished", style: TextStyle(color: (_currentPage == PageMarker.finished) ? Colors.white : Colors.white60)),
                    ),
                  )),
            ]),
          ),
          FutureBuilder(builder: (BuildContext context, AsyncSnapshot snaptshot) {
            return _getPageContainer();
          })
        ],
      ),
    );
  }

  SliverFixedExtentList _getPageContainer() {
    switch (_currentPage) {
      case PageMarker.ongoing:
        return _getOngoing();
      case PageMarker.finished:
        return _getFinished();
    }
    return _getOngoing();
  }

  SliverFixedExtentList _getOngoing() {
    List<Auction> output = [];
    var now = new DateTime.now();

    for (int i = 0; i < ongoingAuctionList.auctionList.length; i++) {}
    if (activeFilters.length == 0) {
      for (int i = 0; i < ongoingAuctionList.auctionList.length; i++) {
        if (now.isBefore(ongoingAuctionList.auctionList[i].stopDate)) {
          output.add(ongoingAuctionList.auctionList[i]);
        }
      }
    } else {
      for (int i = 0; i < ongoingAuctionList.auctionList.length; i++) {
        for (int y = 0; y < activeFilters.length; y++) {
          if (ongoingAuctionList.auctionList[i].material == activeFilters[y].name) {
            if (now.isBefore(ongoingAuctionList.auctionList[i].stopDate)) {
              output.add(ongoingAuctionList.auctionList[i]);
            }
          }
        }
      }
    }

    return SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(5.0),
              color: Colors.lightGreen[600],
              child: Column(children: [
                Text('Name: Room ' + output[index].id.toString()),
                Text('Material: ' + output[index].material),
                Text('Participants: ' + output[index].currentParticipants.toString()),
                TextButton(
                    child: Text('Visit room'),
                    onPressed: () {
                      setCurrentAuction(output[index].id);
                      navigate(WidgetMarker.room);
                    }),
              ]),
            );
          },
          childCount: output.length,
        ));
  }

  SliverFixedExtentList _getFinished() {
    List<Auction> output = [];
    var now = new DateTime.now();

    for (int i = 0; i < ongoingAuctionList.auctionList.length; i++) {
      if (now.isAfter(ongoingAuctionList.auctionList[i].stopDate)) {
        output.add(ongoingAuctionList.auctionList[i]);
      }
    }

    return SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(5.0),
              color: Colors.yellow[800],
              child: Column(children: [
                Text('Name: Room ' + output[index].id.toString()),
                Text('Material: ' + output[index].material),
                Text('Participants: ' + output[index].currentParticipants.toString()),
                TextButton(
                    child: Text('Visit room'),
                    onPressed: () {
                      setCurrentAuction(output[index].id);
                      navigate(WidgetMarker.room);
                    }),
              ]),
            );
          },
          childCount: output.length,
        ));
  }

  int templateItemCount = 1;
  List<TextEditingController> controllers = [TextEditingController(), TextEditingController(), TextEditingController()];
  final List<String> valueTypes = ["Text", "Integer"];
  List<String> dropdownValues = ["Text"];

  void showContractTemplateGUI() {
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
                                                    Text(" Value-type: "),
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
                                                  Text(" Value: "),
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
                          child: Text("Create auction"),
                          onPressed: () {
                            setState(() {
                              List<String> templateStrings = [];
                              templateStrings.add(controllers[0].text);
                              for (int i = 0; i < templateItemCount; i++) {
                                templateStrings.add(controllers[i * 2 + 2].text);
                              }

                              List<String> keys = [];
                              for (int i = 0; i < templateItemCount; i++) {
                                keys.add(controllers[i * 2 + 1].text);
                              }

                              createAuction(templateStrings, keys, dropdownValues);

                              templateItemCount = 1;
                              controllers = [TextEditingController(), TextEditingController(), TextEditingController()];
                              dropdownValues = ["Text"];
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
                        templateItemCount = 1;
                        controllers = [TextEditingController(), TextEditingController(), TextEditingController()];
                        dropdownValues = ["Text"];
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
