import 'package:flutter/material.dart';
import '../navigationbar/navbar.dart';

class Room extends StatelessWidget {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ROOM \n',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Name: Project \n',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'E-mail: projectgroup13@ltu.se \n',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'a new line \n',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'a new line \n',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'a new line \n',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            )));
  }
}
