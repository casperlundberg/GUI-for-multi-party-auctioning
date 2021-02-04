import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final Function navigate;
  Profile(this.navigate);

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
            Text(
              'MY PROFILE \n',
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
      ),
    );
  }
}
