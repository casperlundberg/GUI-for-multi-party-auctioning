import 'package:flutter/material.dart';

class Room extends StatelessWidget {
  final Function navigate;
  Room(this.navigate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: new Container(
        width: 1400.0,
        height: 700.0,
        color: Colors.grey[900],
        margin: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(children: [
              new Container(
                child: Text(
                  'ROOM NAME: GROUP13, ROOM CODE: 1337',
                  style: TextStyle(fontSize: 30),
                ),
                width: 1400.0,
                height: 40.0,
                color: Colors.blue,
                margin: EdgeInsets.all(5.0),
              ),
            ]),
            Column(children: [
              new Container(
                child: Text(
                  'REQUESTED SERVICE: XXX',
                  style: TextStyle(fontSize: 30),
                ),
                width: 1400.0,
                height: 100.0,
                color: Colors.red,
                margin: EdgeInsets.all(5.0),
              ),
            ]),
            Column(children: [
              CustomScrollView(
                shrinkWrap: true,
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(5),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 5,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text("HOST"),
                          color: Colors.green[100],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('USER'),
                          color: Colors.green[200],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('USER'),
                          color: Colors.green[300],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('USER'),
                          color: Colors.green[400],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('USER'),
                          color: Colors.green[500],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
