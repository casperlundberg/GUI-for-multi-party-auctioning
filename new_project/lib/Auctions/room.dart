import 'package:flutter/material.dart';

class Room extends StatelessWidget {
  final Function navigate;
  Room(this.navigate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Container(
          width: 1400.0,
          height: 700.0,
          color: Colors.grey[900],
          margin: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: [
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
                  child: Text(
                    'ROOM CODE: 1337',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 30),
                  ),
                  height: 40.0,
                  alignment: Alignment.topLeft,
                  color: Colors.blue[600],
                  margin: EdgeInsets.all(5.0),
                ),
              ]),
              Container(
                child: Text(
                  'REQUESTED SERVICE: XXX',
                  style: TextStyle(fontSize: 30),
                ),
                width: 1400.0,
                height: 100.0,
                color: Colors.red,
                margin: EdgeInsets.all(5.0),
              ),
              Container(
                color: Colors.blue,
                margin: EdgeInsets.all(5.0),
                height: 525.0,
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
                                height: 150.0,
                                alignment: Alignment.center,
                                child: Text(
                                  'Some text',
                                  textAlign: TextAlign.center,
                                )),
                            Spacer(),
                            Container(
                              color: Colors.amber[900],
                              width: 650.0,
                              height: 150.0,
                              alignment: Alignment.center,
                              child: Text(
                                'A graph?',
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
                        childCount: 20,
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
