import 'package:flutter/material.dart';
import '../navigationbar/navbar.dart';

class MainGUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, //Center Row contents horizontally
      crossAxisAlignment:
          CrossAxisAlignment.center, //Center Row contents vertically
      children: [
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
      ],
    );
  }
}
