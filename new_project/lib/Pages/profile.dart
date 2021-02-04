import 'package:flutter/material.dart';
import '../navigationbar/navbar.dart';
import '../State/user.dart';

class Profile extends StatelessWidget {
  final Function navigate;
  Profile(this.navigate);

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    //final DateTime today = new DateTime.now();

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Edit Profile'),
        actions: <Widget>[
          new Container(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
            child: new MaterialButton(
              color: themeData.primaryColor,
              textColor: themeData.secondaryHeaderColor,
              child: new Text('Save'),
              onPressed: () {
                //_handleSubmitted();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: new Form(
        key: _formKey,
        //autovalidate: _autovalidate,
        //onWillPop: _warnUserAboutInvalidData,
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            new Container(
              child: new TextField(
                decoration: const InputDecoration(
                    labelText: "Username",
                    hintText: "What do people call you?"),
                autocorrect: false,
                onChanged: (String value) {
                  //userName = value;
                },
              ),
            ),
            new Container(
              child: new TextField(
                decoration: const InputDecoration(labelText: "First Name"),
                autocorrect: false,
                onChanged: (String value) {
                  //lastName = value;
                },
              ),
            ),
            new Container(
              child: new TextField(
                decoration: const InputDecoration(labelText: "Last Name"),
                autocorrect: false,
                onChanged: (String value) {
                  //lastName = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
