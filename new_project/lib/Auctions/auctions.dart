import 'package:flutter/material.dart';

import '../State/mainGUI.dart';
import 'contractGUI.dart';
import '../Entities/auctionsListJSON.dart';

enum PageMarker { ongoing, finished }

class Auctions extends StatefulWidget {
  final AuctionsList ongoingAuctionList;
  final Function navigate;

  Auctions(this.navigate, this.ongoingAuctionList);

  @override
  _AuctionsState createState() => _AuctionsState(navigate, ongoingAuctionList);
}

class _AuctionsState extends State<Auctions> with SingleTickerProviderStateMixin<Auctions> {
  PageMarker _currentPage;
  final AuctionsList ongoingAuctionList;
  Auction auction;

  final Function navigate;

  _AuctionsState(this.navigate, this.ongoingAuctionList);

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
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                onPressed: () {
                  showContractTemplateGUI();
                },
                child: Text("Create auction", style: TextStyle(color: Colors.white)),
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
    return SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(5.0),
              color: Colors.lightGreen[100 * (index % 9)],
              child: Column(children: [
                Text('Name: Room ' + ongoingAuctionList.auctions[index].id.toString()),
                Text('Material: ' + ongoingAuctionList.auctions[index].material),
                Text('Participants: ' + ongoingAuctionList.auctions[index].currentParticipants.toString()),
                TextButton(
                    child: Text('Visit room'),
                    onPressed: () {
                      navigate(WidgetMarker.room);
                    }),
              ]),
            );
          },
          childCount: ongoingAuctionList.auctions.length,
        ));
  }

  SliverFixedExtentList _getFinished() {
    return SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(5.0),
              color: Colors.yellow[100 * (index % 9)],
              child: Column(children: [
                Text('Name: Room $index'),
                Text('Material: Wood'),
                Text('Participants: 5'),
                TextButton(
                    child: Text('Visit room'),
                    onPressed: () {
                      navigate(WidgetMarker.room);
                    }),
              ]),
            );
          },
          childCount: 10,
        ));
  }

  int templateItemCount = 1;
  List<TextEditingController> controllers = [TextEditingController(), TextEditingController()];
  List<String> types = ["Text", "Number", "Integer"];
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
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              return Row(
                                children: [
                                  TextField(
                                    controller: controllers[0],
                                  ),
                                  ListView.builder(
                                    itemCount: templateItemCount,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
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
                                            items: types.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                          TextField(
                                            controller: controllers[index + 1],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        templateItemCount++;
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
                              templateItemCount = 1;
                              controllers = [TextEditingController(), TextEditingController()];
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
                        controllers = [TextEditingController(), TextEditingController()];
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
