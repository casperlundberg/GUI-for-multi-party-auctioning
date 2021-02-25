import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Entities/auctionDetailsJSON.dart';
import '../Entities/contractTemplatesJSON.dart';
import '../State/mainGUI.dart';
import 'contractGUI.dart';

class Room extends StatefulWidget {
  final Function navigate;
  final Function getAuctionDetails;
  final Function getContractTemplates;

  Room(this.navigate, this.getAuctionDetails, this.getContractTemplates);

  @override
  _RoomState createState() => _RoomState(navigate, getAuctionDetails, getContractTemplates);
}

class _RoomState extends State<Room> {
  final Function navigate;
  final Function getAuctionDetails;
  final Function getContractTemplates;
  AuctionDetails auctionDetails;
  ContractTemplate contractTemplate;
  List<TextEditingController> controllers = [];

  _RoomState(this.navigate, this.getAuctionDetails, this.getContractTemplates) {
    this.auctionDetails = getAuctionDetails();
    ContractTemplates contractTemplates = this.getContractTemplates(this.auctionDetails.ownerType);
    for (int i = 0; i < contractTemplates.contractTemplates.length; i++) {
      if (contractTemplates.contractTemplates[i].id == this.auctionDetails.contractTemplateId) {
        this.contractTemplate = contractTemplates.contractTemplates[i];
      }
    }
    for (int i = 0; i < this.contractTemplate.templateVariables.length; i++) {
      this.controllers.add(TextEditingController());
    }
  }

  void showContractGUI() {
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
                    children: <Widget>[
                      Text(
                        "Contract",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 2,
                      ),
                      SizedBox(height: 20.0),
                      Expanded(
                        child: ListView.builder(
                          itemCount: contractTemplate.templateVariables.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              if (contractTemplate.templateVariables[0].valueType == "Text") {
                                return Column(
                                  children: [
                                    Text(
                                      contractTemplate.templateStrings[0].text,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          child: TextField(
                                            controller: controllers[0],
                                            decoration: InputDecoration(
                                              hintText: contractTemplate.templateVariables[0].key,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      contractTemplate.templateStrings[1].text,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              } else if (contractTemplate.templateVariables[0].valueType == "Integer") {
                                return Column(
                                  children: [
                                    Text(
                                      contractTemplate.templateStrings[0].text,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          child: TextField(
                                            controller: controllers[0],
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                            decoration: InputDecoration(
                                              hintText: contractTemplate.templateVariables[0].key,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      contractTemplate.templateStrings[1].text,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              }
                            } else {
                              if (contractTemplate.templateVariables[index].valueType == "Text") {
                                return Column(
                                  children: [
                                    SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          child: TextField(
                                            controller: controllers[index],
                                            decoration: InputDecoration(
                                              hintText: contractTemplate.templateVariables[index].key,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      contractTemplate.templateStrings[index + 1].text,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              } else if (contractTemplate.templateVariables[index].valueType == "Integer") {
                                return Column(
                                  children: [
                                    SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          child: TextField(
                                            controller: controllers[index],
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                            decoration: InputDecoration(
                                              hintText: contractTemplate.templateVariables[index].key,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      contractTemplate.templateStrings[index + 1].text,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          child: Text("Make bid"),
                          onPressed: () {
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

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 1400.0,
          height: MediaQuery.of(context).size.height * 0.9,
          color: themeData.primaryColor,
          margin: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  tooltip: 'Back',
                  onPressed: () {
                    navigate(WidgetMarker.auctions);
                  },
                ),
                Container(
                  child: Text(
                    'GROUP13',
                    style: TextStyle(fontSize: 30),
                  ),
                  height: 40.0,
                  color: Colors.blue[300],
                  margin: EdgeInsets.all(5.0),
                ),
                Spacer(),
                Container(
                    height: 40.0,
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.all(5.0),
                    child: Tooltip(
                      message: "Copy to clipboard",
                      child: TextButton(
                          child: Text(
                            'ROOM CODE: 1337',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 30),
                          ),
                          onPressed: () {
                            Clipboard.setData(new ClipboardData(text: "1337")).then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.grey[900], content: Text("Room code copied to clipboard", style: TextStyle(color: Colors.white))));
                            });
                          }),
                    )),
              ]),
              Container(
                child: Text(
                  'REQUESTED SERVICE: XXX',
                  style: TextStyle(fontSize: 30),
                ),
                width: 1400.0,
                height: MediaQuery.of(context).size.height * 0.05,
                color: Colors.red,
                margin: EdgeInsets.all(5.0),
              ),
              Container(
                color: Colors.blue,
                margin: EdgeInsets.all(5.0),
                height: MediaQuery.of(context).size.height * 0.7,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 250.0,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                color: Colors.amber[700],
                                width: 650.0,
                                height: MediaQuery.of(context).size.height * 0.1,
                                alignment: Alignment.center,
                                child: Text(
                                  'Specific Auction info',
                                  textAlign: TextAlign.center,
                                )),
                            Spacer(),
                            Container(
                              color: Colors.amber[900],
                              width: 650.0,
                              height: MediaQuery.of(context).size.height * 0.1,
                              alignment: Alignment.center,
                              child: Text(
                                'Time remaining, current bid, graph of bid history?',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        title: Row(children: [
                          Text(
                            'Bids',
                            textAlign: TextAlign.start,
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.add),
                            tooltip: 'New bid',
                            onPressed: () {
                              showContractGUI();
                            },
                          ),
                        ]),
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 410.0,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 4.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Container(
                            alignment: Alignment.center,
                            color: Colors.teal[100 * (index % 9)],
                            child: Text('Company $index'),
                          );
                        },
                        childCount: 50,
                      ),
                    ),
                    // SliverFixedExtentList(
                    //   itemExtent: 50.0,
                    //   delegate: SliverChildBuilderDelegate(
                    //     (BuildContext context, int index) {
                    //       return Container(
                    //         alignment: Alignment.center,
                    //         color: Colors.lightBlue[100 * (index % 9)],
                    //         child: Text('List Item $index'),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
