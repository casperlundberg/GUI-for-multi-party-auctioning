import 'package:flutter/material.dart';
import 'navigationbar/navbar.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            //Source: https://www.pexels.com/photo/iphone-notebook-pen-working-34088/
            image: AssetImage("../../images/dark/main-BG-dark.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            appBar: NavigationBar(),
            backgroundColor: Colors.transparent,
            body: new Container(
              width: 1400.0,
              height: 700.0,
              color: Colors.grey[900],
              margin: EdgeInsets.all(25.0),
              child: Text(
                'My profile',
                style: TextStyle(fontSize: 30),
              ),
            )));
  }
}
