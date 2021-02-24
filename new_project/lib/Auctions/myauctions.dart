import 'package:flutter/material.dart';
import '../State/mainGUI.dart';

class MyAuctions extends StatelessWidget {
  final Function navigate;
  MyAuctions(this.navigate);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return new Container(
      color: Colors.grey[900],
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.2,
      margin: EdgeInsets.all(5.0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Center(child: Text("My Auctions")),
          ),
          SliverFixedExtentList(
              itemExtent: 100.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(5.0),
                    color: Colors.pink[600],
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
              )),
        ],
      ),
    );
  }
}
