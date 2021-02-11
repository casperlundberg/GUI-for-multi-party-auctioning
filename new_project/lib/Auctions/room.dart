import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../State/mainGUI.dart';
import 'contractGUI.dart';

class Room extends StatelessWidget {
  final Function navigate;
  Room(this.navigate);

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
                            Clipboard.setData(new ClipboardData(text: "1337"))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.grey[900],
                                      content: Text(
                                          "Room code copied to clipboard",
                                          style:
                                              TextStyle(color: Colors.white))));
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
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
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
                            onPressed: () {},
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
        )));
  }
}
