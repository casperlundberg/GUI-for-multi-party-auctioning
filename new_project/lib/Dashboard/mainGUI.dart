import 'package:flutter/material.dart';
import '../navigationbar/navbar.dart';

class MainGUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('AppBar Demo'),
          backgroundColor: const Color(0xFF0099a9),
        ),
        body: Column(children: <Widget>[
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Row contents horizontally
            crossAxisAlignment:
                CrossAxisAlignment.center, //Center Row contents vertically
            children: [
              Container(
                color: Colors.orange,
                margin: EdgeInsets.all(25.0),
                child: FlutterLogo(
                  size: 400.0,
                ),
              ),
              Container(
                color: Colors.blue,
                margin: EdgeInsets.all(25.0),
                child: FlutterLogo(
                  size: 400.0,
                ),
              ),
              Container(
                color: Colors.purple,
                margin: EdgeInsets.all(25.0),
                child: FlutterLogo(
                  size: 400.0,
                ),
              ),
            ],
          ),
        ]));
  }
}
/*
class MainGUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center, //Center Row contents horizontally
      crossAxisAlignment:
          CrossAxisAlignment.center, //Center Row contents vertically
      children: [
        NavigationBar(

        ),
        Row(
          Container(
            color: Colors.orange,
            child: FlutterLogo(
              size: 400.0, //Insert 1st class
            ),
          ),
          Container(
            color: Colors.blue,
            child: FlutterLogo(
              size: 400.0, //Insert 2nd class
            ),
          ),
          Container(
            color: Colors.purple,
            child: FlutterLogo(
              size: 400.0, //Insert 3rd class
            ),
          ),
        ),
      ],
    );
  }
}
*/
