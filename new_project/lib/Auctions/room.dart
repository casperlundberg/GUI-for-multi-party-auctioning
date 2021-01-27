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
                    Row(children: [
                      new Container(
                        child: Text('HOST'),
                        width: 320.0,
                        height: 110.0,
                        color: Colors.grey,
                        margin: EdgeInsets.all(5.0),
                      ),
                    ]),
                    Row(children: [
                      new Container(
                        child: Text('USER 1'),
                        width: 320.0,
                        height: 110.0,
                        color: Colors.yellow,
                        margin: EdgeInsets.all(5.0),
                      ),
                    ]),
                    Row(children: [
                      new Container(
                        child: Text('USER 2'),
                        width: 320.0,
                        height: 110.0,
                        color: Colors.yellow,
                        margin: EdgeInsets.all(5.0),
                      ),
                    ]),
                    Row(children: [
                      new Container(
                        child: Text('USER 3'),
                        width: 320.0,
                        height: 110.0,
                        color: Colors.yellow,
                        margin: EdgeInsets.all(5.0),
                      ),
                    ]),
                  ]),
                ],
              ),
            )));
  }
}
